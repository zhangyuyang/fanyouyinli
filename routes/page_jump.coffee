crypto = require("crypto")
InviteUser = require("../models/user")
User = require("../models/user")
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
  app.get "/user_label", (req, res) ->
    res.render "user_label",
      user: req.session.user
      success: req.flash("success").toString()
      error: req.flash("error").toString()