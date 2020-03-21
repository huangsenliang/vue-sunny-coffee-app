<template>
  <div class="registered">
    <!-- 引入顶部自定义导航组件 -->
    <nav-bar :name="'注册'"></nav-bar>
    <!-- 内容 -->
    <div class="input">
      <van-toast id="van-toast" />
      <van-cell-group>
        <van-field ref="uname" @blur="testUname" v-model="uname" label="用户名" placeholder="请输入用户名" />
        <van-field
          ref="upwd"
          @blur="testPwd"
          v-model="upwd"
          type="password"
          label="密码"
          placeholder="请输入密码"
        />
        <van-field
          ref="phone"
          @blur="testPhone"
          v-model="phone"
          type="number"
          label="电话"
          placeholder="请输入电话号码"
        />
        <van-field v-model="userName" label="昵称" placeholder="请输入昵称" />
      </van-cell-group>
      <div class="btn">
        <van-button @click="registered()" round type="info" block>注册</van-button>
      </div>
    </div>
    
  </div>
</template>

<script>
export default {
  data() {
    return {
      uname: "", // 用户名
      upwd: "",  // 密码
      phone: "",  // 电话
      userName: ""   // 昵称
    };
  },
  methods: {
    //功能：axios请求 验证电话号码是否注册
    testPhone(e) {
      if (this.phone) {
        if (/^1[3456789]\d{9}$/.test(this.phone)) {
          let url = `/user/phone?phone=${this.phone}`;
          this.axios.get(url).then(res => {
            if (res.data.code == 202) {
              this.$toast(res.data.msg);
              // e.target.focus()
            }
          });
        } else {
          this.$toast("您的手机号码有误喔！！");
          // e.target.focus()
        }
      } else {
        this.$toast("电话不能为空喔！！");
        // e.target.focus()
      }
    },

    // 功能：axios请求验证用户名是否重复
    testUname(e) {
      let url = `/user/uname?uname=${this.uname}`;
      if (this.uname) {
        this.axios.get(url).then(res => {
          if (res.data.code == 201) {
            this.$toast(res.data.msg);
          }
        });
      } else {
        this.$toast("用户名不能为空喔！！");
      }
    },

    // 功能：验证密码6~8位数字、字母
    testPwd(e) {
      if (this.upwd) {
        if (!/^[a-zA-Z0-9]{6,9}$/.test(this.upwd)) {
          this.$toast("密码为6~9位数字、字母");
          this.upwd="";
          // e.target.focus();
        }
      } else {
        this.$toast("密码不能为空喔！！");
        // e.target.focus();
        // this.upwd="";
      }
    },

    // 发送注册验证
    registered() {
      if (!this.uname) {
        this.$toast("姓名不能为空！！");
        return;
      }
      if (!this.upwd) {
        this.$toast("密码不能为空！！");
        return;
      }
      if (!this.phone) {
        this.$toast("电话不能为空！！");
        return;
      }
      if (!this.userName) {
        this.$toast("昵称不能为空！！");
        return;
      }

      let obj = {
        phone: this.phone,
        upwd: this.upwd,
        uname: this.uname,
        userName: this.userName
      };

      this.axios.post("/user/reg", obj).then(res => {
        if (res.data.code) {
          this.$toast(res.data.msg);
          // 在vuex中修改为非登录状态
          this.$store.commit("exit");
          this.$router.push({ path: "/loginuser" });
        }
      });
    }
  },
};
</script>

<style scoped>
.registered {
  margin-top: 70px;
  font-size: 14px;
}

.registered .login-top {
  padding: 15px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 100px;
  border-bottom: 1px #ddd solid;
  background: #fff;
}

.registered .login-top .text {
  width: 53.1%;
  text-align: left;
}

.registered .input {
  height: 800px;
  background: #fff;
  padding: 40px 15px;
  font-size: 16px;
}

.registered .input .btn {
  margin-top: 50px;
}

/* 重写样式 */
.van-cell{
  font-size: 16px !important;
  padding:10px 0;
}
</style>