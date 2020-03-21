<template>
  <div class="tuijian">
    <div class="tuijian-title">
      <span>猜你喜欢</span>
      <p @click="doChange">
        <span class="icon-jiazai iconfont"></span>
        <span>换一批</span>
      </p>
    </div>
    <div class="box-img">
      <router-link :to="`/details/${item.lid}`" class="img1" v-for="(item,i) of lis" :key="i">
        <img :src="`http://127.0.0.1:5050/${item.imgUrl}`" alt />
        <div class="text">
          <p>{{item.lname}}</p>
          <div class="text1">
            <span>￥{{item.price.toFixed(1)}}</span>
            <span>+</span>
          </div>
          <p class="text2">￥{{item.old_price}}</p>
        </div>
      </router-link>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      pno: 1, // 请求页数
      lis: []
    };
  },
  // 接受父组件的值
  props: [],

  methods: {
    doChange() {
      // 功能：点击更换下一批
      this.pno++;
      this.lMore();
    },

    lMore() {
      this.axios.post("/details/sell", { pno: this.pno }).then(result => {
        // 功能：请求加载更多的 “猜一猜的内容”
        this.lis = result.data.data;
      });
    }
  },

  created() {
    this.lMore();
  }
};
</script>

<style scoped>
.tuijian {
  margin-top: 15px;
  background: #fff;
  border-radius: 4%;
  text-align: left;
  padding: 9px 10px 15px;
  font-size: 16px;
}

/* 猜你喜欢 */

.tuijian .tuijian-title {
  display: flex;
  justify-content: space-between;
  line-height: 30px;
  border-bottom: 1px #ddd solid;
  font-size: 15px;
}

.tuijian .tuijian-title .icon-jiazai {
  margin-right: 15px;
}

.tuijian .box-img {
  margin-top: 15px;
  display: flex;
  justify-content: space-between;
}

.tuijian .box-img a {
  width: 32%;
  max-width: 250px;
  box-shadow: 0 0 2px 2px rgba(0, 0, 0, 0.05);
  border-radius: 10px;
}

.tuijian .box-img a img {
  width: 100%;
  height: 80px;
  border-radius: 10px;
}

.tuijian .box-img .img1 .text {
  max-width: 150px;
  text-align: left;
  line-height: 16px;
  padding: 4px;
}

.tuijian .box-img .img1 .text p:nth-child(1) {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  font-size: 12px;
}

.tuijian .box-img .img1 .text .text1 {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.tuijian .box-img .img1 .text .text1 span:nth-child(1) {
  color: orange;
  font-size: 12px;
}

.tuijian .box-img .img1 .text .text1 span:nth-child(2) {
  display: inline-block;
  text-align: center;
  line-height: 15px;
  width: 15px;
  height: 15px;
  background: paleturquoise;
  border-radius: 50%;
  color: #fff;
  margin-right: 5px;
}

.tuijian .box-img .img1 .text .text2 {
  text-decoration: line-through;
  color: #ccc;
  font-size: 12px;
}
</style>