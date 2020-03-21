<template>
  <div class="title3 mt-10">
    <div>
      <div class="title-text">
        <p>
          瑞幸潮品
          <span>直邮到家</span>
        </p>
        <router-link :to="{name:'Menu'}">更多</router-link>
      </div>

      <!-- 图片 -->
      <div class="box-imgs">
        <div class="box-img" v-for="(item,i) of resTitle3" :key="i">
          <img :src="`http://127.0.0.1:5050/${item.imgUrl}`" alt />
          <div class="text-p">
            <p class="text-hidden">{{item.content}}</p>
            <div>
              <span>￥{{item.price}}</span>
              <span></span>
            </div>
            <p>已售卖{{item.selling}}+件</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  // 接受父组件的值
  props: ["resTitle3"],
  methods: {},
  filters: {},
  created() {}
};
</script>

<style scoped>
.title3 {
  margin-top: 15px;
  font-size: 14px;
}

.title3 .title-text {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
}

.title3 .title-text p span {
  border: 1px solid #000;
  padding: 2px;
  margin-left: 8px;
  font-size: 12px;
}

.title3 .title-text a {
  color: #888;
}

.title3 .box-imgs {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}

.title3 .box-img {
  width: 49%;
  text-align: left;
  background: #fff;
  margin-bottom: 14px;
  border-radius: 8px;
}

.title3 .box-img img {
  width: 100%;
  border-radius: 8px;
}

.title3 .box-img .text-p {
  width: 100%;
  line-height: 20px;
  padding: 5px;
}

.title3 .box-img .text-p .text-hidden {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  max-width: 300px;
}

.title3 .box-img .text-p p:last-child {
  color: #ccc;
  font-size: 10px;
}
</style>