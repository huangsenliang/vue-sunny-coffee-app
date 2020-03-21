<template>
  <div class="bar-nav">
    <span @click="back" class="icon-zuojiantouhui iconfont"></span>
    <span class="title">{{title}}</span>
  </div>
</template>

<script>
export default {
  props:["name"],
  data(){
    return{
      title:this.name
    }
  },
  methods:{
    back() {
      // 返回上一个页面
      this.$router.go(-1);
    },
  }
}
</script>

<style scoped>
  .bar-nav {
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    height: 50px;
    background:#fff;
    line-height: 50px;
    z-index: 6;
    text-align: left;
    /* border-bottom:1px solid rgba(0,0,0,.3); */
    /* box-shadow: 0 0 1px 1px rgba(0,0,0,.03); */
  }

  .icon-zuojiantouhui {
    position: absolute;
    left:10px;
    padding-left: 12px;
  }

  .bar-nav .title {
    position: absolute;
    left: 50%;
    top: 0;
    margin-left: -75px;
    width: 150px;
    text-align: center;
    font-size: 18px;
  }
</style>