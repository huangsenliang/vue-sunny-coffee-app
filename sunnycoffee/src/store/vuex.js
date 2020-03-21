import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    isLogin:false,
    swipeDate:{},
    uname:""
  },
  // 获取
  getters:{
    // 功能：获取登录状态
    getIsLogin(state){
      return state.isLogin
    },
    // 功能：获取顶部轮播图数据
    getSwipeDate(state){
      return state.swipeDate
    },
    // 功能：获取用户名
    getUname(state){
      return state.uname
    }

  },
  // 操作
  mutations: {
    // 功能：修改登录状态
    setLogin(state){
      state.isLogin = true;
    },
    // 功能：修改退出状态
    exit(state){
      state.isLogin = false;
    },
    // 功能：保存轮播图数据
    setSwipe(state,swipeDate){
      state.swipeDate = swipeDate;
    },
    // 功能：保存用户名
    setUname(state,uname){
      state.uname = uname;
    },
  },
  actions: {
  },
  modules: {
  }
})
