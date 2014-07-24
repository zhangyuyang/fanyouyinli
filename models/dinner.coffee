mongodb = require("./db")
Autodb = require("./autodb.coffee")


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
  @city = dinner.city
  @creater = dinner.creater
  # @members = dinner.members
  # @apply_members = dinner.apply_members
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
    city: @city
    creater: @creater
    # apply_members: @apply_members
  db = Autodb.get()
  db.collection "dinners", (err, collection) ->
    if err
      return callback(err)
    collection.insert dinner,
      safe: true
    , (err, dinner) ->
      callback err, dinner
      return


Dinner.save = (dinner, callback)->
  db = Autodb.get() 
  db.collection "dinners", (err, collection) ->
    if err
      return callback(err)
    collection.insert dinner,
      safe: true
    , (err, dinner) ->
      callback err, dinner
      return


Dinner.get = (date, callback) ->
  console.log "dinner的数据库"
  db = Autodb.get()
  db.collection "dinners", (err, collection) ->
    if err
      return callback(err)
    collection.find(date).toArray (err, doc) ->
      if doc
        callback err, doc
      else
        callback err, null

Dinner.get_for_sort = (date, callback) ->
  db = Autodb.get()
  db.collection "dinners", (err, collection) ->
    if err
      return callback(err)
    collection.find(date).toArray (err, doc) ->
      if doc
        callback err, doc
      else
        callback err, null

Dinner.add_dinner = (date, callback) ->
  db = Autodb.get()
  db.collection "dinners", (err, collection) ->
    if err
      return callback(err)
    collection.update
      _id: date.id
    ,
      $addToSet: 
        members: date.members
    , (err, doc) ->
      if doc
        callback err, doc
      else
        callback err, null
 
Dinner.apply_dinner = (date, callback) ->
  db = Autodb.get()
  db.collection "dinners", (err, collection) ->
    if err
      return callback(err)
    collection.update
      _id: date.id
    ,
      $addToSet: 
        apply_members: date.apply_members
    , (err, doc) ->
      if doc
        callback err, doc
      else
        callback err, null

Dinner.authorized_menber = (date, callback) ->
  console.log "authorized_menber数据库"+date
  console.log date
  console.log date.e_mail
  console.log date.dinner_id
  db = Autodb.get()
  db.collection "members", (err, collection) ->
    if err
      return callback(err)
    collection.update date,
      $set:
        flag : "T"
    , (err, doc) ->
      if doc
        console.log "doc"+doc
        callback err, doc
      else
        console.log "err"+err