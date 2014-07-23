mongodb = require("./db")
Autodb = require("./autodb.coffee")

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

  db = Autodb.get()  
  db.collection "invite_users", (err, collection) ->
    if err
      return callback(err)
    collection.ensureIndex "e_mail",
      unique: true

    collection.insert invite_user,
      safe: true
    , (err, invite_user) ->
      callback err, invite_user


InviteUser.get = (e_mail, callback) ->
  db = Autodb.get()
  db.collection "invite_users", (err, collection) ->
    if err
      return callback(err)
    collection.findOne
      e_mail: e_mail
    , (err, doc) ->
      if doc
        invite_user = new InviteUser(doc)
        callback err, invite_user
      else
        callback err, null


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
  @last_dinner_time = user.last_dinner_time
  @dinner_times = user.dinner_times

module.exports = User
User::save = save = (callback) ->
  
  #  将用户数据存入数据库中
  user =
    e_mail: @e_mail
    password: @password
    name: @name
    sex: @sex
    city: @city

  db = Autodb.get()    
  #读  users  集合
  db.collection "users", (err, collection) ->
    if err
      return callback(err)
    #为 e_mail 属性添加索引
    collection.ensureIndex "e_mail", unique: true, (err,doc) ->
      if err
        return callback(err)
    #写入 Users 文档
    collection.insert user,
      safe: true
    , (err, user) ->
      db.close()
      callback err, user


User.get = (e_mail, callback) ->
  console.log "User.get数据库"
  db = Autodb.get()
  # 从数据库中查询出用户的数据
  db.collection "users", (err, collection) ->
    if err
      console.log err
      return callback(err)
  
    #查找 e_mail 属性为 e_mail 的文档
    collection.findOne e_mail: e_mail , (err, doc) ->
      if doc
        callback err, doc
      else
        console.log err
        callback err, null


User.update = (e_mail, data, callback) ->
  
  #从数据库中更改用户的密码

  db = Autodb.get()
    #读取 User 集合
  db.collection "users", (err, collection) ->
    if err
      return callback(err)
    collection.update
      e_mail: e_mail
    ,
      $set: data
    , (err, doc) ->
      if doc
        #封装文档为 User 对象
        user = new User(doc)
        callback err, user
      else
        callback err, null

# 这里是更新(新增一个数组，即使这个数组存在，也重复添加)操作，可以传入一个变量或者一个MAP操作
User.insert_array = (e_mail, data, callback) ->
  db = Autodb.get()
  db.collection "users", (err, collection) ->
    if err
      return callback(err)
    collection.update 
      e_mail: e_mail
    ,
      $push: data
    , (err, result)->
      if err
        callback err, null
      else
        callback err, result

# 这里是更新(数组删除)操作，可以传入一个变量或者一个MAP操作
User.delete_array = (e_mail, data, callback) ->

  db = Autodb.get()
  #读取 User 集合
  db.collection "users", (err, collection) ->
    if err
      return callback(err) 
    collection.update 
      e_mail: e_mail
    , 
      $pull: data   
    , (err, result)->
      if err
        console.log err
        callback err, null
      else
        callback err, result


User.add_dinner = (data, callback) ->
  # 用户最近一次加入聚餐时间，写入数据库
  db = Autodb.get()
  #读取 User 集合
  db.collection "users", (err, collection) ->
    if err
      return callback(err)

    collection.update
      photo0: data.photo0
    ,
      $set:
        last_dinner_time : data.last_dinner_time

    , (err, doc) ->
      if doc
        callback err, doc
      else
        callback err, null

User.add_dinner_times = (data, callback) ->
  # 用户成功加入聚餐后，成功聚餐次数+1
  db = Autodb.get()
    #读取 User 集合
  db.collection "users", (err, collection) ->
    if err
      return callback(err)

    collection.update
      photo0: data.photo0
    ,
      $inc:
        dinner_times : 1

    , (err, doc) ->
      if doc
        callback err, doc
      else
        callback err, null

