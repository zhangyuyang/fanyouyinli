mongodb = require("./db")
#
# * GET users listing.
# 

# 邀请表
InviteUser = (invite_user) ->
  @name = invite_user.name
  @e_mail = invite_user.e_mail
  @city = invite_user.city
  @about_me = invite_user.about_me


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
        db.close()
        return callback(err)
      collection.ensureIndex "e_mail",
        unique: true

      collection.insert invite_user,
        safe: true
      , (err, invite_user) ->
        db.close()
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
        db.close()
        return callback(err)
      collection.findOne
        e_mail: e_mail
      , (err, doc) ->
        db.close()
        if doc
          invite_user = new InviteUser(doc)
          callback err, invite_user
        else
          callback err, null
        return

      return

    return

  return

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
  @tag = user.tag

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
        db.close()
        return callback(err)
      
      #为 e_mail 属性添加索引
      collection.ensureIndex "e_mail", unique: true, (err,doc) ->
        if err
          db.close()
          return callback(err)

      
      #写入 Users 文档
      collection.insert user,
        safe: true
      , (err, user) ->
        db.close()
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
        db.close()
        return callback(err)
      
      #查找 e_mail 属性为 e_mail 的文档
      collection.findOne e_mail: e_mail , (err, doc) ->
        db.close()
        if doc
          callback err, doc
        else
          callback err, null


User.update = update = (e_mail, data, callback) ->
  
  #从数据库中更改用户的密码

  mongodb.open (err, db) ->
    if err
      db.close()
      return callback(err)
    
    #读取 User 集合
    db.collection "users", (err, collection) ->
      if err
        db.close()
        return callback(err)
      collection.update
        e_mail: e_mail
      ,
        $set: data
      , (err, doc) ->
        db.close()
        if doc
          #封装文档为 User 对象
          user = new User(doc)
          callback err, user
        else
          callback err, null

# 这里是更新(新增一个数组，即使这个数组存在，也重复添加)操作，可以传入一个变量或者一个MAP操作
User.insert_array = (e_mail, data, callback) ->
  console.log "这里是增加数组的数据库操作"
  console.log data
  mongodb.open (err, db) ->
    if err
      db.close()
      console.log "数据库打开出错"
      console.log err
    else  
    db.collection "users", (err, collection) ->
      if err
        console.log "查询USER表集合"
        db.close()
        return callback(err)
      collection.update 
        e_mail: e_mail
      ,
        $push: data
      , (err, result)->
        db.close()
        console.log "数据库关闭2"
        if err
          callback err, null
        else
          callback err, result

# 这里是更新(数组删除)操作，可以传入一个变量或者一个MAP操作
User.delete_array = delete_array = (e_mail, data, callback) ->
  console.log "这里是删除数组的数据库操作"
  mongodb.open (err, db) ->
    return callback(err)  if err
    
    #读取 User 集合
    db.collection "users", (err, collection) ->
      if err
        db.close()
        return callback(err) 
      collection.update 
        e_mail: e_mail
      , 
        $pull: data   
      , (err, result)->
        db.close()
        console.log "数据库关闭1"
        if err
          console.log "这是删除失败"
          console.log err
          callback err, null
        else
          console.log "这是删除成功"
          callback err, result


