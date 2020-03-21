<template>
  <div class="login">
    <nav-bar :name="'登录、注册'"></nav-bar>

    <div class="login-content">
      <!-- 图片 -->
      <div class="tp">
        <van-image round width="100px" height="100px" src="images/login/20200220175438_tx.png" />
      </div>
      
      <!-- 选择按钮 -->
      <div class="btn">
        <div class="btn1">
            <van-button @click="loginUser" round type="primary" block>登录</van-button>
        </div>
          <van-button @click="registered"  round type="info" block>注册</van-button>
      </div>
      
    </div>
  </div>
</template>

<script>
export default {
  methods:{
    // 跳转用户登录页c面
    loginUser(){
      this.$router.push({path:"loginuser"});
    },
      // 跳转注册页面
    registered(){
      this.$router.push({path:"registered"});
    },
  }
};
</script>

<style scoped>
.login {
 margin-top: 70px;
}

.login .login-content{
  background:#fff;
}

.login .login-content .tp{
  display:flex;
  justify-content:center;
  align-items: center;
  height:70px;
}

.login .login-content {
  padding:50px 30px;
}

.login .login-content .btn .btn1 {
  margin-top: 50px;
  margin-bottom: 30px;
}
</style>