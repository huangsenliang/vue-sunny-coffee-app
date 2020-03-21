<template>
  <div class="contanier">
    <div class="carousel">
      <!-- 轮播图 -->
      <swipe-view></swipe-view>
      
      <!-- title -->
      <div class="title">
        <div class="title-box">
          <!-- 上 -->
          <div class="title-top">
            <div class="left" v-if="resTitle[5].imgUrl">
              <router-link :to="{name:'Menu'}" :style="`background-image:url(http://127.0.0.1:8080/${resTitle[5].imgUrl})`">
              </router-link>
            </div>
            <div class="right" v-if="resTitle">
              <router-link
                v-if="resTitle[0].imgUrl"
                class="title-t"
                :to="{name:resTitle[0].linkUrl}"
                :style="`background-image:url(http://127.0.0.1:8080/${resTitle[0].imgUrl})`"
              >{{resTitle[0].title}}</router-link>
              <router-link
                v-if="resTitle[1].imgUrl"
                class="title-t"
                :to="{name:resTitle[1].linkUrl}"
                :style="`background-image:url(http://127.0.0.1:8080/${resTitle[1].imgUrl})`"
              >{{resTitle[1].title}}</router-link>
            </div>
          </div>

          <!-- 下 -->
          <div class="title-bottom">
            <!-- {{resTitle_b}} -->
            <router-link
              class="title-btm"
              :to="{name:item.linkUrl}"
              v-for="(item,i) of resTitle_b"
              :key="i"
              :style="`background-image:url(http://127.0.0.1:8080/${item.imgUrl})`"
            >
              <span class="span1" v-if="item.tip!=''">{{item.tip}}</span>
              <span class="span2">{{item.title}}</span>
            </router-link>
          </div>
        </div>
      </div>

      <!-- title2：为你推荐 -->
      <Title2></Title2>

      <!-- bannar2：轮播2 -->
      <bannar-Title :resbannar2="resbannar2"></bannar-Title>
      
      <!-- title3：瑞幸潮品 -->
      <Title3 :resTitle3="resTitle3"></Title3>
    </div>
    <footer-view></footer-view>
  </div>
</template>

<script>
// 引入Bannar2.vue 子组件
import bannarTitle from "./index/Bannar2";
// 引入Title2.vue 子组件
import Title2 from "./index/Title2";
import Title3 from "./index/Title3";

export default {
  // 注册子组件
  components: {
    bannarTitle,
    Title2,
    Title3
  },
  data() {
    return {
      // 轮播图2
      resbannar2: [],
      // 现在下单
      resTitle: [
        {imgUrl:""},
        {imgUrl:""},
        {imgUrl:""},
        {imgUrl:""},
        {imgUrl:""},
        {imgUrl:""},
      ],
      // 现在下单
      resTitle_b: [],
      // 瑞幸潮品
      resTitle3:[],
    };
  },

  // 页面加载数据
  created() {
    console.log(11)
    this.axios.get("/index/data").then(result => {
      // console.log(result.data.data);
      if(result.data.code==201){
        this.$toast(result.data.msg);
        this.$router.push({path:"/login"})
      }
      let {
        resBannar,
        resTitle,
        resbannar2,
        restitle3
      } = result.data.data;
      this.resTitle3 = restitle3;
      // this.resBannar = resBannar;
      this.resTitle = resTitle;
      this.resbannar2 = resbannar2;
      this.resTitle_b = this.resTitle.slice(-4,-1,3);

      // 保存顶部轮播图数据到vuex
      this.$store.commit("setSwipe",resBannar)

      // console.log(this.resTitle);
      // console.log(this.resTitle_b,33333)
    });
  },

  
};
</script>

<style scope>
.contanier {
  font-size: 25px;
  padding: 8px;
  /* background-color: rgba(0,0,0,.03); */
  padding-bottom: 100px;
  background:url(../../public/backgroundImg/index.jpg);
}

/* title */
.contanier .title {
  margin-top: 10px;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  background: #fff;
  height: 280px;
  border-radius: 4%;
  padding:10px;
}

.contanier .title .title-box {
  height: 100%;
  display: flex;
  flex-direction: column;
  font-size: 25px;
}

/* 上 */
.contanier .title .title-top {
  display: flex;
  justify-content: space-between;
  width: 100%;
  height: 53%;
  margin-bottom: 6px;
  /* border: 1px red solid; */
}

.contanier .title .title-top .left {
  width: 60%;
  height: 100%;
}

.contanier .title .title-top .left a {
  width: 100%;
  height: 100%;
  background-position: center;
  background-size: 100% 100%;
  background-repeat: no-repeat; 
}

.contanier .title .title-top .right {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width: 38.3%;
  height: 100%;
}

.contanier .title .title-top .right .title-t {
  width: 100%;
  height: 62.5px;
  line-height: 50px;
  background-size: 100%;
  background-position: center;
  background-size: 100% 100%;
  background-repeat: no-repeat; 
}

/* 下 */
.title-bottom {
  display: flex;
  justify-content: space-between;
  width: 100%;
  height: 120px;
}

.title-bottom .title-btm {
  position: relative;
  width: 32%;
  height: 120px;
  background-size:100% 100%;
}

.title-bottom .title-btm .span1 {
  position: absolute;
  top: 0;
  left: 0;
  width: 60px;
  padding:5px;
  border-radius: 0 0 8px 0;
  background: pink;
  font-size: 10px;
}

.title-bottom .title-btm .span2 {
line-height: 100px;
}
</style>