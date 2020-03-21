// 功能：购物车路由  /cart

// 引入express
const express = require("express");
// 引入连接池
const pool = require("../sql/pool");
// 创建路由对象
let router = express.Router();

// 功能：删除选中的商品数据
router.post("/clear", (req, res) => {
  // 根据购物车cid来进行批量删除
  let cids = req.body.cids;
  let sql = "delete from luckin_cart where cid in (?)";
  pool.query(sql, [cids], (err, result) => {
    if (err) throw err;
    if (result.affectedRows > 0) {
      res.send({ code: 200, msg: "删除成功！！" });
    }
  });
});

// 功能：拿取某个用户的购物车信息 ： 1.唯一标识：uid  2.sql语句多条查询
router.get("/userCart", (req, res) => {
  // 商品lid列表
  let uid = req.query.uid;
  let sql = "select * from luckin_cart where user_id=?";

  // 查询多条商品的信息
  let sql_cart = "select * from luckin_laptop where lid in (?)";
  pool.query(sql, [uid], (err, result) => {
    if (err) throw err;
    if (result.length > 0) {     
      lids = result.map((item, i) => {
        return item.product_id;
      });
      
      // 拿取多个商品信息：筛选添加到对象中
      pool.query(sql_cart, [lids], (err, result2) => {
        if (err) throw err;
        if (result2.length > 0) {
          // 重构数据：拼接对象[{data:{},cartData:{}},{data:{},cartData:{}}]
          result.forEach((item,i)=>{
            result2.forEach((item2)=>{
              if(item.product_id==item2.lid){
                result[i].data = item2
              }
            })
          });
          res.send({ code: 200, data: result });
        }
      });
    } else {
      res.send({ code: 201, msg: "您的购物车空空如也，赶快挑选下吧！！"});
    }
  });
});

// 功能：添加购物车信息
router.get("/addCart", (req, res) => {
  let lid = req.query.lid;  // 商品lid
  let product_name = req.query.product_name  // 商品名字
  let count = req.query.count; // 商品数量
  let uid = req.query.uid; // 用户uid标识
  let str_types = req.query.str_types; // 商品选中类型
  let total = req.query.total; // 总价格
  // 商品购物在购物车中为空时
  let sql_insert = "insert into luckin_cart values (null,?,?,?,?,?,?)";
  // 商品在购物车中不为空时,修改商品信息
  let sql_update =
    "update luckin_cart set str_types=?,total=?,count=? where cid=?";
  // 查询购物车是否为空
  let sql_select =
    "select cid,count,str_types from luckin_cart where product_id=? and user_id=? and str_types=?";

  pool.query(sql_select, [lid, uid,str_types], (err, result) => {
    if (err) throw err;
    if (result.length > 0) {
      // 只有uid lid str_types 都相同的情况下才更新数据，否则新建
      count = parseInt(count) + result[0].count;
      let cid = result[0].cid;
      pool.query(
        sql_update,
        [str_types, total, count, cid],
        (err, result) => {
          if (err) throw err;
          if (result.affectedRows) {
            res.send({ code: 200, msg: "添加成功！！" });
          }
        }
      );
    } else {
      // 没有一样的商品，新建数据，添加购物车
      pool.query(
        sql_insert,
        [product_name,uid, lid, count, str_types, total],
        (err, result) => {
          if (err) throw err;
          if (result.affectedRows) {
            res.send({ code: 200, msg: "添加成功！！" });
          }
        }
      );
    }
  });
});

module.exports = router;
