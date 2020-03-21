<template>
  <div class="login-user">
    <!-- 引入顶部组件 -->
    <nav-bar :name="'登录'"></nav-bar>
    
    <!-- 输入框 -->
    <div class="input">
      <table></table>
      <div class="input-box">
        <!-- 用户框 -->
        <van-field
          ref="uname"
          right-icon="user-o"
          v-model="uname"
          placeholder="请输入用户名"
        />
        <!-- 密码框 -->
        <van-cell-group>
          <van-field @blur="testPwd" right-icon="star-o" v-model="upwd" placeholder="请输入密码" />
        </van-cell-group>
        <!-- 按钮 -->
        <van-button class="btn" round type="primary" size="large" @click="regLogin">登录</van-button>
        <van-button round type="danger" size="large" @click="exitLogin">退出登录</van-button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      uname: "", // 用户名
      upwd: "" // 密码
      // tname:"",  // 用户名输入框对象
      // tpwd:""     // 密码输入框对象
    };
  },
  methods: {
    // 退出登录
    exitLogin() {
      this.axios.get("/user/exit").then(result => {
        sessionStorage.removeItem("uid")
        if (result.data.code == 200) {
          this.$store.commit("exit");
          this.$router.push({ path: "/personal" });
        }
        this.$toast(result.data.msg);
      });
    },

    // 功能：验证密码6~8位数字、字母
    testPwd(e) {
      // console.log(e);
      // this.tpwd = e.target;
      if (!(/^[a-zA-Z0-9]{6,8}$/.test(this.upwd))) {
        this.$toast("密码为6~8位数字、字母");
      }
    },

    // 功能：验证用户名和密码
    regLogin() {
      let obj = {
        uname: this.uname,
        upwd: this.upwd
      };
      this.axios.post("/user/login", obj).then(res => {
        if (res.data.code == 200) {
          // 在vuex中修改为登录状态
          this.$store.commit("setLogin");
          // 在vuex中保存用户名
          this.$store.commit("setUname", this.uname);
          this.$router.push({ path: "/index" });
          let uid = res.data.uid;
          sessionStorage.setItem('uid',uid)
        }
        this.$toast(res.data.msg);
      });
    }
  },

  // 注意：组件挂载后才能访问到 ref 对象
  // 功能：获取用户输入框的焦点
  mounted() {
    this.$refs.uname.focus();
  }
};
</script>

<style scoped>
.login-user {
  margin-top: 70px;
}
.input {
  width: 100%;
  height: 600px;
  background: #fff;
  padding: 0 20px;
}

.input .input-box {
  margin-top: 60px;
}

.input::before {
  content: "";
  display: block;
  width: 0px;
  height: 0;
}

.input .input-box .btn {
  margin-top: 25px;
}

/* 重写样式 */
.van-cell{
  font-size: 16px !important;
  padding:10px 0;
}
</style>