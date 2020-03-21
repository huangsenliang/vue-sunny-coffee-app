<template>
  <!-- 顶部轮播图：vux保存数据 -->
  <div class="swipe">
    <van-swipe class="my-swipe" :autoplay="3000" indicator-color="white">
      <van-swipe-item v-for="(item,i) of $store.getters.getSwipeDate" :key="i">
        <router-link class="baner" v-if="i==0" :to="{name:'Menu'}">
          <img width="100%" :src="`http://127.0.0.1:5050/${item.imgUrl}`" alt />
        </router-link>
        <router-link v-if="i==1" :to="{name:'Menu'}">
          <img width="100%" :src="`http://127.0.0.1:5050/${item.imgUrl}`" alt />
        </router-link>
        <router-link v-if="i==2" :to="{name:'Cat'}">
          <img :src="`http://127.0.0.1:5050/${item.imgUrl}`" alt />
        </router-link>
        <router-link v-if="i==3" :to="{name:'Personal'}">
          <img :src="`http://127.0.0.1:5050/${item.imgUrl}`" alt />
        </router-link>
      </van-swipe-item>
    </van-swipe>
  </div>
</template>
<script>
export default {
  data(){
    return {
    }
  }
};
</script>

<style scoped>
/* 轮播图 */
.my-swipe .van-swipe-item {
  color: red;
  font-size: 20px;
  text-align: center;
  padding: 5px;
}

.my-swipe .van-swipe-item a {
  width: 100%;
  height: 100%;
}

.my-swipe .van-swipe-item img {
  border-radius: 10px;
  width: 100%;
}
</style>