import Vue from 'vue'
import VueRouter from 'vue-router'

// 引入主组件
// import Index from "../components/Index";
// import Menu from "../components/Menu";
// import Order from "../components/Order";
// import HistoryOrder from "../components/HistoryOrder";
// import Cart from "../components/Cart";
// import Personal from "../components/Personal";
// import Details from "../components/Details";
// import Login from "../components/Login";
// import LoginUser from "../components/LoginUser";
// import Registered from "../components/Registered";
// import NotFound from "../components/NotFound";


Vue.use(VueRouter)

const routes = [
  {
    path:"/",
    name:"home",
    redirect:"/index"
  },
  
  // 首页
  {
    path: '/index',
    name: 'Index',
    // component:Index,
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "index" */ '../components/Index'),
    meta:{
      keepAlive:true
    }
  },

  // 菜单
  {
    path: '/menu',
    name: 'Menu',
    // component:Menu,
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "menu" */ '../components/Menu'),
    meta:{
      keepAlive:true
    }
  },

  // 订单
  {
    path: '/order',
    name: 'Order',
    // component:Order,
    // props:true,
   // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "order" */ '../components/Order'),
  }, 

  // 历史订单
  {
    path:"/historyOrder",
    name:"historyOrder",
    // component:HistoryOrder,
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "historyorder" */ '../components/HistoryOrder'),
  },

  // 购物车
  {
    path: '/cart',
    name: 'Cart',
    // component:Cart,
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "cart" */ '../components/Cart'),
  },

  // 我
  {
    path: '/personal',
    name: 'Personal',
    // component:Personal,
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "personal" */ '../components/Personal'),
    meta:{
      keepAlive:true
    }
  },

  // 详情页
  {
    path: '/details/:lid',
    name: 'Details',
    // component:Details,
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "details" */ '../components/Details'),
  },

  // 登录页面选择
  {
    path: '/login',
    name: 'Login',
    // component:Login,
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "login" */ '../components/Login'),
    meta:{
      keepAlive:true
    }
  },

  // 注册
  {
    path: '/registered',
    name: 'Registered',
    // component:Registered,
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "registerid" */ '../components/Registered'),
    meta:{
      keepAlive:true
    }
  },

  // 用户登录
  {
    path: '/loginUser',
    name: 'LoginUser',
    // component:LoginUser,
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "loginUser" */ '../components/LoginUser'),
    meta:{
      keepAlive:true
    }
  },

  // 404页面
  {
    path:"*",
    name:"NotFound",
    // component:NotFound,
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "notfound" */ '../components/NotFound'),
    meta:{
      keepAlive:true
    }
  },

]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
