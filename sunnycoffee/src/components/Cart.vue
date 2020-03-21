<template>
  <div class="cart-box">
    <nav-bar :name="'购物车'"></nav-bar>
    
    <div class="cart">
      <div class="content">

        <!-- 清空购物车 -->
        <div class="clear">
          <span class="title">购物车列表</span>
          <p @click="clearCart">
            <span class="iconfont icon-trash"></span>
            <span>删除</span>
          </p>
        </div>

        <!-- 购物车列表 -->
        <ul class="list">
          <li v-for="(item,i) of lis" :key="i">
            <input @change="getTotal" v-model="item.check" type="checkbox" class="chexb" />
            <div class="detail">
              <img :src="`http://127.0.0.1:5050/${item.data.imgUrl}`" alt />
              <div class="text">
                <p>{{item.data.lname}}</p>
                <p>{{item.str_types|typeStr}}</p>
                <p>
                  <span>{{item.total|currency}}</span>
                  <span>{{item.data.old_price|currency}}</span>
                </p>
              </div>
            </div>
            <!-- 引入添加按钮组件 -->
            <!-- 添加按钮组件 -->
            <div class="btn">
              <span @click="doJian(i)" class="jian">-</span>
              <span>{{item.count}}</span>
              <span @click="doAdd(i)" class="add">+</span>
            </div>
          </li>
        </ul>

        <!-- 提交订单 -->
        <div class="order">
          <p class="check">
            <input v-model="allChecked" @change="handleChecked" class="chexb" type="checkbox" />&nbsp;全选
          </p>
          <div class="order-left">
            <div class="heji">
              <span>合计：</span>
              <span class="jiage">{{total|currency}}</span>
            </div>
            <button @click="addOrder()">提交订单</button>
          </div>
        </div>
      </div>

      <!-- 猜你喜欢:引入组件 -->
      <Title2></Title2>

    </div>
    <footer-view></footer-view>
  </div>
</template>

<script>
// 推荐组件
import Title2 from "./index/Title2";
export default {
  components: {
    Title2,
  },

  data() {
    return {
      lis: [], // 全部数据列表
      allChecked: false, // 全选按钮状态
      total: 0, // 计算总价格
      checkCids: [] // 选中的子按钮列表 [lid,lid]
    };
  },

  methods: {
    // 功能：点击减去一个商品
    doJian(i) {
      this.lis[i].count--;
      if (this.lis[i].count < 1) {
        this.lis[i].count = 1;
        this.$toast("再减就没有商品了喔！");
        return;
      }
      this.getTotal();
    },

    // 功能：得到选中状态的子按钮
    getCheckCids() {
      this.checkCids = [];
      this.lis.forEach((item, i) => {
        if (item.check) {
          this.checkCids.push(item.cid);
        }
      });
    },

    // 功能：点击添加一个商品
    doAdd(i) {
      this.lis[i].count++;
      this.getTotal();
    },

    /**
     * 功能：提交订单
     * 1.保存数据到roder表
     * 2.把lis数据列表传到Order页面
     */
    addOrder() { 
      let arr = JSON.stringify(this.lis);
      sessionStorage.setItem("cart", arr);
      this.$router.push("/order");
    },

    // 功能：返回
    back() {
      this.$router.go(-1);
    },

    // 功能：计算选择的商品价格
    getTotal() {
      // 监视不了按钮属性，所有不能用computed
      this.total = 0; // 每次提交清0
      this.lis.forEach((item, i) => {
        if (item.check) {
          this.total += item.total * item.count;
        }
      });
    },

    // 功能：全选按钮为选中状态时
    handleChecked() {
      // 思路：根据全选按钮状态循环改变子按钮的状态
      if (this.allChecked) {
        this.lis.forEach((item, i) => {
          item.check = true;
        });
      } else {
        // 功能：全选按钮为非选中状态时
        this.lis.forEach((item, i) => {
          item.check = false;
        });
      }
      this.getTotal();
    },

    // 功能：清空选中的商品
    clearCart() {
      this.getCheckCids();
      let cids = this.checkCids;
      if (cids.length > 0) {
        this.axios.post("/cart/clear", { cids }).then(result => {
          if (result.data.code == 200) {
            this.total = 0;
            this.getCatr();
            this.$toast(result.data.msg);
          }
        });
      } else {
        this.$toast("您还没有选中删除的商品喔！！");
      }
    },

    // 功能：加载购物车数据
    getCatr() {
      let uid = sessionStorage.getItem("uid");
      this.axios.get(`/cart/userCart?uid=${uid}`).then(result => {
        if (result.data.code == 200) {
          this.lis = result.data.data;
          console.log(this.lis)
          // 功能：给每个商品添加唯一的状态变量check，方便后面单选时使用
          this.lis.forEach((item, i) => {
            // 添加属性
            item.check = false;
          });
        } else if (result.data.code == 201) {
          this.lis = [];
          this.$toast(result.data.msg);
        }
      });
    }
  },

  // vuex中获取登录状态
  created() {
    let isLogin = this.$store.getters.getIsLogin;
    if (!isLogin) {
      this.$toast("请您先登录！！");
      this.$router.push("/personal");
    } else {
      this.getCatr();
    }
  }
};
</script>

<style scoped>
.cart-box {
  font-size: 16px;
  width: 100%;
  padding-bottom: 130px;
  background: url(../../public/backgroundImg/cart2.jpg);
}

.cart {
  margin-top: 50px;
  padding: 10px;
  text-align: left;
}

.cart .content {
  background: #fff;
  padding: 10px;
  border-radius: 10px;
  position: relative;
}

/* 清空购物车 */
.cart .content .clear {
  border-bottom: 1px #ddd solid;
  display: flex;
  justify-content: space-between;
  padding: 10px;
  font-size: 16px;
}

/* 字体图标 */
.icon-trash {
  margin-right: 10px;
  font-size: 20px;
}

/* 购物车列表  */
.list li {
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  padding: 10px;
  border-bottom: #aaa 1px solid;
}

.list li .detail {
  width: 60%;
  height: 100%;
  display: flex;
  margin-right: 20px;
}

.list li .detail .select h5 {
  font-size: 20px;
}

.list li .detail img {
  width: 10%px;
  max-width: 150px;
  height: 90px;
  border-radius: 10px;
  margin-right: 5%;
}

.list li .detail .text {
  padding-top: 10px;
  line-height: 25px;
}

.list li .detail .text p:nth-child(1) {
  font-size: 16px;
}

.list li .detail .text p:nth-child(2) {
  width: 175px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  color: #aaa;
  font-size: 12px;
}

.list li .detail .text p:nth-child(3) span:nth-child(1) {
  color: sandybrown;
  font-size: 16px;
}

.list li .detail .text p:nth-child(3) span:nth-child(2) {
  text-decoration: line-through;
  margin-left: 4px;
  font-size: 14px;
}

/* 提交订单修改 */
.order {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 10px;
  background: #fff;
  height: 70px;
  font-size: 15px;
}

.check {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 16px;
}

.order .order-left {
  display: flex;
  align-items: center;
}

.order .order-left .heji {
  margin-right: 10px; 
}

.order .order-left button {
  width: 80px;
  height: 35px;
  border-radius: 40px;
  background: red;
  padding: 5px;
  color: #fff;
  border: 0;
  margin-left: 8px;
}

.order .order-left .jiage {
  font-size: 18px;
  color: red;
}

/* 共有的边框样式 */
.border {
  display: inline-block;
  border: 1px #666 solid;
  width: 30px;
  height: 30px;
  text-align: center;
  line-height: 30px;
  border-radius: 50%;
}

.backgroundColor {
  background: cornflowerblue;
}

/* 单选按钮 */
.chexb {
  display: inline-block;
  margin-right: 10px;
  border-radius: 50%;
  vertical-align:middle;
  border: skyblue 1px solid;
  
}

/* 重写顶部返回样式 */
.van-nav-bar__left {
  font-size: 25px !important;
}

.van-nav-bar__text {
  color: #000;
}

.van-nav-bar__title {
  font-size: 28px;
}

/* 添加数量 按钮 */
.btn {
  display: flex;
  justify-content: space-around;
  align-items: center;
  width: 130px;
  margin-left: 15px;
}

.btn .jian,
.add {
  text-align: center;
  line-height: 20px;
  width: 20px;
  height: 20px;
  border-radius: 50%;
}

.btn .jian {
  color: royalblue;
  border: 1px solid royalblue;
}

.btn .add {
  background: royalblue;
  color: #fff;
}
</style>