// 引入连接池模块
const mysql = require("mysql");

// 创建连接池
let pool = mysql.createPool({
  host:"127.0.0.1",
  port:"3306",
  user:"root",
  password:"",
  database:"luckin_coffee",
  connectionLimit:20
})

// 导出连接池
module.exports = pool;
