<template>
  <!-- 订单页面 -->
  <div class="order">
    <!-- 顶部导航页面 -->
    <nav-bar :name="'确认订单'"></nav-bar>
    <!-- 主体内容 -->
    <div class="container">
      <p>
        立即自取 约
        <span class="color-218">{{getTime()}}</span>可取
      </p>

      <!-- 地理位置盒子 -->
      <div class="panel map">
        <!-- 地理信息 -->
        <div class="map-content">
          <span class="icon-location iconfont"></span>
          <div>
            <p>天宫院凯德MALL店(No.1731)</p>
            <p class="color-85">大兴区新源大街凯德MALL商店</p>
          </div>
        </div>
        <van-switch active-color="#fff" inactive-color="blue" />
      </div>

      <!-- 商品列表 -->
      <div class="lis panel">
        <div class="item" v-for="(item,i) of data" :key="i">
          <!-- 左边详情 -->
          <div class="item-l">
            <div class="item-l-l">
              <img :src="`http://127.0.0.1:5050/${item.data.imgUrl}`" />
              <div>
                <h5>{{item.data.lname}}</h5>
                <p class="text-hidden">{{item.str_types|typeStr}}</p>
              </div>
            </div>
            <span class="color-85">x{{item.count}}</span>
          </div>
          <!-- 右边价格 -->
          <span>{{item.total|currency}}</span>
        </div>
        <!-- 合计 -->
        <div class="total">
          合计：
          <span>{{total|currency}}</span>
        </div>
      </div>

      <!-- 优惠券 -->
      <div class="coupons panel">
        <div class="coupons-t">
          <div class="coupons-t-t">
            <p>
              用咖啡钱包
              <span class="color-218">充1赠1</span>，立享优惠
            </p>
            <span class="font-35 iconfont icon-you color-218"></span>
          </div>
        </div>
        <!-- 优惠券单元格 -->
        <van-coupon-cell :coupons="coupons" :chosen-coupon="chosenCoupon" @click="showList = true" />
        <!-- 优惠券列表 -->
        <van-popup
          v-model="showList"
          round
          position="bottom"
          style="height: 90%; padding-top: 4px;"
        >
          <van-coupon-list
            :coupons="coupons"
            :chosen-coupon="chosenCoupon"
            :disabled-coupons="disabledCoupons"
            @change="onChange"
          />
        </van-popup>
      </div>

      <!-- 支付 -->
      <div class="pay panel" @click="show = true">
        <span>支付方式</span>
        <p class="pay-r">
          <span :class="[payLis[n].tb,'iconfont']">&nbsp;&nbsp;{{payLis[n].name}}</span>
          <span class="font-35 icon-you iconfont color-85"></span>
        </p>
      </div>

      <!-- 取餐方式 -->
      <div class="way panel">
        <ul class="way-t flex-between">
          <li>取餐方式</li>
          <li>
            <span
              @click="togIsWay"
              :class="{
            'icon-xuanzhong':!isWay,
            'icon-xuanzhong1':isWay,
            iconfont:true
            }"
            ></span>
            店内用餐
          </li>
          <li>
            <span
              @click="togIsWay"
              :class="{
            'icon-xuanzhong':isWay,
            'icon-xuanzhong1':!isWay,
            iconfont:true
            }"
            ></span>
            自提带走
          </li>
        </ul>
        <div class="flex-between yaoqiu">
          <p>备注特殊要求</p>
          <span class="font-35 icon-you iconfont color-85"></span>
        </div>
      </div>

      <!-- 支付说明 -->
      <div class="tip">
        <div class="tip-t">
          <span
            style="width:18px;height:18px"
            @click="togIsRead"
            :class="{
            'icon-xuanzhong':!isRead,
            'icon-xuanzhong1':isRead,
            iconfont:true
            }"
          ></span>
          <p>
            我已阅读并同意
            <a>《支付协议》</a>
          </p>
        </div>
        <p>温馨提示：仅支持开具电子发票，订单完成后可前往发票管理中开具</p>
      </div>
    </div>

    <!-- 合计 -->
    <van-submit-bar :price="couponTotal*100" button-text="去支付" @submit="onSubmit" />

    <!-- 支付方式弹窗遮罩层 -->
    <van-overlay :show="show" @click="show = false">
      <div class="wrapper" @click.stop>
        <p>支付中心</p>
        <ul class="wrapper-b">
          <li
            v-for="(item,i) of payLis"
            @click="togN(i)"
            :key="i"
            class="wrapper-b-item flex-between-center"
          >
            <div class="wrapper-b-item-l flex-between-center">
              <span :class="['iconfont',item.tb]"></span>
              <p>
                {{item.name}}
                <span v-if="i==0" class="color-85">（剩余￥0）</span>
                <span v-if="i==1" :class="[item.tb2, 'iconfont']"></span>
              </p>
            </div>
            <!-- 优先显示 -->
            <span v-if="false" class="color-85">余额不足</span>
            <span v-else :class="{'icon-xuanzhong1':i==n,iconfont:true}"></span>
          </li>
        </ul>
      </div>
    </van-overlay>
  </div>
</template>

<script>
// 可用优惠券
const coupon = [
  {
    available: 1,
    condition: "无使用门槛\n立减1.5元",
    value: 150,
    name: "立减1.5元",
    startAt: 1489104010,
    endAt: 1514592400,
    valueDesc: "1.5",
    unitDesc: "元"
  },
  {
    available: 2,
    condition: "无使用门槛\n立减2元",
    value: 200,
    name: "立减2元",
    startAt: 1489104010,
    endAt: 1514592400,
    valueDesc: "2.0",
    unitDesc: "元"
  },
  {
    available: 3,
    condition: "无使用门槛\n立减1元",
    value: 100,
    name: "立减1元",
    startAt: 1489104010,
    endAt: 1514592400,
    valueDesc: "1.0",
    unitDesc: "元"
  }
];

// 不可用优惠券
const Ncoupon = [
  {
    available: 1,
    condition: "无使用门槛\n8折优惠",
    value: 800,
    name: "8折优惠",
    startAt: 1489104000,
    endAt: 1514592000,
    valueDesc: "8",
    unitDesc: "折"
  },
  {
    available: 2,
    condition: "无使用门槛\n立减1.5元",
    value: 150,
    name: "立减1.5元",
    startAt: 1489104010,
    endAt: 1514592400,
    valueDesc: "1.5",
    unitDesc: "元"
  }
];

export default {
  data() {
    return {
      showList: false,
      chosenCoupon: -1, // 默认选中优惠券索引
      coupons: coupon, // 可用优惠券
      disabledCoupons: Ncoupon, // 不可用优惠券

      total: 0, // 总价格
      couponTotal: 0, // 使用优惠券总价格
      data: "", // cart页面传来的对象参数
      oidsStr: "", // 保存此次订单商品的的oid
      isRead: false, // 阅读协议切换变量
      isWay: true, // 用餐方式切换变量
      show: false, // 遮罩层切换变量
      n: 1, // 支付方式默认选项
      // 支付方式创建数据
      payLis: [
        { tb: "icon-qianbao", name: "钱包账号余额" },
        { tb: "icon-weixin", name: "微信支付", tb2: "icon-tubiao303" },
        { tb: "icon-umidd17", name: "支付宝" },
        { tb: "icon-xinyongqia", name: "国际信用卡支付" }
      ]
    };
  },
  methods: {
    // 功能：有用优惠券选中调用
    onChange(index) {
      // index选中优惠券的id
      this.showList = false;
      this.chosenCoupon = index;
      // 改变优惠价格
      this.getCouponTotal(index);
    },

    // 功能：计算订单总价格
    getTotal() {
      this.total = 0;
      this.data.forEach(item => {
        this.total += item.total * item.count;
      });
      // 赋值默认优惠价格
      this.couponTotal = this.total;
    },

    // 功能：计算优惠的价格
    getCouponTotal(index) {
      let val = coupon[index].value * 0.01;
      this.couponTotal = this.total - val;
    },

    // 功能：取餐时间
    getTime() {
      let date = new Date();
      let m = date.getMinutes() + 10;
      let h = date.getHours();
      let s = date.getSeconds();
      if (m > 60) {
        h++;
        m = m - 60;
      }
      let currentDate = `${h}:${m}:${s}`;
      return currentDate;
    },

    /**
     * 1.功能：实现支付
     * 2.功能：保存到历史订单
     */
    onSubmit() {
      if (this.isRead) {
        let uid = sessionStorage.getItem("uid");
        let str = this.payLis[this.n].name + "--支付成功！！";
        this.$toast(str);
        this.data = 0;
        this.total = 0;
        this.couponTotal = 0;
        let cart = sessionStorage.getItem("cart");
        let arr = decodeURIComponent(cart);
        let lis = JSON.parse(arr);
        let arrCart = [];
        lis.forEach(item => {
          if (!item.check) {
            arrCart.push(item);
          }
        });
        sessionStorage.setItem("cart", JSON.stringify(arrCart));
      } else {
        this.$toast("请您先了解支付协议！！");
      }
    },

    // 功能：切换支付方式n变量
    togN(i) {
      this.n = i;
    },

    // 功能：切换已读状态的按钮
    togIsRead() {
      this.isRead = !this.isRead;
    },

    // 功能：切换选餐方式按钮
    togIsWay() {
      this.isWay = !this.isWay;
    }
  },

  created() {
    // 获取传过来的参数
    let cart = sessionStorage.getItem("cart");
    let arr = decodeURIComponent(cart);
    let lis = JSON.parse(arr);
    let data = [];
    lis.forEach(item => {
      if (item.check) {
        data.push(item);
      }
    });
    this.data = data;
    // 计算总价格
    this.getTotal();
  }
};
</script>

<style scoped>
/* ********box********* */

.order {
  font-size: 14px;
  position: relative;
}

.container {
  margin: 60px 0;
  padding: 0 10px;
  text-align: left;
  font-size: 16px;
  min-height: 100vh;
}

/* ******取餐时间****** */
.container > p {
  height: 80px;
  line-height: 80px;
  text-align: center;
  font-weight: 600;
  font-size: 18px;
}

/* *******地理位置********* */
.container .map {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.container .map .map-content {
  display: flex;
  align-items: center;
}

.container .map .map-content span {
  margin-right: 20px;
}

.lis .item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 0;
}

.lis .item .item-l {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 75%;
}

.lis .item .item-l .item-l-l {
  display: flex;
  align-items: center;
}

.lis .item .item-l .item-l-l > img {
  width: 100px;
  margin-right: 10px;
  border-radius: 8px;
}

.lis .total {
  margin-top: 6px;
  padding-top: 20px;
  text-align: end;
  border-top: #ddd 1px solid;
}

.lis .total > span {
  font-size: 20px;
  font-weight: 600;
  color: red;
}

/* *********优惠券********** */
.coupons .coupons-t {
  border-bottom: solid 1px rgb(216, 208, 208);
  padding-bottom: 20px;
}

.coupons .coupons-t .coupons-t-t {
  display: flex;
  justify-content: space-between;
  background: rgb(240, 205, 129);
  height: 50px;
  align-items: center;
  padding: 0 20px;
  border-radius: 8px;
  font-size: 15px;
}

/* **********支付方式********* */
.pay,
.pay-r {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 15px;
}

.pay .pay-r span:nth-child(1) {
  margin-right: 15px;
  font-size: 16px;
  color: green;
}

.way .way-t {
  border-bottom: 1px solid rgb(216, 208, 208);
  padding-bottom: 20px;
  font-size: 15px;
}

.yaoqiu {
  padding: 20px 0 0;
  font-size: 15px;
}

/* *********支付说明 *******88*/
.tip {
  padding: 10px 20px;
  font-size: 14px;
}

.tip .tip-t {
  display: flex;
  align-items: center;
  margin-bottom: 5px;
}

.tip .tip-t > span {
  margin-right: 10px;
}

.tip .tip-t > p > a {
  color: royalblue;
}

/* **********遮罩层********** */
.wrapper {
  position: fixed;
  left: 0px;
  bottom: 100px;
  padding: 20px 0;
  width: 80%;
  margin-left: 10%;
  border-radius: 10px;
  background: #fff;
  font-size: 18px;
  text-align: left;
  z-index: 10;
}

.wrapper > p {
  padding: 20px 0;
  text-align: center;
  font-size: 25px;
  border-bottom: 1px solid rgb(216, 208, 208);
}

.wrapper .wrapper-b .wrapper-b-item {
  border-bottom: 1px solid rgb(216, 208, 208);
  padding: 20px 25px;
  line-height: 25px;
}

.wrapper .wrapper-b .wrapper-b-item .wrapper-b-item-l > span {
  margin-right: 15px;
}

/* **********共有样式************* */
/* 面板 */
.panel {
  padding: 10px;
  margin: 20px 0;
  background: #fff;
  border-radius: 20px;
  line-height: 30px;
}

.color-85 {
  color: rgb(184, 179, 179);
}

.color-218 {
  color: rgb(218, 102, 35);
}

.font-35 {
  font-size: 25px;
}

/* 弹性两边对齐 */
.flex-between {
  display: flex;
  justify-content: space-between;
}

.flex-between-center {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* 取餐方式小圆样式 */
.icon-xuanzhong {
  font-size: 16px;
  margin-right: 8px;
}

.icon-xuanzhong1 {
  font-size: 16px;
  margin-right: 8px;
  color: royalblue;
}

.icon-qianbao {
  color: blue;
  font-size: 16px;
}

.icon-weixin {
  color: green;
  font-size: 16px;
}

.icon-tubiao303 {
  color: red;
  font-size: 16px;
}

.icon-umidd17 {
  color: blue;
  font-size: 16px;
}

.icon-xinyongqia {
  color: blue;
  font-size: 16px;
}

.text-hidden {
  /*以下三句缺一不可*/
  max-width: 200px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  font-size: 10px;
}

/*********** 组件样式************ */
/* 修改coupon-cell优惠券样式 */
.van-cell {
  padding: 20px 4px 0;
}
</style>