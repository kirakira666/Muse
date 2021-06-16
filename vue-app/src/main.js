import Vue from "vue";
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import App from "./App.vue";
import Cloudbase from "@cloudbase/vue-provider";

// 注意更新此处的TCB_ENV_ID为你自己的环境ID
window._tcbEnv = window._tcbEnv || {TCB_ENV_ID:"hello-cloudbase-test"};

export const envId = window._tcbEnv.TCB_ENV_ID;
export const region = window._tcbEnv.TCB_REGION;

Vue.config.productionTip = false;
Vue.use(ElementUI);
Vue.use(Cloudbase, {
  env: envId,
  region: region
});

new Vue({
  el: '#app',
  render: h => h(App)
});
