mongodb = require("./db")
Autodb = require("./autodb.coffee")

Tag = (tag) ->
  @tag_name = tag.tag_name
  @frequency = tag.frequency
module.exports = Tag

Tag::save = (callback)->
  tag =
    tag_name: @tag_name
    frequency: @frequency

  db = Autodb.get()  
  db.collection "tags", (err, collection)->
    if err
      return callback(err)
    collection.insert tag,
      safe: true
    , (err, tag) ->
      callback err, tag
      return

Tag.get_push = (callback) ->
  
  #从数据库中查询出用户的数据
  db = Autodb.get()
  db.collection "tags", (err, collection) ->
    if err
      return callback(err)
    collection.find().sort(frequency: -1).limit(3).toArray (err, doc) ->
      if doc
        callback err, doc
      else
        callback err, null

Tag.get = (tag_name, callback) ->
  
  #从数据库中查询出用户的数据
  db = Autodb.get()
  db.collection "tags", (err, collection) ->
    if err
      return callback(err)
    collection.findOne tag_name: tag_name , (err, doc) ->
      if doc
        callback err, doc
      else
        callback err, null

Tag.update = (tag_name, callback) ->
  
  #从数据库中更改用户的标签 
  db = Autodb.get()    
  db.collection "tags", (err, collection) ->
    if err
      return callback(err)
    collection.update
      tag_name: tag_name
    ,
      $inc: 
        frequency : 1
    , (err, doc) ->
      if doc
        callback err, doc
      else
        callback err, null

