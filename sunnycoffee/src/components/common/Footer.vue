<template>
  <div class="footer">
    <van-tabbar route v-model="active" active-color="#07c160" inactive-color="#000">

      <van-tabbar-item to="/">
        <span>首页</span>
        <img slot="icon" slot-scope="props" :src="props.active ? icon1.active : icon1.inactive" />
      </van-tabbar-item>

      <van-tabbar-item to="/menu">
        <span>菜单</span>
        <img slot="icon" slot-scope="props" :src="props.active ? icon2.active : icon2.inactive" />
      </van-tabbar-item>

      <van-tabbar-item to="/cart">
        <span>购物车</span>
        <img slot="icon" slot-scope="props" :src="props.active ? icon4.active : icon4.inactive" />
      </van-tabbar-item>

      <van-tabbar-item to="/personal">
        <span>我的</span>
        <img slot="icon" slot-scope="props" :src="props.active ? icon5.active : icon5.inactive" />
      </van-tabbar-item>
    </van-tabbar>
    
  </div>
</template>

<script>
export default {
  data() {
    return {
      active: 2,
      icon1: {
        active: "icon/shouye1.png",
        inactive: "icon/shouye.png"
      },
      icon2: {
        active: "icon/coffee1.png",
        inactive: "icon/coffee.png"
      },
      icon3: {
        active: "icon/baobao1.png",
        inactive: "icon/baobao.png"
      },
      icon4: {
        active: "icon/cat1.png",
        inactive: "icon/cat.png"
      },
      icon5: {
        active: "icon/wo1.png",
        inactive: "icon/wo.png"
      }
    };
  }
};
</script>

<style scoped>
/* 重写标签栏字体大小 */
.van-tabbar-item {
  font-size: 15px;
}
</style>