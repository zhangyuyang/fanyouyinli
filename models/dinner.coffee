mongodb = require("./db")
Dinner = (dinner) ->
  @e_mail = dinner.e_mail
  @dinner_tag = dinner.dinner_tag
  @dining_hours = dinner.dining_hours
  @dining_minute = dinner.dining_minute
  @dining_locations = dinner.dining_locations
  @dining_locations_info = dinner.dining_locations_info
  @dinner_time = dinner.dinner_time
  @number_of_meals = dinner.number_of_meals
  @payment_method = dinner.payment_method
  @string_tag = dinner.string_tag
  @description = dinner.description
  @tel_of_meals = dinner.tel_of_meals
module.exports = Dinner

Dinner::save = (callback)->
  dinner =
    e_mail: @e_mail
    dinner_tag: @dinner_tag
    dining_hours: @dining_hours
    dining_minute: @dining_minute
    dining_locations: @dining_locations
    dining_locations_info: @dining_locations_info
    dinner_time: @dinner_time
    number_of_meals: @number_of_meals
    payment_method: @payment_method
    string_tag: @string_tag
    description: @description
    tel_of_meals: @tel_of_meals
  mongodb.open (err, db)->
    console.log "数据库打开"
    console.log dinner.e_mail
    console.log dinner.dining_hours
    console.log dinner.dining_minute
    return callback(err) if err
    db.collection "dinners", (err, collection)->
      if err
        db.close()
        return callback(err)

      collection.insert dinner,
        safe: true
      , (err, dinner) ->
        db.close()
        callback err, dinner
        return


Dinner.insert_array = (e_mail, data, callback) ->
  console.log "这里是增加数组的数据库操作"
  console.log data
  mongodb.open (err, db) ->
    if err
      db.close()
      console.log "数据库打开出错"
      console.log err
    else  
    db.collection "dinners", (err, collection) ->
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