mongodb = require("./db")

class Autodb
module.exports = Autodb

nowdb = undefined
Autodb.open = ->
	mongodb.open (err, db) ->
		if err
			console.log err
		else	
			console.log "DB连接打开成功"
			nowdb = db

Autodb.get = ->
	return nowdb