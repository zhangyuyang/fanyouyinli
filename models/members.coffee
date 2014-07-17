mongodb = require("./db")

class Members
module.exports = Members

Members.save = (date, callback)->
  # 聚餐参与者表
  console.log "数据库——聚餐参与者表"
  try
    mongodb.open (err, db) ->
      if err
        db.close()
        return callback(err)
      db.collection "members", (err, collection) ->
        if err
          db.close()
          return callback(err)
        collection.insert date,
          safe: true
        , (err, date) ->
          db.close()
          callback err, date
          return
  catch e
    console.log "DB已经打开"
    console.log e


