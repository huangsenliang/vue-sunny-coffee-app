// 功能：注册信息请求  /order

// 引入express
const express = require("express");
// 引入连接池
const pool = require("../sql/pool");
// 引入promise对象
const promise = require("promise");
// 创建路由器
var router = express.Router();

/**
 * 功能：1.保存数据到order 订单表（还没有支付成功的）
 * 功能：2.查询此次保存在订单表中商品的oid
 */
router.post("/addOrder", (req, res) => {
  let arrObj = req.body.arrObj;
  let arr = [];
  arrObj.forEach(item => {
    arr.push(
      `(null,${item.user_id},${item.product_id},'${item.product_name}',${item.count},'${item.str_types}')`
    );
  });
  let sql = `insert into luckin_order values ` + arr.join(",");
  pool.query(sql, (err, result) => {
    if (err) throw err;
    if (result.affectedRows > 0) {
      // 功能：查询此次保存的oid字符串，给历史订单表保存
      let n = arr.length; // 查询的数量
      let sql_select = `SELECT oid FROM luckin_order ORDER BY oid DESC LIMIT ?`;
      pool.query(sql_select, [n], (err, result) => {
        if (err) throw err;
        if (result.length > 0) {
          let oids = [];
          result.forEach(item => {
            oids.push(item.oid);
          });
          let str = oids.join(",");
          res.send({ code: 200, msg: str });
        }
      });
    }
  });
});

// 功能：保存数据到history_order中（支付成功的）
router.post("/historyOrder", (req, res) => {
  let oids_str = req.body.oids_str;
  let total = req.body.total;
  let uid = req.body.uid;
  let sql = "insert into luckin_history_order values (null,?,?,?,now())";

  pool.query(sql, [uid, oids_str, total], (err, result) => {
    if (err) throw err;
    if (result.affectedRows > 0) {
      res.send({ code: 200 });
    }
  });
});

// 功能：请求订单列表order
router.get("/", (req, res) => {
  let uid = req.query.uid;
  console.log(uid)
  let sql = "select * from luckin_order where user_id=?";
  pool.query(sql,[uid],(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:200,data:result});
    }
  })
});

module.exports = router;
