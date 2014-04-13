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


var app = express();




// all environments
app.use(express.static(path.join(__dirname, 'public')));  //静态请求URL前面加上public

// development only
if ('development' == app.get('env')) {
	app.use(express.errorHandler());
}
app.use(express.bodyParser());

app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(express.cookieParser());

app.set('views', path.join(__dirname, 'views'));
//设置模板引擎和页面模板的位置
app.set('views', __dirname + '/views');  
app.set('view engine', 'ejs');	


app.configure(function() {
	app.use(partials());
	app.use(express.urlencoded());
	app.use(express.json());
	app.use(express.logger('dev'));
	app.use(express.favicon());
	app.set('port', process.env.PORT || 3000);
	app.set('views', path.join(__dirname, 'views'));
	app.set('views', __dirname + '/views');
	app.set('view engine', 'ejs');
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

http.createServer(app).listen(app.get('port'), function() {
	console.log('Express server listening on port ' + app.get('port'));
});