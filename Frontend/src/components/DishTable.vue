<script>
import DishItem from "./DishItem.vue";
import axios from "axios";
import { API_ENDPOINTS } from "@/config";

export default {
  components: { DishItem },
  data() {
    return {
        dishes: [],
        isLoading: true, // Loading state flag
        error: null, // Error message storage
        success: null, // Success message storage
    };
  },
  async mounted() {
    try {
        console.log("testing");
        this.isLoading = true;
        const response = await axios.get(
            `${API_ENDPOINTS.dishes}`
        );
        console.log(response.data);
        this.dishes = response.data;
    } catch (error) {
      this.error = error.message || "An error occurred";
    } finally {
      this.isLoading = false;
    }
  },
};
</script>

<template>
    <table class="dish-table">
        <thead>
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Country</th>
            <th>Type</th>
            <th>Prep Time</th>
            <th>Vegetarian</th>
            <th></th> <!-- empty slot for edit button-->
            <th></th>
        </tr>
        </thead>
        <tbody v-for="item in this.dishes">
            <DishItem :dish="item"/>
        </tbody>
    </table>
</template>

<style lang="css" scoped>
.dish-table {
    border-collapse: separate;
    border-spacing: 0 10px;
}
.dish-table th{
  white-space: nowrap; /* prevents wrapping so width depends on content */
  padding: 8px 12px;
  border:none;
}
.dish-table td {
    white-space: nowrap; /* prevents wrapping so width depends on content */
    padding: 8px 12px;
    border:none;
}
tbody{
    background-color: lightgrey;
    /*border: 5px, solid, white;
    border-top-width: 0px;
    border-left-width: 0px;
    border-right-width: 0px;*/
}
</style>
