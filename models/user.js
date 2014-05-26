
/*
 * GET users listing.
 */

var mongodb = require('./db')
// 邀请表
function InviteUser(invite_user) {
    this.name = invite_user.name;
    this.e_mail = invite_user.e_mail;
    this.city = invite_user.city;
    this.about_me = invite_user.about_me;
}   

module.exports = InviteUser;


InviteUser.prototype.save = function save(callback) {
    //将用户数据存入数据库中
    var invite_user = {
        name : this.name,
        e_mail : this.e_mail,
        city : this.city,
        about_me : this.about_me
    };
    console.log(invite_user.e_mail)
    console.log(invite_user.city); //!这里，save的方法名，为什么不加prototype，invite_user就获取不到值

    mongodb.open(function(err, db) {
        if (err) {
            return callback(err);
        }
        //读  InviteUser  集合
        db.collection('invite_users', function(err, collection) {
            if (err) {
                mongodb.close();
                return callback(err);
            };
            //为 name 属性添加索引
            collection.ensureIndex('e_mail', {unique: true});
            //写入 InviteUser 文档
            collection.insert(invite_user, {safe: true}, function(err, invite_user) {
                mongodb.close();
                callback(err, invite_user);
            });
        });
    });
};


InviteUser.get = function get(e_mail, callback) {
    //从数据库中查询出用户的数据
    mongodb.open(function(err, db) {
        if (err) {
            return callback(err);
        };
        //读取 InviteUser 集合
        db.collection('invite_users', function(err, collection) {
            if (err) {
                mongodb.close();
                return  callback(err);
            };
            //查找 e_mail 属性为 e_mail 的文档
            collection.findOne({e_mail: e_mail}, function(err, doc) {
                mongodb.close();
                if (doc) {
                    //封装文档为 InviteUser 对象
                    var invite_user = new InviteUser(doc);
                    callback(err, invite_user);
                } else {
                    callback(err, null);
                }
            });
        });
    });
};

// 注册表  regUser addClass
function User(user) {
    this.e_mail = user.e_mail;
    this.password = user.password;
    this.name = user.name;
    this.sex = user.sex; 
    this.city = user.city;
}

module.exports = User;


User.prototype.save = function save(callback) {
  //  将用户数据存入数据库中
    var user = {
        e_mail : this.e_mail,
        password : this.password,
        name : this.name,
        sex : this.sex, 
        city : this.city
    };

    mongodb.open(function(err, db) {
        if (err) {
            return callback(err);
            console.log("1111111111");
        }
        //读  users  集合
        db.collection('users', function(err, collection) {
            if (err) {
                mongodb.close();
                return callback(err);
            };
            //为 e_mail 属性添加索引
            collection.ensureIndex('e_mail', {unique: true});
            //写入 Users 文档
            collection.insert(user, {safe: true}, function(err, user) {
                mongodb.close();
                callback(err, user);
            });
        });
    });
};


User.get = function get(e_mail, callback) {
    //从数据库中查询出用户的数据
    mongodb.open(function(err, db) {
        if (err) {
            return callback(err);
        };
        //读取 User 集合
        db.collection('users', function(err, collection) {
            if (err) {
                mongodb.close();
                return  callback(err);
            };
            //查找 e_mail 属性为 e_mail 的文档
            collection.findOne({e_mail: e_mail}, function(err, doc) {
                mongodb.close();
                if (doc) {
                    //封装文档为 User 对象
                    var user = new User(doc);
                    callback(err, user);
                } else {
                    callback(err, null);
                }
            });
        });
    });
};

User.update = function update(e_mail, password, callback) {
    //从数据库中更改用户的密码
    mongodb.open(function(err, db) {
        if (err) {
            return callback(err);
        };
        //读取 User 集合
        db.collection('users', function(err, collection) {
            if (err) {
                mongodb.close();
                return  callback(err);
            };
            collection.update({e_mail: e_mail},{"$set":{"password":password}}, function(err, doc) {
                mongodb.close();
                if (doc) {
                    //封装文档为 User 对象
                    var user = new User(doc);
                    callback(err, user);
                } else {
                    callback(err, null);
                }
            });    
        });
    });
};
