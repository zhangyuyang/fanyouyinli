/**
 * Module dependencies.路由配置
 */

var express = require('express');
var http = require('http');
var path = require('path');
var routes = require('./routes');
var MongoStore = require('connect-mongo')(express);
var settings = require('./settings');
var partials = require('express-partials');
var flash = require('connect-flash');  
var growl = require('growl')
var app = express();




// all environments
app.use(express.static(path.join(__dirname, 'public')));  //静态请求URL前面加上public

// development only
if ('development' == app.get('env')) {
	app.use(express.errorHandler());
}
app.use(express.methodOverride());
// app.use(express.cookieParser());
app.use(express.bodyParser({ keepExtensions: true, uploadDir: path.join(__dirname, 'public/temp') }));
// 照片上传后，保存到的默认路径
app.set('views', __dirname + '/views');  
app.set('view engine', 'jade');	



app.configure("dev", function() {
	console.log("dev");
	app.use(partials());
	app.use(express.urlencoded());
	app.use(express.json());
	app.use(express.logger('dev'));
	app.use(express.favicon());
	app.set('port', process.env.PORT || 3000);
	// app.use(require('connect-assets'));
	app.set('views', path.join(__dirname, 'views'));
	app.set('views', __dirname + '/views');
	app.set('view engine', 'jade');
	app.use(express.bodyParser());
	app.use(express.methodOverride());
	app.use(express.cookieParser());
	app.use(express.session({
		secret: settings.cookieSecret,
		store: new MongoStore({
			db: settings.db
		})
	}));
	app.use(express.static(__dirname + '/public'));
	app.use(flash());
		
	
});

require('./routes/index')(app);
app.use(require('connect-assets')());
http.createServer(app).listen(app.get('port'), function() {
	growl('node app.js 重启成功！');
	console.log('Express server listening on port ' + app.get('port'));
});