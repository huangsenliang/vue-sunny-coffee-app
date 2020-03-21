<template>
  <!-- 菜单页面 -->
  <div class="menu">
    <!-- 顶部轮播图 -->
    <swipe-view></swipe-view>
    <!-- 分类选择 -->
    <div class="select">
      <van-tree-select
        style="fontSize:16px;marginBottom:20px"
        @click-nav="nav"
        height="620px"
        :items="items"
        :main-active-index.sync="active"
      >
        <!-- 右侧内容 -->
        <template slot="content">
          <div v-for="(name,i) of items" :key="i">
            <div v-if="active==i">
              <van-divider :style="{ borderColor: '#eee',fontSize:'15px'}">{{name.text}}</van-divider>
              <router-link :to="`/details/${item.lid}`" class="card" v-for="(item,i) of itemRight" :key="i">
                <img :src="`http://127.0.0.1:5050/`+item.imgUrl" alt />
                <div class="card-text">
                  <h4>{{item.lname}}</h4>
                  <p class="tip-English">{{item.e_name}}</p>
                  <p>{{[item.heat,item.sugar,item.cream,item.tea] | string}}</p>
                  <div class="price">
                    <p>
                      <span>{{item.price | currency}}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                      <span>{{item.old_price | currency}}</span>
                    </p>
                    <span class="btn">+</span>
                  </div>
                </div>
              </router-link>
            </div>
          </div>
        </template>
      </van-tree-select>
    </div>

    <footer-view></footer-view>
  </div>
</template>

<script>
export default {
  data() {
    return {
      active: 0,
      itemRight: [],
      items: [],
      activeIds: [1, 2],
      activeIndex: 0
    };
  },
  methods: {
    
    nav(index) {
      // 功能：根据点击项发起请求获取某一系列的数据
      index++;
      let url = "/products/list?pno=" + index;
      this.axios.get(url).then(result => {
        this.itemRight = result.data.data;
      });
    }
  },

  created() {
    // 功能：请求左侧列表数据
    this.nav(0); // 默认请求第一个
    this.axios.get("/products/family").then(result => {
      // 重构items的左侧数据
      this.items = result.data.data.map((item, i) => {
        return { text: item.fname };
      });
    });
  }
};
</script>

<style scoped>
.menu {
  font-size: 16px;
  padding: 8px;
  background:url(../../public/backgroundImg/menu.jpg);
}

.menu .select {
  margin-top: 8px;
}

/* 商品卡片样式 */
.menu .select .card {
  text-align: center;
  display: flex;
  align-items: center;
  height: 140px;
  padding: 0 10px;
  color:#000;
  justify-content: space-around;
  border-bottom: 1px solid #eee;
}

.menu .select .card img {
  width: 80px;
  max-width: 300px;
  height: 110px;
  border-radius: 8%;
}

.menu .select .card .card-text {
  display: flex;
  flex-direction: column;
  text-align: left;
  line-height: 25px;
  padding: 15px 0px 0 10px;
  height: 90%;
  width:60%;
}

/* 重写左侧字体样式 */
.van-sidebar-item {
    font-size: 16px;
}

/* 重写左侧激活样式 */
.van-sidebar-item:hover {
  color:tomato;
}

.menu .select .card .card-text h4 {
  font-weight: 550;
}

.menu .select .card .card-text p {
  color: rgba(0, 0, 0, 0.4);
  font-size: 12px;
  line-height: 17px;
}

/* 文字溢出隐藏 */
.tip-English {
  /* 给定最大宽度 */
  max-width: 300px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.menu .select .card .card-text .price {
  display: flex;
  justify-content: space-between;
  align-items: center;

}

.menu .select .card .card-text .price p span:last-child {
  text-decoration: line-through;
  font-size: 10px;
}

.menu .select .card .card-text .price p span:first-child {
  color: tomato;
  font-size: 14px;
}

.btn {
  display: inline-block;
  background:rgb(96, 194, 189);
  width: 15px;
  height: 15px;
  text-align: center;
  line-height: 15px;
  color: #fff;
  border-radius: 50%;
}


/* 修改分割线 */
.van-divider {
  margin-bottom: -10px;
}

</style>