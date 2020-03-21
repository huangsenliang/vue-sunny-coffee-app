import Vue from "vue";
import App from "./App.vue";
import router from "./router/router";
import store from "./store/vuex";
import axios from "axios";

// 引入全局组件
import Footer from "../src/components/common/Footer";
import Swipe from "../src/components/common/Swipe";
import NavBar from "../src/components/common/NavBar";

// 注册全局组件
Vue.component("footer-view", Footer);
Vue.component("swipe-view", Swipe);
Vue.component("nav-bar", NavBar);

// 引入像素大小配置文件
// import 'lib-flexible'

Vue.config.productionTip = false;

//7:配置访问服务器基础地址
axios.defaults.baseURL = "http://127.0.0.1:5050/";
//8:配置发送请求保存session信息
axios.defaults.withCredentials = true;
//9:将axios注册vue
Vue.prototype.axios = axios;

// 引入vant组件 mpn i -save vant
import vant from "vant";
import "vant/lib/index.css";
// 将mint-ui注册vue
Vue.use(vant);

// // 配置懒加载对象
// Vue.use(vant.Lazyload);

// 注册全局过滤器 20--> ￥20.0
// 功能：拼接符号货币￥
Vue.filter("currency", function(value) {
  if (value) {
    return `￥${value.toFixed(2)}`;
  } else if (value == 0) {
    return `￥${value.toFixed(2)}`;
  } else {
    return "";
  }
});

// 注册全局过滤器 "无糖,无奶,热" --> "无糖/无奶/热"
Vue.filter("typeStr", function(value) {
  // 功能："无糖/无奶/热"
  if (value) {
    let str = value.split(",").join(" / ");
    return "类型：" + str;
  } else if (!value) {
    return "类型：默认";
  }
});

// 注册全局过滤器 :string
Vue.filter("string", function(arr) {
  // 功能：拼接默认的选项字符串
  let newArr = [];
  for (let i = 0; i < arr.length; i++) {
    if (arr[i] !== "") {
      newArr.push(arr[i]);
    }
  }
  let str = newArr.join(" / ");
  if (!str) {
    return "默认:无";
  } else {
    return "默认:" + str;
  }
});

// 注册一个全局自定义指令 `v-focus`
// Vue.directive('focus', {
//   // 当被绑定的元素插入到 DOM 中时……
//   inserted: function (el) {
//     // 聚焦元素
//     el.focus()
//   }
// })

Vue.pro;
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
