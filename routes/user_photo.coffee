crypto = require("crypto")
InviteUser = require("../models/user")
User = require("../models/user")
fs = require("fs")
gm = require("gm")
module.exports = (app) ->
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

  app.post "/save_photo", (req, res) ->
    
    # res.render('save_photo', {
    #   user : req.session.user,
    #   title: '照片上传',
    #   file_path: file_path
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
        return console.dir(arguments)  if err
        console.log @outname + " created  ::  " + arguments[3]
        return

      gm(file_path).crop(last_width, last_width, last_x, last_y).resize(60, 60).write __dirname + "/../public/small/" + file_email + file_date + "_1.png", (err) ->
        return console.dir(arguments)  if err
        console.log @outname + " created  ::  " + arguments[3]
        return

      gm(file_path).crop(last_width, last_width, last_x, last_y).resize(30, 30).write __dirname + "/../public/small/" + file_email + file_date + "_2.png", (err) ->
        return console.dir(arguments)  if err
        console.log @outname + " created  ::  " + arguments[3]
        return

      
      #数据库操作
      user_photos = new User(
        e_mail: file_email
        photo0: file_email + file_date + "_0.png"
        photo1: file_email + file_date + "_1.png"
        photo2: file_email + file_date + "_2.png"
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
    console.log file_path
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