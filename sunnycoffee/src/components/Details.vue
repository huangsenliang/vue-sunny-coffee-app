<template>
  <div class="details">
    <!-- 顶部导航 -->
    <nav-bar :name="'商品详情'"></nav-bar>
    <!-- 顶部图片 -->
    <div class="box" v-if="data">
      <video
        v-if="data.videUrl"
        class="box1"
        controls
        src="https://v.qq.com/x/page/l0546kum1eg.html"
      ></video>
      <img v-else-if="data.imgUrl" class="box1" :src="`http://127.0.0.1:5050/${data.imgUrl}`" alt />
    </div>
    
    <!-- 标题 -->
    <div class="title panel">
      <h3>{{data.lname}}</h3>
      <p>{{data.e_name}}</p>
    </div>

    <!-- 只要有一个就显示 -->
    <div class="panel" v-if="data.heat||data.cream||data.sugar">
      <ul class="wendu" v-if="data.heat">
        <li>温度</li>
        <li @click="getHeat('冰')" :class="heat=='冰'?'active':''">冰</li>
        <li @click="getHeat('热')" :class="heat=='热'?'active':''">热</li>
      </ul>

      <ul class="wendu" v-if="data.cream">
        <li>奶油</li>
        <li @click="getCream('无奶油')" :class="cream=='无奶油'?'active':''">无奶油</li>
        <li @click="getCream('奶油')" :class="cream=='奶油'?'active':''">奶油</li>
      </ul>

      <ul class="wendu" v-if="data.sugar">
        <li>糖</li>
        <li @click="getSugar('全糖')" :class="sugar=='全糖'?'active':''">全糖</li>
        <li @click="getSugar('半糖')" :class="sugar=='半糖'?'active':''">半糖</li>
        <li @click="getSugar('无糖')" :class="sugar=='无糖'?'active':''">无糖</li>
      </ul>
    </div>

    <!-- 大咖说 -->
    <div class="panel" v-if="data.da_ka_shuo">
      <h3>大咖说</h3>
      <div class="dakashuo">{{data.da_ka_shuo}}</div>
    </div>

    <!-- 详情 -->
    <div class="content panel" v-if="data.details">
      <h3>商品详情</h3>
      <div class="text">
        <p>{{data.details}}</p>
        <p class="yuanliao" v-if="data.material">主要原材料：{{data.material}}</p>
        <p v-if="data.size">净含量：{{data.size}}</p>
        <p v-if="data.storage">储存条件：{{data.storage}}</p>
        <p>图片仅供参考，请以实物为准</p>
      </div>
    </div>

    <!-- 添加购物车 -->
    <div class="panel">
      <div class="order">
        <div class="account">
          <h3 class="color-salmon">{{getTotal|currency}}</h3>
          <p>{{{name:data.lname,price:data.price,cream,heat,sugar}|order}}</p>
        </div>

        <!-- 引入添加按钮组件 -->
        <Btn :count="count" @onChange="onChildValue"></Btn>
      </div>
      <div class="btn2">
        <span>冲一赠一</span>
        <span>立即购买</span>
        <span @click="addCart(data.lid)">加入购物车</span>
      </div>
    </div>
  </div>
</template>

<script>
import Btn from "./index/Btn";
export default {
  filters: {
    // 功能：拼接订单标题
    order(obj) {
      let strLis = [];
      // 根据需求拼接好字符串
      strLis.push(obj.name + "￥" + obj.price);
      // 奶油
      if (obj.cream != undefined) {
        if (obj.cream == "奶油") {
          strLis.push(obj.cream + "￥1");
        } else if (obj.cream == "无奶油") {
          strLis.push(obj.cream + "￥0");
        }
      }

      // 温度
      if (obj.hasOwnProperty("heat")) {
        if (obj.heat) {
          strLis.push(obj.heat);
        }
      }

      // 糖
      if (obj.sugar !== undefined) {
        if (obj.sugar == "全糖") {
          strLis.push(obj.sugar + "￥1");
        } else if (obj.sugar == "半糖") {
          strLis.push(obj.sugar + "￥0.5");
        } else if (obj.sugar == "无糖") {
          strLis.push(obj.sugar + "￥0");
        }
      }
      // 去除空的字符串
      let lis = [];
      strLis.forEach(item => {
        if (item) {
          lis.push(item);
        }
      });
      return lis.join(" + "); // 留两个空格
    }
  },
  components: {
    Btn,
  },
  computed: {
    // 功能：监视计算总价格
    getTotal() {
      // 计算总价
      this.total = 0;
      this.total += this.data.price * this.count;
      this.cream == "奶油" ? (this.total += 1) : (this.total += 0);
      this.sugar == "全糖"
        ? (this.total += 1)
        : this.sugar == "半糖"
        ? (this.total += 0.5)
        : (this.total += 0);
      return this.total;
    }
  },
  data() {
    return {
      data: {},    // 请求的全部数据
      total: 0,   // 总价格
      count: 1,  // 商品数量
      cream: "", // 奶油
      sugar: "", // 糖
      heat: "" // 温度
    };
  },
  methods: {
    // 功能：实现单选奶油
    getCream(val) {
      if (val === "奶油") {
        this.cream = "奶油";
      } else if (val === "无奶油") {
        this.cream = "无奶油";
      }
    },

    // 功能：实现单选糖
    getSugar(val) {
      if (val === "全糖") {
        this.sugar = "全糖";
      } else if (val === "半糖") {
        this.sugar = "半糖";
      } else if (val === "无糖") {
        this.sugar = "无糖";
      }
    },

    // 功能：实现单选温度
    getHeat(val) {
      if (val === "冰") {
        this.heat = "冰";
      } else if (val === "热") {
        this.heat = "热";
      }
    },

    // 功能:接受子向父的传值
    onChildValue(val) {
      this.count = val;
    },

    // 功能：点击添加购物车
    addCart(lid) {
      // vuex中获取登录状态
      let isLogin = this.$store.getters.getIsLogin;
      if (!isLogin) {
        this.$toast("请您先登录！！");
        return;
      }
      let uid = sessionStorage.getItem("uid");
      let types = [];
      this.sugar && types.push(this.sugar);
      this.cream && types.push(this.cream);
      this.heat && types.push(this.heat);
      let str_types = types.join(",");
      let obj = {
        uid,
        lid: lid,
        count: this.count,
        str_types: str_types,
        total: this.total,
        product_name: this.data.lname
      };

      this.axios.get("/cart/addCart", { params: obj }).then(result => {
        if (result.data.code == 200) {
          this.$toast(result.data.msg);
        } else if (result.data.code == 201) {
          this.$toast(result.data.msg);
        } else {
          this.$toast("添加失败！！");
        }
      });
    },

  },

  // 功能：接受menu页面的跳转，请求拿取某个商品的详情信息
  created() {
    let lid = this.$route.params.lid;
    let url = "/details?lid=" + lid;
    this.axios.get(url).then(result => {
      // 结构数组
      let [data] = result.data.data;
      this.data = data;
      this.cream = data.cream;
      this.sugar = data.sugar;
      this.heat = data.heat;
    });
  }
};
</script>

<style scoped>
.details {
  background: #f4f4f4;
  text-align: left;
  font-size: 14px;
  padding:0 10px;
}

.details .box {
  background: #fff;
  width: 100%;
  max-width: 1000px;
  height: 250px;
  margin-top: 70px;
}

.details .box .box1 {
  width: 100%;
  height: 100%;
}

/* 标题 */

.details .title {
  line-height: 20px;
}

.panel {
  margin: 15px 0;
  padding: 15px;
  background: #fff;
  border-radius: 12px;
}

/* 温度 */
.details .wendu {
  text-align: center;
  display: flex;
  /* justify-content: space-between; */
}

.details .wendu+.wendu {
  margin-top: 10px;
}

.details .wendu li {
  display: inline-block;
  width: 70px;
  text-align: left;
}

.details .wendu li+li {
  border-radius: 40px;
  background: rgba(0, 0, 0, 0.03);
  text-align: center;
  margin-right: 20px;
   padding:5px
  
}

.active {
  background: #fff !important;
  border: 1px solid greenyellow;
}

/* 大咖说 */
.details .dakashuo {
  margin-left: 20px;
  line-height: 20px;
}

/* 详情内容 */
.content {
  line-height: 20px;
}

.yuanliao {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  max-width: 300px;
}

/* 底部添加购物车 */
.details .order {
  bottom: 0px;
  left: 0px;
  display: flex;
  justify-content: space-between;
  line-height: 25px; 
}

.details .order p {
  max-width: 190px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.btn2 {
  display: flex;
  justify-content: space-between;
}

.btn2 span {
  margin-top: 15px;
  padding:8px 10px;
  border-radius: 40px;
}

.btn2 span:first-child {
  border: tomato 2px solid;
  color: tomato;
}

.btn2 span:nth-child(2) {
  border: steelblue 2px solid;
  color: steelblue;
}

.btn2 span:nth-child(3) {
  background: steelblue;
  color: #fff;
}

/* 共有样式 */
.color-salmon {
  color: salmon;
}
</style>