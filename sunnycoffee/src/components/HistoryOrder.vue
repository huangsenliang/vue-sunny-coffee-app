<template>
<!-- 历史订单：historyOrder -->
  <div class="historyOrder">
    <!-- 顶部返回导航 -->
    <nav-bar :name="'历史订单'"></nav-bar>

    <van-tabs class="tabs">
      <!-- 全部订单 -->
      <van-tab title="全部">
        <div class="container">
          <!-- 内容标题部分 -->
          <div class="title">
            <p class="style-font-16">华侨大厦(NO.1246)</p>
            <P class="style-color">
              <span>已完成&nbsp;|&nbsp;</span>
              <span class="iconfont icon-trash"></span>
            </P>
          </div>
          <!-- 图片内容部分 -->
          <div class="content" v-for="(item,i) of data" :key="i">
            <div>
              <!-- 上 -->
              <div class="content-t">
                <div class="content-t-l">
                  <img src="../../public/images/img2/1.png" alt />
                  <div>
                    <p class="style-font-16">{{item.product_name}}</p>
                    <p class="style-color">{{item.str_types|typeStr}}</p>
                  </div>
                </div>
                <span class="count style-color">X{{item.count}}</span>
              </div>
            </div>
          </div>
          <!-- 再来一单 -->
          <div class="btn">
            <router-link :to="'/menu'">再来一单</router-link>
          </div>
        </div>
      </van-tab>

      <!-- 立等可取 -->
      <van-tab title="立等可取"></van-tab>

      <!-- 预约订单 -->
      <van-tab title="预约订单"></van-tab>
    </van-tabs>
    <footer-view></footer-view>
  </div>
</template>

<script>
export default {
  data() {
    return {
      data:""
    };
  },

  methods: {
    // 功能：返回上一级
    back() {
      this.$router.go(-1);
    }
  },

  created(){
     // 功能：请求页面数据
     let uid = sessionStorage.getItem("uid");
    this.axios.get(`/order?uid=${uid}`).then(res=>{
      if(res.data.code==200){
        this.data = res.data.data;
      }
    })
  },
};
</script>

<style scoped>
.container {
  font-size: 14px;
  padding: 15px;
  background: #fff;
  border-radius: 20px;
  text-align: left;
  margin-top: 15px;
  margin-bottom: 100px;
}

.tabs {
  margin-top: 50px;
}

/* 标题部分 */
.container .title {
  display: flex;
  justify-content: space-between;
  padding-bottom: 15px;
  border-bottom: 1px solid #ddd;
}

/* 图片内容部分 */
.container .content .title p:nth-child(2) {
  color: rgb(185, 181, 181);
}

.container .content .content-t {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 0;
  border-bottom:1px #ddd solid;
}

.content-t-l {
  display: flex;
  width: 90%;
}

.container .content .content-t .content-t-l img {
  width: 30%;
  max-width: 150px;
  height: 80px;
  margin-right: 10px;
}

.container .content .content-t .content-t-l div {
  padding-top: 10px;
  line-height: 25px;
}

.container .content .content-t .content-t-l div p:nth-child(2) {
  font-size: 12px;
}

.container .content .content-t .count {
  margin-right: 10px;
}

/* 日期时间部分 */
.container .date {
  display: flex;
  justify-content: space-between;
  margin-right: 20px;
  line-height: 75px;
}

/* 再来一单 */
.container .btn {
  display: flex;
  flex-flow:row-reverse;
}

.container .btn a {
  margin-top: 20px;
  border:1px rgb(180, 179, 179) solid;
  padding:8px 20px;
  border-radius: 40px;
}

/* 共有样式 */
.style-color {
  color:rgb(190, 186, 186)
}

.style-font-16 {
  font-size: 16px;
}

/* 重写样式 */
.van-tabs {
  padding: 15px;
}
</style>