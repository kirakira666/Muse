<template>
  <div id="app">
    <el-container>
      <el-header>Project Muse construction Steps</el-header>
      <el-container>
        <el-aside width="250px">
          <el-container>
            <el-container>
              <el-col>
                <el-card class="step">
                  <div>
                    <span>好吃的汉堡</span>
                  </div>
                </el-card>
                <el-card class="step" shadow="hover"> 总是显示 </el-card>
                <el-card class="step" shadow="hover"> 总是显示 </el-card>
                <el-card class="step" shadow="hover"> 总是显示 </el-card>
                <el-card class="step" shadow="hover"> 总是显示 </el-card>
                <el-card class="step" shadow="hover"> 总是显示 </el-card>
                <el-card class="step" shadow="hover"> 总是显示 </el-card>
                <el-card class="step" shadow="hover"> 总是显示 </el-card>
              </el-col>

              <!-- <el-header>ll</el-header> -->
            </el-container>
          </el-container>
        </el-aside>
        <el-main>
          <div>
            <el-row>
              <el-card :body-style="{ padding: '0px' }">
                <div style="padding: 14px">
                  <span>好吃的汉堡</span>
                  <div class="bottom clearfix">
                    <time class="time">{{ currentDate }}</time>
                    <el-button type="text" class="button">操作按钮</el-button>
                  </div>
                </div>
              </el-card>
            </el-row>
          </div>
        </el-main>
      </el-container>
    </el-container>
    <el-steps :active="active" finish-status="success">
      <el-step title="步骤 1"></el-step>
      <el-step title="步骤 2"></el-step>
      <el-step title="步骤 3"></el-step>
    </el-steps>

    <el-button style="margin-top: 12px" @click="next">下一步</el-button>
    <!-- <img class="logo" alt="CloudBase logo" src="./assets/cloudbase.png" />
    <img class="logo" alt="Vue logo" src="./assets/logo.png" />
    <HelloWorld msg="斤斤计较经济界 CloudBase Vue.js App" /> -->
  </div>
</template>

<script>
// import HelloWorld from "./components/HelloWorld.vue";
import Vue from "vue";
import Element from "element-ui";
Vue.use(Element, { size: "big", zIndex: 3000 });
export default {
  name: "App",
  components: {
    // HelloWorld,
  },
};
</script>

<style>
.step {
  height: 80px;
  text-align: center;
  line-height: 43px;
  margin-top: 8px;
  /* margin-top: 8px;
  margin-left: 8px;
  margin-right: 8px;
  height: 100px;
  color: #333; */
}
.el-header,
.el-footer {
  background-color: #ffffff;
  color: #3c4043;
  font-size: 20px;
  font-weight: 400;
  margin: 0 8px;
  font-family: Roboto, Noto, sans-serif;
  text-align: left;
  line-height: 50px;
}

.el-aside {
  background-color: #f6f8fb;
  /* color: rgba(216, 230, 240, 0.129); */
  color: pink;
  padding: 10px;
  text-align: center;
  line-height: 200px;
}

.el-main {
  background-color: #f6f8fb;
  color: #333;
  text-align: center;
  line-height: 160px;
}

body > .el-container {
  margin-bottom: 0px;
}

.el-container:nth-child(5) .el-aside,
.el-container:nth-child(6) .el-aside {
  line-height: 260px;
}

.el-container:nth-child(7) .el-aside {
  line-height: 320px;
}
</style>
