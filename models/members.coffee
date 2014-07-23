mongodb = require("./db")
Autodb = require("./autodb.coffee")


class Members
module.exports = Members

Members.save = (date, callback)->
  # 聚餐参与者表
  db = Autodb.get()
  db.collection "members", (err, collection) ->
    if err
      return callback(err)
    collection.insert date,
      safe: true
    , (err, date) ->
      callback err, date
      return
  


Members.get = (date, callback)->
  # 聚餐参与者表
  db = Autodb.get()
  db.collection "members", (err, collection) ->
    if err
      return callback(err)
    collection.find(date).toArray (err, members) ->
      if members
        callback err, members
      else
        callback err, null


