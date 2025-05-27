import { createRouter, createWebHistory } from "vue-router";
import Home from "./components/Home.vue";
import { createPinia } from "pinia";

import "./assets/main.css";

import { createApp } from "vue";
import App from "./App.vue";

const routes = [
  {
    path: "/",
    component: Home,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

const app = createApp(App);

app.use(router);
app.use(createPinia());

app.mount("#app");
