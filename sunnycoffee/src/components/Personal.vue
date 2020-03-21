<template>
  <!-- 登录页面 -->
  <div class="personal">

    <!-- 用户登录状态切换 -->
    <div class="user">
      <div class="user-box">
        <img src="images/img1/rhs.png" alt />
        <div v-if="isLogin">
          <span>{{uname}}</span>
        </div>
        
        <div v-if="!isLogin">
          <router-link :to="{name:'LoginUser'}">
            <span>登录&nbsp;、</span>
          </router-link>
          <router-link :to="{name:'Registered'}">
            <span>注册</span>
          </router-link>
        </div>
        <span>&gt;</span>
      </div>
      <router-link :to="{name:'Login'}" v-if="isLogin">
        <van-icon size="25px" name="setting" />
      </router-link>
    </div>

    <!-- 优惠券 -->
    <div class="coupons">
      <a>
        <p class="text">0元</p>
        <span>账户余额</span>
      </a>
      <a>
        <p>0元</p>
        <span>咖啡钱包</span>
      </a>
      <a>
        <p>0张</p>
        <span>优惠券</span>
      </a>
      <a>
        <p>0张</p>
        <span>礼品卡</span>
      </a>
    </div>

    <!-- 我的订单 -->
    <div class="content">
      <van-cell-group>
        <van-cell title="我的订单" is-link icon="column" />
        <van-cell title="发票管理" is-link icon="coupon" />
        <van-cell title="兑换优惠" is-link icon="send-gift" />
        <van-cell title="企业账户" is-link icon="close" />
        <van-cell title="我的客户" is-link icon="friends" />
      </van-cell-group>
    </div>

    <!-- 广告图片 -->
    <div class="advertising">
      <img src="images/login/20200220164050.png" alt />
    </div>

    <footer-view></footer-view>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isLogin:"",
      uname:""
    };
  },

  methods:{
    // 功能：跳转到His
    jumpHistoryOrder(){
      this.$router.push("/historyOrder");
    }
  },

  // 功能：获取vuex的用户名和登录状态
  created(){
    this.isLogin = this.$store.getters.getIsLogin;
    this.uname = this.$store.getters.getUname;
  }
};
</script>

<style scope>
.personal {
  font-size: 16px;
  padding: 10px;
  text-align: left;
}

.personal .user {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  /* background: rgba(70, 207, 35, 0.226); */
  background: #fff;
  height: 80px;
  border-radius: 10px;
  padding: 8px 20px 8px 8px;
}

.personal .user .user-box {
  display: flex;
  justify-content: space-around;
  align-items: center;
  /* border:1px red solid; */
  width: 60%;
  height: 100%;
}
.personal .user img {
  width: 40px;
  height: 40px;
  border-radius: 50%;
}
.personal .coupons {
  margin-top: 10px;
  display: flex;
  justify-content: space-around;
  background: #fff;
  text-align: center;
  padding: 12px 0;
  border-radius: 10px;
  line-height: 25px;
}
.personal .coupons a {
  width: 25%;
  height: 50px;
  font-size: 14px;
}
.personal .coupons a p {
  color: blue;
}

.personal .content {
  margin-top: 10px;
}

.personal .advertising img {
  margin-top: 15px;
  width: 100%;
  margin-bottom: 70px;
}

/* 重写样式 */
.van-cell {
  font-size: 14px !important;
}
</style>