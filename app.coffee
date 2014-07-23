###
Module dependencies.路由配置
###
express = require("express")
http = require("http")
path = require("path")
routes = require("./routes")
MongoStore = require("connect-mongo")(express)
settings = require("./settings")
partials = require("express-partials")
flash = require("connect-flash")
growl = require("growl")
app = express()
Autodb = require("./models/autodb.coffee")

# all environments
app.use express.static(path.join(__dirname, "public")) #静态请求URL前面加上public

# development only
app.use express.errorHandler()  if "development" is app.get("env")
app.use express.methodOverride()

# app.use(express.cookieParser());
app.use express.bodyParser(
  keepExtensions: true
  uploadDir: path.join(__dirname, "public/temp")
)

# 照片上传后，保存到的默认路径
app.set "views", __dirname + "/views"
app.set "view engine", "jade"
app.configure "development", ->
  console.log "dev"
  app.use partials()
  app.use express.urlencoded()
  app.use express.json()
  app.use express.logger("dev")
  app.use express.favicon()
  app.set "port", process.env.PORT or 3000
  
  # app.use(require('connect-assets'));
  app.set "views", path.join(__dirname, "views")
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session(
    secret: settings.cookieSecret
    store: new MongoStore(db: settings.db)
  )
  app.use express.static(__dirname + "/public")
  app.use flash()
  return

require("./routes/user_photo") app
require("./routes/user_info") app
require("./routes/page_jump") app
require("./routes/dinner") app
app.use require("connect-assets")()
http.createServer(app).listen app.get("port"), ->
  growl "node app.js 重启成功！"
  console.log "Express server listening on port " + app.get("port")
  Autodb.open()
  return

