// 功能：注册信息请求  /user

// 引入express
const express = require("express");
// 引入连接池
const pool = require("../sql/pool");
// 引入promise对象
const promise = require("promise");
// 创建路由器
var router = express.Router();

// 功能：退出登录状态
router.get("/exit",(req,res)=>{
  try{
    // 删除session
    // req.session.uid = "";
    res.send({code:200,msg:"退出成功！！"});
  }catch(err){
    res.send({code:205,msg:"退出异常！！"});
  }
});

// 功能：验证用户登录的用户名和密码
router.post("/login",(req,res)=>{
  let uname = req.body.uname;
  let upwd = req.body.upwd;
  if(!uname){
    res.send({code:203,msg:"用户名不能为空！！"})
    return
  }
  if(!upwd){
    res.send({code:204,msg:"密码不能为空！！"})
    return
  }
  let sql = "select * from luckin_user where uname=? and upwd=?";
  pool.query(sql,[uname,upwd],(err,result)=>{
    if(err) throw err
    if(result.length>0){
      // 保存登录的sission
      req.session.uid = result[0].uid;
      res.send({code:200,msg:"登录成功！！",uid:result[0].uid})
    }else{
      res.send({code:205,msg:"用户名或密码错误！！"})
    }
  });
});

// 功能：注册存储用户信息
router.post("/reg",(req,res)=>{
  // req.session.uid = "";  // 退出登录状态
  let uname = req.body.uname;
  let upwd = req.body.upwd;
  let userName = req.body.userName;
  let phone = req.body.phone;
  let sql = "insert into luckin_user values (null,?,?,?,?)";
  pool.query(sql,[uname,upwd,phone,userName],(err,result)=>{
    if(err) throw err;
    if(result.affectedRows){
      res.send({code:200,msg:"注册成功！！"});
    }
  });
});

// 功能：验证用户名
router.get("/uname",(req,res)=>{
  let uname = req.query.uname;
  let sql = "select * from luckin_user where uname=?";
  pool.query(sql,[uname],(err,result)=>{
    if(err){throw err};
    if(result.length>0){
      res.send({code:201,msg:"用户名已经被注册！！"});
    }
  })
});

// 功能：验证电话号码是否被注册
router.get("/phone",(req,res)=>{
  let phone = req.query.phone;
  let sql = "select phone from luckin_user where phone=?";
  pool.query(sql,[phone],(err,result)=>{
    if(err) throw err
    if(result.length>0){
      res.send({code:202,msg:"电话号码已经被注册！！"});
    }
  });

});



module.exports = router;