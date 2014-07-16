crypto = require("crypto")
InviteUser = require("../models/user")
User = require("../models/user")
Tag = require("../models/tag")
Dinner = require("../models/dinner")
fs = require("fs")
gm = require("gm")
module.exports = (app) ->
  app.get "/logout", (req, res) ->
    req.session.user = null
    req.flash "success", "登出成功"
    res.redirect "/"
    return
  app.get "/reg_success", (req, res) ->
    res.render "reg_success",
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.post "/reg_success", (req, res) ->
    res.redirect "/ifanyor"
    return

  app.get "/neice_success", (req, res) ->
    res.render "neice_success",
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/ifanyor", (req, res) ->
    console.log req.session.city
    res.render "ifanyor",
      title: "我的引力"
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()
    return



  app.get "/iattractive", (req, res) ->
    res.render "iattractive",
      title: "引力圈"
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/isinger", (req, res) ->
    res.render "isinger",
      title: "单身随缘"
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/iring", (req, res) ->
    res.render "iring",
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return

  app.get "/user_info", (req, res) ->
    res.render "user_info",
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()

    return
  app.get "/user_label", (req, res) ->
    push_info1 = undefined
    console.log "1111+"+push_info1
    User.get req.session.user.e_mail, (err, user) ->
      if err
        console.log "错误"+err
      else 
        console.log user.tag
        # 到数据库里读取推送数据
        Tag.get_push (err,push_info) ->
          if err
            console.log err
            push_info = ''
          else
            console.log push_info
            push_info1 = push_info
          res.render "user_label",
            user: req.session.user
            city: req.session.city
            tag: user.tag
            success: req.flash("success").toString()
            error: req.flash("error").toString()
            push_info: push_info1

  app.post "/modify_password", (req, res) ->
    e_mail = req.session.user.e_mail
    current_password = req.body.current_password
    new_password = req.body.new_password
    console.log current_password
    console.log new_password
    User.get e_mail, (err, user) ->
      unless user
        err = "邮箱不存在！"
        req.flash "error", err
        return res.redirect("/modiy_password")
      else
        md5 = crypto.createHash("md5")
        current_password = md5.update(current_password).digest("base64")
        if user.password != current_password
          console.log current_password
          console.log user.password
          err = "原密码不正确"
          req.flash "error", err
          return res.redirect("/modiy_password")
        else
          md5 = crypto.createHash("md5")
          console.log new_password
          password1 = md5.update(new_password).digest("base64")
          User.update e_mail, {password:password1}, (err, user) ->
            if err
              console.log "err"+err
              req.flash "error", err
              res.redirect "/find_password"
            else
              console.log "success"+user
              req.flash "success", "修改密码成功"
              res.redirect "/modiy_password"
            return
