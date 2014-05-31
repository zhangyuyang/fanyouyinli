
#
# * GET users listing.
# 

# 邀请表
InviteUser = (invite_user) ->
  @name = invite_user.name
  @e_mail = invite_user.e_mail
  @city = invite_user.city
  @about_me = invite_user.about_me
  return

#将用户数据存入数据库中
#!这里，save的方法名，为什么不加prototype，invite_user就获取不到值

#读  InviteUser  集合

#为 name 属性添加索引

#写入 InviteUser 文档

#从数据库中查询出用户的数据

#读取 InviteUser 集合

#查找 e_mail 属性为 e_mail 的文档

#封装文档为 InviteUser 对象

# 注册表  regUser addClass
User = (user) ->
  @e_mail = user.e_mail
  @password = user.password
  @name = user.name
  @sex = user.sex
  @city = user.city
  @photo0 = user.photo0
  @photo1 = user.photo1
  @photo2 = user.photo2
  @worded = user.worded
  @studed = user.studed

  return
mongodb = require("./db")
module.exports = InviteUser
InviteUser::save = save = (callback) ->
  invite_user =
    name: @name
    e_mail: @e_mail
    city: @city
    about_me: @about_me

  console.log invite_user.e_mail
  console.log invite_user.city
  mongodb.open (err, db) ->
    return callback(err)  if err
    db.collection "invite_users", (err, collection) ->
      if err
        mongodb.close()
        return callback(err)
      collection.ensureIndex "e_mail",
        unique: true

      collection.insert invite_user,
        safe: true
      , (err, invite_user) ->
        mongodb.close()
        callback err, invite_user
        return

      return

    return

  return

InviteUser.get = get = (e_mail, callback) ->
  mongodb.open (err, db) ->
    return callback(err)  if err
    db.collection "invite_users", (err, collection) ->
      if err
        mongodb.close()
        return callback(err)
      collection.findOne
        e_mail: e_mail
      , (err, doc) ->
        mongodb.close()
        if doc
          invite_user = new InviteUser(doc)
          callback err, invite_user
        else
          callback err, null
        return

      return

    return

  return

module.exports = User
User::save = save = (callback) ->
  
  #  将用户数据存入数据库中
  user =
    e_mail: @e_mail
    password: @password
    name: @name
    sex: @sex
    city: @city

  mongodb.open (err, db) ->
    return callback(err)  if err
    
    #读  users  集合
    db.collection "users", (err, collection) ->
      if err
        mongodb.close()
        return callback(err)
      
      #为 e_mail 属性添加索引
      collection.ensureIndex "e_mail",
        unique: true

      
      #写入 Users 文档
      collection.insert user,
        safe: true
      , (err, user) ->
        mongodb.close()
        callback err, user
        return

      return

    return

  return

User.get = get = (e_mail, callback) ->
  
  #从数据库中查询出用户的数据
  mongodb.open (err, db) ->
    return callback(err)  if err
    
    #读取 User 集合
    db.collection "users", (err, collection) ->
      if err
        mongodb.close()
        return callback(err)
      
      #查找 e_mail 属性为 e_mail 的文档
      collection.findOne
        e_mail: e_mail
      , (err, doc) ->
        mongodb.close()
        if doc
          
          #封装文档为 User 对象
          user = new User(doc)
          callback err, user
        else
          callback err, null
        return

      return

    return

  return

User.update = update = (e_mail, data, callback) ->
  
  #从数据库中更改用户的密码
  console.log data
  console.log e_mail
  mongodb.open (err, db) ->
    return callback(err)  if err
    
    #读取 User 集合
    db.collection "users", (err, collection) ->
      if err
        mongodb.close()
        return callback(err)
      collection.update
        e_mail: e_mail
      ,
        $set: data
      , (err, doc) ->
        console.log "修改密码err："+err+"返回值"+doc
        mongodb.close()
        if doc
          #封装文档为 User 对象
          user = new User(doc)
          callback err, user
        else
          callback err, null
# 这里是数组操作
User.update_array = update_array = (e_mail, data, callback) ->
  
  mongodb.open (err, db) ->
    return callback(err)  if err
    
    #读取 User 集合
    db.collection "users", (err, collection) ->
      if err
        mongodb.close()
        return callback(err) 
      collection.update {e_mail: e_mail}, {$push: data}, (err, result)->
        mongodb.close()
        if err
          callback err, null
        else
          callback err, result