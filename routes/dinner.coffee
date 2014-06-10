crypto = require("crypto")
InviteUser = require("../models/user")
User = require("../models/user")
Tag = require("../models/tag")
Dinner = require("../models/dinner")
fs = require("fs")
gm = require("gm")
validator = require('validator')

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
    console.log dining_hours
    console.log dining_minute
    console.log dinner_time
    console.log number_of_meals
    console.log payment_method
    console.log string_tag
    console.log description
    console.log tel_of_meals

    console.log "这里是服务器端的校验"
    if !validator.isByteLength dinner_tag_input, 2 ,10
      console.log "dinner_tag_input校验不通过"
      req.flash "err", "标题必须在2-50个字节"
      res.redirect "/idinner"
      return false
    if !validator.isByteLength dining_locations_info, 2 ,10 
      console.log "dining_locations_info校验不通过"
      req.flash "err", "地址不超过50个字"
      res.redirect "/idinner"
      return false
    date_reg = /^(?:(?:(?:(?:(?:1[6-9]|[2-9][0-9])?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))([-/.])(?:0?2\1(?:29)))|(?:(?:(?:1[6-9]|[2-9][0-9])?[0-9]{2})([-/.])(?:(?:(?:0?[13578]|1[02])\2(?:31))|(?:(?:0?[13-9]|1[0-2])\2(?:29|30))|(?:(?:0?[1-9])|(?:1[0-2]))\2(?:0?[1-9]|1[0-9]|2[0-8]))))$/
    if !date_reg.test(dinner_time)
      console.log "dinner_time校验不通过"
      req.flash "err", "时间类型不是YYYY-MM-DD"
      res.redirect "/idinner"
      return false
    if !validator.isNumeric number_of_meals
      console.log "number_of_meals校验不通过"
      req.flash "err", "人数必须为1-50位"
      res.redirect "/idinner"
      return false
    if number_of_meals < 0 || number_of_meals > 50
      console.log "number_of_meals校验不通过"
      req.flash "err", "人数必须为1-50位"
      res.redirect "/idinner"
      return false
    if validator.isNull description
      console.log "description校验不通过"
      req.flash "err", "描述为必填"
      res.redirect "/idinner"
      return false
    telphone_reg = /^1[3|5][0-9]\d{4,8}$/
    if !telphone_reg.test(tel_of_meals)
      console.log "tel_of_meals校验不通过"
      req.flash "err", "电话号码填写不正确"
      res.redirect "/idinner"
      return false
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
