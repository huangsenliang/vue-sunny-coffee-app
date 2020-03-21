// 功能：项目配置文件

// 引入express模块
const express = require("express");
// 引入body-parser中间件
const bodyParser = require("body-parser");
// 引入cors中间件 解决跨域问题
const cors = require("cors");
// 引入session模块
const session = require("express-session");

// 创建服务器
let server = express();
// 设置端口
server.listen(5050);

// // 使用cors中间件  解决跨域
// server.use(cors({
//   origin:["*"],
//   // credentials:true,
// }));

//允许跨域程序端口
server.use(cors({
  //允许哪个程序列表 脚手架
  origin:["http://127.0.0.1:8080",
  "http://localhost:8080"],
  //每次请求验证
  credentials:true
}));

// session 加密
server.use(session({
  secret:"@12!31$",
  resave:true,    // 每次请求更新数据
  saveUninitialized:true   // 保存初始化数据
}));

// 要在使用路由的前面使用中间件
// 使用body-parser中间件将post请求的数据格式化为对象
server.use(bodyParser.urlencoded({
  // 不使用扩展的qs模块.而是使用querystring模块格式为对象
  extended: false
}));
server.use(bodyParser.json())

// 托管静态资源到public目录
server.use(express.static('public'));

// 引入路由对象
const indexRouter = require("./routers/index");
const userRouter = require("./routers/user");
const productsRouter = require("./routers/products");
const detailsRouter = require("./routers/details");
const cartRouter = require("./routers/cart");
const orderRouter = require("./routers/order");


// 使用路由对象
server.use("/index", indexRouter);
server.use("/user", userRouter);
server.use("/products",productsRouter);
server.use("/details",detailsRouter);
server.use("/cart",cartRouter);
server.use("/order",orderRouter);