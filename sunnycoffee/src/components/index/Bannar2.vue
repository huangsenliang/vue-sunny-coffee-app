<template>
  <div class="bannar-title">
    <p>新鲜事</p>
    <div class="box-img">
      <router-link :to="{name: i==1?'Personal':'Menu'}" v-for="(item,i) of resbannar2" :key="i">
        <img :src="`http://127.0.0.1:5050/${item.imgUrl}`" alt="">
      </router-link>
    </div>
  </div>
</template>

<script>
export default {
  props:["resbannar2"]
}
</script>

<style scoped>
  .bannar-title {
    font-size: 15px;
    margin-top: 20px;
  }

  .bannar-title p {
    text-align: left;
    line-height: 20px;
  }


  /* 隐藏滚动条 */
  .bannar-title .box-img::-webkit-scrollbar {
    display:none
  }
  

  .bannar-title .box-img {
    display: flex;
    overflow-x:auto; 
  }

  .bannar-title .box-img a img {
    padding: 5px 10px 0 0;
    height: 150px;
    width: 220px;
  }


</style>