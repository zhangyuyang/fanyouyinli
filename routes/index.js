/*
 * GET home page.
 */

var crypto = require('crypto');
var InviteUser = require('../models/user');
var User = require('../models/user');
var	fs = require('fs');
var gm = require('gm')

module.exports = function(app) {

	app.get('/', function(req, res) {
		res.render('home', {
			title: '首页',
			user: req.session.user,
			success: req.flash('success').toString(),
			error: req.flash('error').toString()
			// layout: false
		});
	});

	app.post('/', function(req, res) {
			var username = req.body.username;
			var e_mail = req.body.e_mail;
			var city = req.body.city;
			var about_me = req.body.about_me;
			var new_invite_user = new InviteUser({
			     name : username,
				 e_mail : e_mail,
				 city : city,
				 about_me : about_me
			});
			    //检查用户名是否已经存在
				InviteUser.get(new_invite_user.e_mail, function(err, invite_user) {
				if (invite_user) {
					err = '邮箱已经存在，请重新申请';
				}	
				if (err) {
					req.flash('error', err);
					return res.redirect('/');
				}
				//如果不存在則新增用戶
				new_invite_user.save(  //!!save方法用了prototype属性，所以使用它打时候，要用User的一个对象user，不能像get方法一样直接用它的类名
					function(err) {
					if (err) {
						console.log(err);
						req.flash('error', err);
						res.redirect('/');
					} else {
						req.session.user = new_invite_user;
						req.flash('success', '申请内测成功');
						res.redirect('/neice_success');
					}
				});
			});
	});
	app.get('/login', function(req, res) {
		res.render('login', {
			title: '用户登入',
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.post('/login', function(req, res) {
		//生成口令的散列值  
		var md5 = crypto.createHash('md5');
		//注意：这里req.body.login_password，body后面，接的是页面元素name的值，不是JS里面，接受元素ID的值，这里容易搞错
		var login_password = md5.update(req.body.login_password).digest('base64');
		User.get(req.body.login_email, function(err, doc) {
			if (!doc) {
				req.flash('error', '用户不存在');
				return res.redirect('/login');
			}
			if (doc.password != login_password) {
				req.flash('error', '用户口令错误');
				return res.redirect('/login');
			}
			req.session.user = doc;
			res.redirect('/ifanyor');
		});
	});
	app.get('/logout', function(req, res) {
		req.session.user = null;
		req.flash('success', '登出成功');
		res.redirect('/');
	});
	app.get('/find_password', function(req, res) {
		res.render('find_password', {
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.post('/find_password', function(req, res) {
		var e_mail = req.body.find_password_email;
		User.get(e_mail, function(err, user) {
			if (!user) {
				err = '邮箱不存在！';
				req.flash('error', err);
				return res.redirect('/find_password');
			} else {
				var old_password = "111111";
				var md5 = crypto.createHash('md5');
				console.log(old_password);
				var new_password = md5.update(old_password).digest('base64');
				User.update(e_mail, new_password, function(err, user) {
					if (err) {
						console.log(err);
						req.flash('error', err);
						res.redirect('/find_password');
					} else {
						req.flash('success', "修改密码成功");
						res.redirect('/');
					};
				});
			};
		});

	});
	app.get('/reg', function(req, res) {
		res.render('reg', {
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.post('/reg', function(req, res) {
			var sex;
			if (req.body.sex == 1) {
				sex = "男";
			};
			if (req.body.sex == 2) {
				sex = "女";
			};
			if (req.body.sex == 3) {
				sex = "其他";
			};
			var md5 = crypto.createHash('md5');
			var reg_password = md5.update(req.body.reg_password).digest('base64');
			var reg_mail = req.body.reg_mail;
			var reg_city = req.body.reg_city;
			var regname = req.body.reg_name;
			var user = new User({
				    e_mail : reg_mail,
				    password : reg_password,
				    name : regname,
				    sex : sex, 
				    city : reg_city
			});
			//检查E-MAIL是否存在
			User.get(user.e_mail, function(err, doc) {
				if (doc) {
					err = '邮箱已经存在，请重新申请';
				}	
				if (err) {
					req.flash('error', err);
					return res.redirect('/reg');
				}
				//如果不存在則新增用戶
				user.save(
					function(err) {
					if (err) {
						console.log(err);
						req.flash('error', err);
						res.redirect('/');
					} else {
						req.session.user = user;
						req.flash('success', '恭喜注册成功');
						res.redirect('/reg_success');
					}
				});
			});
			
	});
	app.get('/reg_success', function(req, res) {
		res.render('reg_success', {
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.post('/reg_success', function(req, res) {
		res.redirect('/ifanyor');
	});
	app.get('/neice_success', function(req, res) {
		res.render('neice_success', {
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.get('/ifanyor', function(req, res) {
		res.render('ifanyor', {
			title: '我的引力',
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.get('/idinner', function(req, res) {
		res.render('idinner', {
			title: '多人聚餐',
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.get('/iattractive', function(req, res) {
		res.render('iattractive', {
			title: '引力圈',
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.get('/isinger', function(req, res) {
		res.render('isinger', {
			title: '单身随缘',
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.get('/iring', function(req, res) {
		res.render('iring', {
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.get('/user_info', function(req, res) {
		res.render('user_info', {
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.get('/user_photo', function(req, res) {
		res.render('user_photo', {
			user: req.session.user,
			success: req.flash('success').toString(),
			error: req.flash('error').toString()
		});
	});
	app.get('/preview_photo', function(req, res) {
		console.log(req.session.user);
		res.render('preview_photo', {
			user: req.session.user,
			success: req.flash('success').toString(),
			error: req.flash('error').toString()
		});
	});
	app.get('/user_history', function(req, res) {
		res.render('user_history', {
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.get('/user_label', function(req, res) {
		res.render('user_label', {
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.get('/modiy_password', function(req, res) {
		res.render('modiy_password', {
			user : req.session.user,
			success : req.flash('success').toString(),
			error : req.flash('error').toString()
		});
	});
	app.post('/save_photo', function(req, res) {
		var file_path = req.session.path;
		var file_email = req.session.user.e_mail;
		var file_date = (new Date()).valueOf(); 
		console.log(file_date);
		// res.render('save_photo', {
		// 	user : req.session.user,
		// 	title: '照片上传',
		// 	file_path: file_path
		// });
		//GM库里的方法，获取上传原图的宽度和高度
		var methods = ["size"];
		var get_image = gm(file_path);
		var source_width, source_height;
		methods.forEach(function(method){
		  get_image[method](function(err, result){
		    source_width = result.width;
		    source_height = result.height;
		    console.log("原图宽度："+source_width);
		    console.log("原图高度："+source_height);
		    crop();
		  });
		});
		// Jcrop获取截图框的顶点坐标 ,这个要写在另一个方法里
		var preview_x, preview_y, preview_width;
		preview_x = req.body.preview_x;
		preview_y = req.body.preview_y;
		preview_width = req.body.preview_width;
		console.log("预览图X坐标顶点"+preview_x);
		console.log("预览图Y坐标顶点"+preview_y);
		console.log("预览图拉伸的宽度（长度）"+preview_width);
		// GM库里的crop截图方法
		function crop(){
			var last_x, last_y, last_width, ratio;
			//constant参数是根据原图与预览图的比例，在竖着放的时候要用到这个参数，因为横着放的时候，CSS给定了图框的宽度为800
			var constant = source_height * (800 / source_width);
			if (source_width / source_height >= 1.87) {
				//如果图片是横着放
				ratio = source_width / 800;
				console.log("横:"+ratio);
				last_x = preview_x * ratio;
				last_y = preview_y * ratio;
				last_width = preview_width * ratio;
			} else {
				//图片是竖着放
				ratio = source_height / constant;
				console.log("竖:"+ratio);
				console.log("竖preview_x:"+preview_x);
				console.log("竖preview_y:"+preview_y);
				console.log("竖preview_width:"+preview_width);
				last_x = preview_x * ratio;
				last_y = preview_y * ratio;
				last_width = preview_width * ratio;
			}
			console.log("source_width: " + source_width);
			console.log("source_height: " + source_height);
			console.log("last_x:"+last_x);
			console.log("last_y:"+last_y);
			console.log("last_width:"+last_width);
			console.log(__dirname);
			gm(file_path).resize(712, 384).write(__dirname + "/../public/small/" + file_email+file_date+"_0.png", function(err){
				if (err) return console.dir(arguments);
    			console.log(this.outname + " created  ::  " + arguments[3]);
			});
			gm(file_path).crop(last_width, last_width, last_x, last_y).resize(60, 60).write(__dirname + "/../public/small/" + file_email+file_date+"_1.png", function(err){
				if (err) return console.dir(arguments);
    			console.log(this.outname + " created  ::  " + arguments[3]);
			});
			gm(file_path).crop(last_width, last_width, last_x, last_y).resize(30, 30).write(__dirname+ "/../public/small/" +file_email+file_date+"_2.png", function(err){
				if (err) return console.dir(arguments);
    			console.log(this.outname + " created  ::  " + arguments[3]);
			});
			//数据库操作
			var test_photo0 = __dirname + "/../public/small/" + file_email+file_date+"_0.png";
			var test_photo1 = 123;
			var user_photos = new User({
				e_mail : file_email,
				photo0 : test_photo0,
				photo1 : __dirname + "/../public/small/" + file_email+file_date+"_1.png",
				photo2 : __dirname+ "/../public/small/" +file_email+file_date+"_2.png"
			});
			console.log("输出user_photos.photo0："+user_photos.photo0);
			User.update(user_photos.e_mail, {
				photo0 : user_photos.photo0,
				photo1 : user_photos.photo1,
				photo2 : user_photos.photo2
			}, function(err, user) {
				if (err) {
					console.log(err);
					req.flash('error', err);
					res.redirect('/user_photo');
				} else {
					req.flash('success', "图片上传成功");
					res.redirect('/user_info');
					};
				});

		}
		

		// console.log("gm_size"+gm_size);
	});
	app.post('/user_photo', function(req, res) {
		var file_path = req.files.file.path;
		//判断上传的照片是否合法
		if (!file_path) {
			req.flash('error', "路径不存在")
			return res.redirect('/preview_photo');
		} else if (req.files.file.type.split('/')[0] != "image") {
			req.flash('error', "上传的文件必须是图片格式")
			return res.redirect('/preview_photo');
		} else if (req.files.file.size >2 * 1024 * 1024) {
			req.flash('error', "上传文件不能大于2M")
			return res.redirect('/preview_photo');
		} else {
			var file_path_name = file_path.split('/');
			var file_path_last = file_path_name[file_path_name.length - 1];
			req.session.path = file_path;
			res.render('user_photo', {
				user: req.session.user,
				title: '照片上传',
				file_path: file_path_last
			});
		}
	});




}