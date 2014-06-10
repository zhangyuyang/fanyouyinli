crypto = require("crypto")
InviteUser = require("../models/user")
User = require("../models/user")
Tag = require("../models/tag")
Dinner = require("../models/dinner")
fs = require("fs")
gm = require("gm")

module.exports = (app) ->
  app.get "/creat_dinner", (req, res) ->
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
          res.render "creat_dinner",
            user: req.session.user
            tag: user.tag
            success: req.flash("success").toString()
            error: req.flash("error").toString()
            push_info: push_info1


  app.post "/creat_dinner", (req, res) ->
    dinner_tag_input = req.body.dinner_tag_input
    dining_locations = req.body.dining_locations
    dining_locations_info = req.body.dining_locations_info
    dining_hours = req.body.hours
    dining_minute = req.body.minute
    dinner_time = req.body.dinner_time_input
    number_of_meals = req.body.number_of_meals
    payment_method = req.body.payment_method
    string_tag = req.body.string_tag
    description = req.body.description
    tel_of_meals = req.body.tel_of_meals
    console.log dinner_tag_input
    console.log dining_locations
    console.log dining_locations_info
    console.log "这里是服务器端的"
    console.log dining_hours
    console.log dining_minute
    console.log dinner_time
    console.log number_of_meals
    console.log payment_method
    console.log string_tag
    console.log description
    console.log tel_of_meals
    console.log "服务器端口结束"

    dinner = new Dinner(
      e_mail: req.session.user.e_mail
      dinner_tag: dinner_tag_input
      dining_hours: dining_hours
      dining_minute: dining_minute
      dining_locations: dining_locations
      dining_locations_info: dining_locations_info
      dinner_time: dinner_time
      number_of_meals: number_of_meals
      payment_method: payment_method
      string_tag: string_tag
      description: description
      tel_of_meals: tel_of_meals
    )
    console.log "dinner."
    console.log dinner.dining_hours
    console.log dinner.dining_minute
    dinner.save (err, dinner) ->
      console.log "新增聚餐"
      if err
        console.log "新增错误"
        console.log err
        req.flash "error", err
        res.redirect "/"
      else
        console.log "新增成功"
        req.session.dinner = dinner
        req.flash "success", "创建聚餐成功"
        res.redirect "/idinner"
      return
