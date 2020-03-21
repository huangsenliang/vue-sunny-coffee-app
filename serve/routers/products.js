// 功能：商品列表请求路由 products

// 引入express
const express = require("express");
// 引入连接池
const pool = require("../sql/pool");
// 创建路由对象
let router = express.Router();

router.get("/family",(req,res)=>{
  // 功能：全部商品家族名称
  let sql = "select fname from luckin_laptop_family where fid<=5";
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:200,data:result});
    }
  });
});

router.get("/list",(req,res)=>{
  // 功能:某一系列的商品列表数据
  let pno = req.query.pno;
  let sql = "select * from luckin_laptop where family_id=?";
  pool.query(sql,[pno],(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:200,data:result});
    }
  });
});



module.exports = router;