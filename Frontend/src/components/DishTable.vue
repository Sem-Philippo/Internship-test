<script>
import DishItem from "./DishItem.vue";
import DishModal from "./DishModal.vue";
import axios from "axios";
import { API_ENDPOINTS } from "@/config";

export default {
  components: { DishItem, DishModal },
  data() {
    return {
        showModal: false,
        dishes: [],
        formType: null,
        editDish: null, //Dish storage for update function
        isLoading: true, // Loading state flag
        error: null, // Error message storage
        success: null, // Success message storage
    };
  },
  methods: {
    EditDish(dish){
        this.referenceDish = dish;
        this.formType = "Editing dish";
        this.showModal = true;
    },
    CloseModal() {
        this.showModal = false;
    },
    RefreshDishes() {
        this.showModal = false;
        this.LoadDishes();
    },
    NewDish() {
        this.formType = "Creating dish";
        this.referenceDish = {
            Name: "",
            Country_Origin: "",
            Type: "normal",
            Preparation_Time: 1,
            IsVegetarian: false,
        };
        this.showModal = true;
    },
    async LoadDishes() {
        this.dishes = [];

        try {
            this.isLoading = true;
            const response = await axios.get(
                `${API_ENDPOINTS.dishes}`
            );
            this.dishes = response.data;
        } catch (error) {
            this.error = error.message || "An error occurred";
        } finally {
            this.isLoading = false;
        }
    }
  },
  mounted() {
    this.LoadDishes();
  },
};
</script>

<template>
    <DishModal v-if="showModal" :dish="referenceDish" :formType="formType" @closeModal="CloseModal" @finishedUpdate="RefreshDishes"/>
    <div v-if="error" class="alert alert-danger">
        {{ error }}
    </div>
    <table v-if="!isLoading" class="dish-table">
        <thead>
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Country</th>
            <th>Type</th>
            <th>Prep Time</th>
            <th>Vegetarian</th>
            <th><button class="btn btn-sm btn-success me-2" @click="NewDish()">New dish</button> <!-- New dish--></th>
        </tr>
        </thead>
        <tbody v-for="item in dishes">
            <DishItem :dish="item" @editDish="EditDish" @finishedDeletion="RefreshDishes"/>
        </tbody>
    </table>
    <div v-else class="spinner-overlay">
        <div class="spinner"></div>
    </div>
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
}
.spinner-overlay {
  position: fixed;      /* or absolute inside container */
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(255, 255, 255, 0.7);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;        /* on top of everything */
}

.spinner {
  border: 4px solid #ccc;
  border-top: 4px solid #3498db; /* blue color */
  border-radius: 50%;
  width: 40px;
  height: 40px;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
