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
  @dinner_image_big = dinner.dinner_image_big
  @dinner_image_small = dinner.dinner_image_small
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
    dinner_image_big: @dinner_image_big
    dinner_image_small: @dinner_image_small
  mongodb.open (err, db) ->
    if err
      db.close()
      return callback(err)
    db.collection "dinners", (err, collection) ->
      if err
        db.close()
        return callback(err)
      collection.insert dinner,
        safe: true
      , (err, dinner) ->
        db.close()
        callback err, dinner
        return

Dinner.get = (date, callback) ->
  mongodb.open (err, db) ->
    if err
      db.close()
      return callback(err)
    db.collection "dinners", (err, collection) ->
      if err
        db.close()
        return callback(err)
      collection.find(date).toArray (err, doc) ->
        db.close()
        if doc
          callback err, doc
        else
          callback err, null