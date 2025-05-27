<script>
import { useDishStore } from "@/stores/dishes";
import Navbar from "@/components/Navbar.vue";

export default {
  setup() {
    const store = useDishStore();
    return {
      store,
    };
    
  },
  components: {
    Navbar
  }
};
</script>
<template>
  <Navbar />
  <div class="container">
    <main>
      <RouterView />
    </main>
  </div>
</template>
