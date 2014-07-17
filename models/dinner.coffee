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
  console.log "数据库层save——dinner"
  console.log dinner
  try
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
  catch e
    console.log "DB已经打开"
    console.log e


Dinner.save = (dinner, callback)->
  console.log dinner
  try
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
  catch e
    console.log "DB已经打开"
    console.log e

Dinner.get = (date, callback) ->
  mongodb.close()
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

Dinner.get_for_sort = (date, callback) ->
  console.log date
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

Dinner.add_dinner = (date, callback) ->
  console.log "add_dinner数据库层"
  console.log date
  console.log date.id
  console.log date.members
  mongodb.open (err, db) ->
    if err
      db.close()
      return callback(err)
    db.collection "dinners", (err, collection) ->
      if err
        db.close()
        return callback(err)

      collection.update
        _id: date.id
      ,
        $addToSet: 
          members: date.members
      , (err, doc) ->

        db.close()
        if doc
          callback err, doc
        else
          callback err, null
 
Dinner.apply_dinner = (date, callback) ->
  console.log "apply_dinner数据库"
  console.log date
  console.log date.id
  console.log date.apply_members
  mongodb.open (err, db) ->
    if err
      db.close()
      return callback(err)
    db.collection "dinners", (err, collection) ->
      if err
        db.close()
        return callback(err)

      collection.update
        _id: date.id
      ,
        $addToSet: 
          apply_members: date.apply_members
      , (err, doc) ->
        db.close()
        if doc
          callback err, doc
        else
          callback err, null

Dinner.authorized_menber = (date, callback) ->
  console.log "apply_dinner数据库"
  console.log date
  mongodb.open (err, db) ->
    if err
      db.close()
      return callback(err)
    db.collection "dinners", (err, collection) ->
      if err
        db.close()
        return callback(err)

      collection.update
        _id: date.id
      ,
        $addToSet: 
          apply_members: date.apply_members
      , (err, doc) ->
        db.close()
        if doc
          callback err, doc
        else
          callback err, null