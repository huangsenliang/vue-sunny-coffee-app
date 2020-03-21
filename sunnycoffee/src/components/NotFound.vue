<template>
  <div class="notfound">
    您要找的页面不存在喔！！将在 <span>{{time}}</span> 后跳转首页
  </div>
</template>

<script>
export default {
  data(){
    return{
      time:5,
      t:"",
    }
  },

  methods:{
    // 功能：实现5秒倒计时，并跳转
    getTime(){
      this.time--;
      if(this.time==0){
        this.$router.push("/index");
         clearInterval(this.t);
      }
    },
  },

  created(){
    this.t = setInterval(() => {
      this.getTime();
    }, 1000);
  }
}
</script>

<style scoped>
  .notfound{
    margin: 20px;
    text-align: left;
    font-size: 16px;
  }

  .notfound span {
    color: indianred;
    font-size: 25px;
  }
</style>