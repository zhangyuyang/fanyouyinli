mongodb = require("./db")
Dinner_members = (Dinner_members) ->
  @id = Dinner_members.id

module.exports = Dinner_members

Dinner_members.save = (date, callback)->
  try
    mongodb.open (err, db) ->
      if err
        db.close()
        return callback(err)
      db.collection "dinners", (err, collection) ->
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