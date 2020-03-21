<template>
  <!-- 添加按钮组件 -->
  <div class="btn">
    <span @click="doJian" class="jian">-</span>
    <span>{{num}}</span>
    <span @click="doAdd" class="add">+</span>
  </div>
</template>

<script>
export default {
  props: ["count"],
  data() {
    return {
      num: this.count
    };
  },
  methods: {
    // 功能：点击减去一个商品
    doJian() {
      this.num--;
      if (this.num < 1) {
        this.num = 1;
        this.$toast("再减就没有商品了喔！");
        return;
      }
      this.$emit("onChange", this.num);
    },

    // 功能：点击添加一个商品
    doAdd() {
      this.num++;
      this.$emit("onChange", this.num);
    }
  }
};
</script>

<style scoped>
.btn {
  display: flex;
  justify-content: space-around;
  align-items: center;
  width: 70px;
}

.jian,
.add {
  text-align: center;
  line-height: 20px;
  width:20px;
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