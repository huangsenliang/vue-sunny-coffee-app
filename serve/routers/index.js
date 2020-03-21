// 功能：首页请求路由

// 引入express
const express = require("express");
// 引入连接池
const pool = require("../sql/pool");
// 引入promise对象
const promise = require("promise");
// 创建路由器
let router = express.Router();

router.get("/data", (req, res) => {
  let dataObj = {};
  let sql_bannar = "select imgUrl from luckin_coffee_bannar";
  let sql_title = "select imgUrl,title,tip,linkUrl from luckin_coffee_title";
  let sql_bannar2 = "select imgUrl from luckin_coffee_bannar2";
  let sql_title3 = "select * from luckin_coffee_title3";

  // 轮播图bannar
  let promiseObj1 = new promise((resolve, reject) => {
    pool.query(sql_bannar, (err, resBannar) => {
      if (err) throw err;
      if (resBannar.length > 0) {
        dataObj.resBannar = resBannar;
        resolve(resBannar);
      }
    });
  });

  // luckin_coffee_title(异步执行)
  let promiseObj2 = new promise((resolve, reject) => {
    pool.query(sql_title, (err, resTitle) => {
      if (err) throw err;
      if (resTitle.length) {
        dataObj.resTitle = resTitle;
        resolve(resTitle);
      }
    });
  });

  // luckin_coffee_bannar2
  let promiseObj3 = new promise((resolve, reject) => {
    pool.query(sql_bannar2, (err, resbannar2) => {
      if (err) throw err;
      if (resbannar2.length>0) {
        dataObj.resbannar2 = resbannar2;
        resolve(resbannar2);
      }
    });
  });

  // luckin_coffee_title3
  let promiseObj4 = new promise((resolve, reject) => {
    pool.query(sql_title3, (err, restitle3) => {
      if (err) throw err;
      if (restitle3.length>0) {
        dataObj.restitle3 = restitle3;
        resolve(restitle3);
      }
    });
  });

  Promise.all([
    promiseObj1,
    promiseObj2,
    promiseObj3,
    promiseObj4,
  ]).then(res2 => {
    // console.log(dataObj);
    res.send({ code: 200, data: dataObj });
  });
});

module.exports = router;
