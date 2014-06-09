mongodb = require("./db")
Tag = (tag) ->
  @tag_name = tag.tag_name
  @frequency = tag.frequency
module.exports = Tag

Tag::save = (callback)->
  tag =
    tag_name: @tag_name
    frequency: @frequency
  mongodb.open (err, db)->
    console.log "数据库打开"
    return callback(err) if err
    db.collection "tags", (err, collection)->
      console.log "数据库层444444"
      if err
        console.log "数据库层55"
        db.close()
        return callback(err)

      collection.insert tag,
        safe: true
      , (err, tag) ->
        console.log "数据库层6666"
        db.close()
        callback err, tag
        return

Tag.get_push = (callback) ->
  
  #从数据库中查询出用户的数据
  mongodb.open (err, db) ->
    if err
      db.close()
      return callback(err)      
    db.collection "tags", (err, collection) ->
      if err
        db.close()
        return callback(err)
      collection.find().sort(frequency: -1).limit(3).toArray (err, doc) ->
        db.close()
        if doc
          callback err, doc
        else
          callback err, null

Tag.get = (tag_name, callback) ->
  
  #从数据库中查询出用户的数据
  mongodb.open (err, db) ->
    if err
      db.close()
      return callback(err)  
    
    db.collection "tags", (err, collection) ->
      if err
        db.close()
        return callback(err)
      
      collection.findOne tag_name: tag_name , (err, doc) ->
        db.close()
        if doc
          callback err, doc
        else
          callback err, null

Tag.update = (tag_name, callback) ->
  
  #从数据库中更改用户的密码

  mongodb.open (err, db) ->
    return callback(err)  if err
    
    db.collection "tags", (err, collection) ->
      if err
        db.close()
        return callback(err)
      collection.update
        tag_name: tag_name
      ,
        $inc: 
          frequency : 1
      , (err, doc) ->
        db.close()
        if doc
          callback err, doc
        else
          callback err, null

