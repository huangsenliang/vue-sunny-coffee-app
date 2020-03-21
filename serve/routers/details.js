// 功能：商品详情信息请求路由 /details

// 引入express
const express = require("express");
// 引入连接池
const pool = require("../sql/pool");
// 创建路由对象
let router = express.Router();

// 功能：请求某个商品的信息
router.get("/",(req,res)=>{
  let lid = req.query.lid;
  let sql = "select * from luckin_laptop where lid=?";
  pool.query(sql,[lid],(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:200,data:result});
    }
  });
});

// 功能：推荐内容默认3个商品
router.post("/sell",(req,res)=>{
  let pno = req.body.pno;
  let num = 3*pno;
  // 从第num条开始取只取3条，(limit 1,3 -> 是从0开始计算的)  
  let sql = "select * from luckin_laptop limit ?,3";
  pool.query(sql, [num],(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:200,data:result});
    }
  });
});


module.exports = router;