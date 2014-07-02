crypto = require("crypto")
InviteUser = require("../models/user")
User = require("../models/user")
Tag = require("../models/tag")
Dinner = require("../models/dinner")
fs = require("fs")
gm = require("gm")
validator = require('validator')
ObjectID = require('mongodb').ObjectID

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
            console.log errs
            push_info = ''
          else
            console.log push_info
            push_info1 = push_info
          res.render "creat_dinner",
            user: req.session.user
            city: req.session.city
            tag: user.tag
            success: req.flash("success").toString()
            error: req.flash("error").toString()
            push_info: push_info1

  app.post "/get_dinners", (req, res) ->
    console.log "idinner服务器端"
    console.log req.session.city
    Dinner.get 
      city : req.session.city
    , (err, dinners) ->
      if err
        console.log "报错了"
        console.log err
        res.render "idinner",
          city: req.session.city
          error: req.flash("error").toString()
      else
        console.log "查询正确"
        res.json
          dinners: dinners

  app.post "/get_dinners_sort", (req, res) ->
    console.log "idinner服务器端"
    console.log req.session.user.e_mail
    console.log req.body.sort_type
    console.log req.body.sort_flag
    console.log req.session.city
    if req.body.sort_flag == "A"
      Dinner.get_for_sort
        e_mail : req.session.user.e_mail
        payment_method : req.body.sort_type
        city : req.session.city
      , (err, dinners) ->
        if err
          console.log "报错了"
          console.log err
          res.render "idinner",
            city: req.session.city
            error: req.flash("error").toString()
        else
          console.log dinners
          console.log "查询正确"
          res.json
            dinners: dinners
    else if req.body.sort_flag == "B"
      Dinner.get_for_sort
        e_mail : req.session.user.e_mail
        dining_locations : req.body.sort_type
        city : req.session.city
      , (err, dinners) ->
        if err
          console.log "报错了"
          console.log err
          res.render "idinner", 
            city: req.session.city
            error: req.flash("error").toString()
        else
          console.log dinners
          console.log "flag == b"
          res.json
            dinners: dinners


  app.get "/idinner", (req, res) ->
    console.log req.session.city
    res.render "idinner",
      title: "多人聚餐"
      user: req.session.user
      city: req.session.city
      success: req.flash("success").toString()
      error: req.flash("error").toString()
      city: req.session.city


  app.post "/creat_dinner", (req, res) ->
    console.log "到了"
    console.log "服务器层"
    dinner_image = undefined
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
    dinner_image = req.body.dinner_image
    city = req.body.city



    # 去掉图片头文件
    base64Data = dinner_image.replace /^data:image\/\w+;base64,/, ""
    dataBuffer = new Buffer(base64Data, "base64")
    # 为图片编写文件名
    timestamp = (new Date()).valueOf()
    dinner_img_name = req.session.user.e_mail+timestamp+".png"
    fs.writeFile "public/temp/"+dinner_img_name, dataBuffer, (err) ->
      if err
        console.log "聚餐图片保存失败"
        console.log err
      else
        console.log "聚餐图片保存成功"
      return
    # 调用GM库
    new_dirname = __dirname.substring 0, __dirname.length - 7
    console.log new_dirname

    gm(new_dirname + "/public/temp/"+dinner_img_name).resize(406, 263).write __dirname + "/../public/dinner_image/big/" + dinner_img_name, (err) ->
      return console.dir(arguments)  if err
      console.log @outname + " created  ::  " + arguments[3]
      return
    gm(new_dirname + "/public/temp/"+dinner_img_name).resize(203, 132).write __dirname + "/../public/dinner_image/small/" + dinner_img_name, (err) ->
      return console.dir(arguments)  if err
      console.log @outname + " created  ::  " + arguments[3]
      return
    # 修改格式后，图片保存的路径
    dinner_image_big = "dinner_image/big/" + dinner_img_name
    dinner_image_small = "dinner_image/small/" + dinner_img_name
    


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
    if dinner_image == '' || dinner_image == undefined
      console.log "dinner_image校验不通过"
      req.flash "err", "封面不存在"
      res.redirect "/idinner"

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
      dinner_image_big: dinner_image_big
      dinner_image_small: dinner_image_small
      city: city
    )
    dinner.save (err, dinner) ->
      console.log "新增聚餐"
      if err
        console.log "新增错误"
        console.log err
        req.flash "error", err
        res.json
          status: false
      else
        console.log "新增成功"
        # req.session.dinner = dinner
        req.flash "success", "创建聚餐成功"
        res.json
          status: true
      return


  app.get "/idinner/:id", (req, res) ->
    # 这里得到的req.params.id只是字符串，需要包装成ObjectID类型的
    select_id = ObjectID.createFromHexString(req.params.id)
    Dinner.get 
      _id : select_id
    , (err, dinners) ->
      console.log dinners[0]
      if err
        console.log "报错了"
        console.log err
        res.render "idinner",
          error: req.flash("error").toString()
      else
        console.log "查询正确"
        res.render "dinner_list",
              title: "多人聚餐"
              user: req.session.user
              city: req.session.city
              success: req.flash("success").toString()
              error: req.flash("error").toString()
              dinners : dinners

  app.get "/book_table", (req, res) ->
    if req.session.user
      console.log "说明用户登陆了"
    else
      console.log "说明用户没有登陆"
      res.json
        flag : false