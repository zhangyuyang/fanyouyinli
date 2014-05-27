#
# * GET home page.
# 
crypto = require("crypto")
InviteUser = require("../models/user")
User = require("../models/user")
fs = require("fs")
gm = require("gm")
module.exports = (app) ->
  app.get "/", (req, res) ->
    res.render "home",
      title: "首页"
      user: req.session.user
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
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.post "/login", (req, res) ->
    
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
      res.redirect "/ifanyor"
      return

    return

  app.get "/logout", (req, res) ->
    req.session.user = null
    req.flash "success", "登出成功"
    res.redirect "/"
    return

  app.get "/find_password", (req, res) ->
    res.render "find_password",
      user: req.session.user
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
        old_password = "111111"
        md5 = crypto.createHash("md5")
        console.log old_password
        new_password = md5.update(old_password).digest("base64")
        User.update e_mail, new_password, (err, user) ->
          if err
            console.log err
            req.flash "error", err
            res.redirect "/find_password"
          else
            req.flash "success", "修改密码成功"
            res.redirect "/"
          return

      return

    return

  app.get "/reg", (req, res) ->
    res.render "reg",
      user: req.session.user
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
    User.get user.e_mail, (err, doc) ->
      err = "邮箱已经存在，请重新申请"  if doc
      if err
        req.flash "error", err
        return res.redirect("/reg")
      
      #如果不存在則新增用戶
      user.save (err) ->
        if err
          console.log err
          req.flash "error", err
          res.redirect "/"
        else
          req.session.user = user
          req.flash "success", "恭喜注册成功"
          res.redirect "/reg_success"
        return

      return

    return

  app.get "/reg_success", (req, res) ->
    res.render "reg_success",
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.post "/reg_success", (req, res) ->
    res.redirect "/ifanyor"
    return

  app.get "/neice_success", (req, res) ->
    res.render "neice_success",
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/ifanyor", (req, res) ->
    res.render "ifanyor",
      title: "我的引力"
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/idinner", (req, res) ->
    res.render "idinner",
      title: "多人聚餐"
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/iattractive", (req, res) ->
    res.render "iattractive",
      title: "引力圈"
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/isinger", (req, res) ->
    res.render "isinger",
      title: "单身随缘"
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/iring", (req, res) ->
    res.render "iring",
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/user_info", (req, res) ->
    res.render "user_info",
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/user_photo", (req, res) ->
    res.render "user_photo",
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/preview_photo", (req, res) ->
    console.log req.session.user
    res.render "preview_photo",
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/user_history", (req, res) ->
    res.render "user_history",
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/user_label", (req, res) ->
    res.render "user_label",
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/modiy_password", (req, res) ->
    res.render "modiy_password",
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.post "/save_photo", (req, res) ->
    
    # res.render('save_photo', {
    # 	user : req.session.user,
    # 	title: '照片上传',
    # 	file_path: file_path
    # });
    #GM库里的方法，获取上传原图的宽度和高度
    
    # Jcrop获取截图框的顶点坐标 ,这个要写在另一个方法里
    
    # GM库里的crop截图方法
    crop = ->
      last_x = undefined
      last_y = undefined
      last_width = undefined
      ratio = undefined
      
      #constant参数是根据原图与预览图的比例，在竖着放的时候要用到这个参数，因为横着放的时候，CSS给定了图框的宽度为800
      constant = source_height * (800 / source_width)
      if source_width / source_height >= 1.87
        
        #如果图片是横着放
        ratio = source_width / 800
        console.log "横:" + ratio
        last_x = preview_x * ratio
        last_y = preview_y * ratio
        last_width = preview_width * ratio
      else
        
        #图片是竖着放
        ratio = source_height / constant
        console.log "竖:" + ratio
        console.log "竖preview_x:" + preview_x
        console.log "竖preview_y:" + preview_y
        console.log "竖preview_width:" + preview_width
        last_x = preview_x * ratio
        last_y = preview_y * ratio
        last_width = preview_width * ratio
      console.log "source_width: " + source_width
      console.log "source_height: " + source_height
      console.log "last_x:" + last_x
      console.log "last_y:" + last_y
      console.log "last_width:" + last_width
      console.log __dirname
      gm(file_path).resize(712, 384).write __dirname + "/../public/small/" + file_email + file_date + "_0.png", (err) ->
        return console.dir(arguments_)  if err
        console.log @outname + " created  ::  " + arguments_[3]
        return

      gm(file_path).crop(last_width, last_width, last_x, last_y).resize(60, 60).write __dirname + "/../public/small/" + file_email + file_date + "_1.png", (err) ->
        return console.dir(arguments_)  if err
        console.log @outname + " created  ::  " + arguments_[3]
        return

      gm(file_path).crop(last_width, last_width, last_x, last_y).resize(30, 30).write __dirname + "/../public/small/" + file_email + file_date + "_2.png", (err) ->
        return console.dir(arguments_)  if err
        console.log @outname + " created  ::  " + arguments_[3]
        return

      
      #数据库操作
      test_photo0 = __dirname + "/../public/small/" + file_email + file_date + "_0.png"
      test_photo1 = 123
      user_photos = new User(
        e_mail: file_email
        photo0: test_photo0
        photo1: __dirname + "/../public/small/" + file_email + file_date + "_1.png"
        photo2: __dirname + "/../public/small/" + file_email + file_date + "_2.png"
      )
      console.log "输出user_photos.photo0：" + user_photos.photo0
      User.update user_photos.e_mail,
        photo0: user_photos.photo0
        photo1: user_photos.photo1
        photo2: user_photos.photo2
      , (err, user) ->
        if err
          console.log err
          req.flash "error", err
          res.redirect "/user_photo"
        else
          req.flash "success", "图片上传成功"
          res.redirect "/user_info"
        return

      return
    file_path = req.session.path
    file_email = req.session.user.e_mail
    file_date = (new Date()).valueOf()
    console.log file_date
    methods = ["size"]
    get_image = gm(file_path)
    source_width = undefined
    source_height = undefined
    methods.forEach (method) ->
      get_image[method] (err, result) ->
        source_width = result.width
        source_height = result.height
        console.log "原图宽度：" + source_width
        console.log "原图高度：" + source_height
        crop()
        return

      return

    preview_x = undefined
    preview_y = undefined
    preview_width = undefined
    preview_x = req.body.preview_x
    preview_y = req.body.preview_y
    preview_width = req.body.preview_width
    console.log "预览图X坐标顶点" + preview_x
    console.log "预览图Y坐标顶点" + preview_y
    console.log "预览图拉伸的宽度（长度）" + preview_width
    return

  
  # console.log("gm_size"+gm_size);
  app.post "/user_photo", (req, res) ->
    file_path = req.files.file.path
    
    #判断上传的照片是否合法
    unless file_path
      req.flash "error", "路径不存在"
      res.redirect "/preview_photo"
    else unless req.files.file.type.split("/")[0] is "image"
      req.flash "error", "上传的文件必须是图片格式"
      res.redirect "/preview_photo"
    else if req.files.file.size > 2 * 1024 * 1024
      req.flash "error", "上传文件不能大于2M"
      res.redirect "/preview_photo"
    else
      file_path_name = file_path.split("/")
      file_path_last = file_path_name[file_path_name.length - 1]
      req.session.path = file_path
      res.render "user_photo",
        user: req.session.user
        title: "照片上传"
        file_path: file_path_last

    return

  return
