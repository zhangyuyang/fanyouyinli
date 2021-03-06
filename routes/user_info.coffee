crypto = require("crypto")
InviteUser = require("../models/user")
User = require("../models/user")
Tag = require("../models/tag")
fs = require("fs")
gm = require("gm")
Dinner = require("../models/dinner")
module.exports = (app) ->
  app.get "/", (req, res) ->
    console.log '这是历史性的版本'
    req.session.city = "上海"
    console.log req.session.city
    res.render "home",
      title: "首页"
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()
    return
  # layout: false
  app.post "/", (req, res) ->
    username = req.body.username
    e_mail = req.body.e_mail
    city = req.body.city
    about_me = req.body.about_me
    new_invite_user = new InviteUser(
      name: username
      e_mail: e_mail
      city: city
      about_me: about_me
    )
    
    #检查用户名是否已经存在
    InviteUser.get new_invite_user.e_mail, (err, invite_user) ->
      err = "邮箱已经存在，请重新申请"  if invite_user
      if err
        req.flash "error", err
        return res.redirect("/")
      #如果不存在則新增用戶
      #!!save方法用了prototype属性，所以使用它打时候，要用User的一个对象user，不能像get方法一样直接用它的类名
      new_invite_user.save (err) ->
        if err
          console.log err
          req.flash "error", err
          res.redirect "/"
        else
          req.session.user = new_invite_user
          req.flash "success", "申请内测成功"
          res.redirect "/neice_success"
        return
      return
    return

  app.get "/login", (req, res) ->
    res.render "login",
      title: "用户登入"
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/modiy_password", (req, res) ->
    res.render "modiy_password",
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()
    return

  app.post "/login", (req, res) ->
    console.log req.session.city
    #生成口令的散列值  
    md5 = crypto.createHash("md5")
    #注意：这里req.body.login_password，body后面，接的是页面元素name的值，不是JS里面，接受元素ID的值，这里容易搞错
    login_password = md5.update(req.body.login_password).digest("base64")
    User.get req.body.login_email, (err, doc) ->
      unless doc
        req.flash "error", "用户不存在"
        return res.redirect("/login")
      unless doc.password is login_password
        req.flash "error", "用户口令错误"
        return res.redirect("/login")
      req.session.user = doc
      req.session.city = req.session.city
      res.redirect "/ifanyor"
      return

  app.post "/hidden_login", (req, res) ->
    console.log req.session.city
    console.log req.body.hidden_login_password
    # 生成口令的散列值  
    md5 = crypto.createHash("md5")
    #注意：这里req.body.login_password，body后面，接的是页面元素name的值，不是JS里面，接受元素ID的值，这里容易搞错
    login_password = md5.update(req.body.hidden_login_password).digest("base64")
    User.get req.body.hidden_login_email, (err, doc) ->
      unless doc
        req.flash "error", "用户不存在"
        res.json
          status: false
          tips: "用户不存在"
        return
      unless doc.password is login_password
        req.flash "error", "用户密码错误"
        res.json
          status: false
          tips: "用户密码错误"
        return
      req.session.user = doc
      req.session.city = doc.city
      res.json
        status: true
        tips: "登陆成功"
        city: doc.city
      return



  app.get "/find_password", (req, res) ->
    res.render "find_password",
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()
    return

  app.post "/find_password", (req, res) ->
    e_mail = req.body.find_password_email
    User.get e_mail, (err, user) ->
      unless user
        err = "邮箱不存在！"
        req.flash "error", err
        return res.redirect("/find_password")
      else
        old_password = "333333"
        md5 = crypto.createHash("md5")
        console.log old_password
        new_password = md5.update(old_password).digest("base64")
        User.update e_mail, {password:new_password}, (err, user) ->
          if err
            console.log "err"+err
            req.flash "error", err
            res.redirect "/find_password"
          else
            console.log "success"+user
            req.flash "success", "修改密码成功"
            res.redirect "/"
          return

  app.post "/modify_info", (req, res) ->
    console.log req.session.user.e_mail
    console.log req.body.name
    console.log req.body.province
    console.log req.body.city
    console.log req.body.sex
    console.log req.body.marry
    console.log req.body.year
    console.log req.body.month
    console.log req.body.day
    console.log req.body.myself
    User.update req.session.user.e_mail,
      name : req.body.name
      province : req.body.province
      city : req.body.city
      sex : req.body.sex
      marry : req.body.marry
      year : req.body.year
      month : req.body.month
      day : req.body.day
      introduce : req.body.myself
    , (err, doc) ->
      if err
        console.log "err"+err
        res.json
          flag : false
      else
        console.log "doc"+doc
        res.json
          flag : true

  app.get "/reg", (req, res) ->
    res.render "reg",
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()
    return

  app.post "/reg", (req, res) ->
    sex = undefined
    sex = "男"  if req.body.sex is 1
    sex = "女"  if req.body.sex is 2
    sex = "其他"  if req.body.sex is 3
    md5 = crypto.createHash("md5")
    reg_password = md5.update(req.body.reg_password).digest("base64")
    reg_mail = req.body.reg_mail
    reg_city = req.body.reg_city
    regname = req.body.reg_name
    
    user = new User(
      e_mail: reg_mail
      password: reg_password
      name: regname
      sex: sex
      city: reg_city
    )
    
    #检查E-MAIL是否存在
    User.get reg_mail, (err, doc) ->
      console.log "检验EMAIL是否存在"
      if err
        err = "邮箱已经存在，请重新申请"  
        req.flash "error", err
        return res.redirect("/reg")
      
      #如果不存在則新增用戶
      user.save (err) ->
        console.log "新增用户"
        if err
          console.log "新增错误"
          console.log err
          req.flash "error", err
          res.redirect "/"
        else
          req.session.user = user
          req.flash "success", "恭喜注册成功"
          res.redirect "/reg_success"
        return

  app.get "/user_history", (req, res) ->
    console.log req.session.user.e_mail
    User.get req.session.user.e_mail, (err, user) ->
      if err
        console.log "错误"+err
      else 
        console.log user.worked
      res.render "user_history",
        user: req.session.user
        city: req.session.city
        success: req.flash("success").toString()
        error: req.flash("error").toString()
        worked : user.worked
        study : user.study



  app.post "/insert_worked", (req, res) ->
    company_name = req.body.company_name
    work_year_s = req.body.work_year_s
    work_year_e = req.body.work_year_e
    job = req.body.job    
    say_some = req.body.say_some
    creat_time = req.body.creat_time

    User.insert_array req.session.user.e_mail,
      worked: {
        company_name : company_name,
        work_year_s : work_year_s,
        work_year_e : work_year_e,
        job : job,
        say_some : say_some,
        creat_time : creat_time
      }
    , (err, user) ->
      if err
        req.flash "error", err
      else
        res.json
          company_name : company_name,
          work_year_s : work_year_s,
          work_year_e : work_year_e,
          job : job,
          say_some : say_some,
          creat_time : creat_time
      return


  app.post "/delete_work", (req, res) ->
    company_name = req.body.company_name
    work_year_s = req.body.work_year_s
    work_year_e = req.body.work_year_e
    job = req.body.job    
    say_some = req.body.say_some
    creat_time = req.body.creat_time

    User.delete_array req.session.user.e_mail,
      worked: {
        company_name : company_name,
        work_year_s : work_year_s,
        work_year_e : work_year_e,
        job : job,
        say_some : say_some,
        creat_time : creat_time
      }
    , (err, info) ->
      if err
        console.log "删除数据失败"+info
        res.json
          status : false
      else
        console.log "删除数据成功"+info
        res.json
          status : true
      return





  app.post "/insert_study", (req, res) ->
    school_type = req.body.school_type
    school = req.body.school
    specialty = req.body.specialty
    remember = req.body.remember    
    creat_time = req.body.creat_time

    User.insert_array req.session.user.e_mail,
      study: {
        school_type : school_type,
        school : school,
        specialty : specialty,
        remember : remember,
        creat_time : creat_time
      }
    , (err, user) ->
      if err
        req.flash "error", err
      else
        res.json
          school_type : school_type,
          school : school,
          specialty : specialty,
          remember : remember,
          creat_time : creat_time
      return


  app.post "/delete_study", (req, res) ->
    school_type = req.body.school_type
    school = req.body.school
    specialty = req.body.specialty
    remember = req.body.remember    
    creat_time = req.body.creat_time

    User.delete_array req.session.user.e_mail,
      study: {
        school_type : school_type,
        school : school,
        specialty : specialty,
        remember : remember,
        creat_time : creat_time
      }
    , (err, info) ->
      if err
        console.log "删除数据失败"+info
        res.json
          status : false
      else
        console.log "删除数据成功"+info
        res.json
          status : true
      return

  app.post "/add_tag", (req, res) ->
    console.log "插入用户表"
    my_tag = req.body.my_tag
    User.insert_array req.session.user.e_mail,
      tag: my_tag
    , (err, user) ->
      if err
        console.log err
      else 
        console.log "判断标签是否存在标签表"
        Tag.get my_tag, (err,result) ->
          if err
            console.log err
            res.json
              status : false
          else
            console.log "标签表是否存在"+result
            if result is null
              console.log "result[null]"
              tag = new Tag(
                tag_name : my_tag
                frequency : 1
                )
              tag.save (err) ->
                console.log "标签保存到标签表里"
                if err
                  console.log errs
                  res.json
                    status : false
                else
                  console.log "标签成功进表浅表，应该没问题"
                  res.json
                    status : true
                  console.log "AAAAAA"
            else
              Tag.update my_tag, (err,result) ->
                if err
                  console.log "6666"
                  console.log err
                  res.json
                    status : false
                else 
                  console.log "77777"
                  console.log "success"
                  res.json
                    status : true

  app.post "/delete_tag", (req, res) ->
    tag = req.body.tag
    console.log tag
    User.delete_array req.session.user.e_mail,
      tag: tag
    , (err, info) ->
      if err
        console.log "删除数据失败"+info
        res.json
          status : false
      else
        console.log "删除数据成功"+info
        res.json
          status : true
      return

  app.post "/modify_user_city", (req, res) ->
    console.log "进入modify_user_city"
    city = req.body.city
    console.log req.body.city
    try
      e_mail = req.session.user.e_mail
    catch e
      e_mail = "ceshi@qq.com"
    User.update e_mail,
      city : city
    , (err, doc) ->
      if err
        console.log "报错了"
        console.log err
        res.render "/",
          city: req.session.city
          error: req.flash("error").toString()
      else
        req.session.city = req.body.city
        console.log "modify_user_city查询正确"
        console.log req.session.city
        console.log doc
        res.json
          status : true
          city: req.session.city

  app.post "/user_get", (req, res) ->
    console.log "进入了服务器 /user_get"
    User.get req.body.e_mail, (err, doc) ->
      if err
        console.log "报错了"
        console.log err
      else
        console.log "/user_get成功了"
        console.log doc
        res.json
          user : doc