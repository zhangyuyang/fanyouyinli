/*
 * GET home page.
 */

var crypto = require('crypto');
var InviteUser = require('../models/user');
var User = require('../models/user');
var	fs = require('fs');

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
	app.post('/user_photo', function(req, res) {
		var file_path = req.files.file.path;
		console.log(req.files.file.type);
		if (!file_path) {
			req.flash('error', "路径不存在")
			return res.redirect('/user_photo');
		} else if (req.files.file.type.split('/')[0] != "image") {
			req.flash('error', "上传的文件必须是图片格式")
			return res.redirect('/user_photo');
		} else if (req.files.file.size >2 * 1024 * 1024) {
			req.flash('error', "上传文件不能大于2M")
			return res.redirect('/user_photo');
		} else {
			console.log(req.files.file.size);
			var file_path = file_path.split('/');
			var file_path_last = file_path[file_path.length - 1];
			res.render('user_photo', {
				user : req.session.user,
				title: '照片上传',
				file_path: file_path_last
			});
		}
	});
}