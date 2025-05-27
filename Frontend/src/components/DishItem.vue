<script>
import { API_ENDPOINTS } from "@/config";
import axios from "axios";
export default {
    data() {
        return {
            isLoading: false,
            error: null,
        };
    },
    emits: ['editDish', 'finishedDeletion'],
    components: { },
    props: {
        dish: Object
    },
    methods: {
        editDish() {
            console.log("editing dish with id" + this.dish.id);
            this.$emit("editDish", this.dish);
        },
        async deleteDish() {
            if (confirm(`Are you sure you want to delete "${this.dish.Name}"?`)) {
                console.log("deleting dish with id" + this.dish.id);
                try {
                    this.isLoading = true;
                    const response = await axios.delete(
                        `${API_ENDPOINTS.dishes}/${this.dish.id}`
                    );
                    this.dishes = response.data;
                    this.$emit('finishedDeletion');
                } catch (error) {
                    this.error = error.message || "An error occurred";
                } finally {
                    this.isLoading = false;
                }
            }
        }
    },
};
</script>

<template>
    <td>{{ this.dish.id }}</td>
    <td>{{ this.dish.Name }}</td>
    <td>{{ this.dish.Country_Origin }}</td>
    <td>{{ this.dish.Type}}</td>
    <td>{{ this.dish.Preparation_Time }} mins</td>
    <td>
        <span :style="{ color: this.dish.IsVegetarian ? 'green' : 'red' }">
            {{ this.dish.IsVegetarian ? '✔️' : '❌' }}
        </span>
    </td>
    <td>
        <button class="btn btn-sm btn-warning me-2" @click="this.editDish()">Edit</button> <!-- Edit dish -->
        <button class="btn btn-sm btn-danger" @click="this.deleteDish()" style="min-width: 80px;">
            <div v-if="!this.isLoading">Delete</div>
            <div v-else class="spinner"></div>
        </button> <!-- Delete dish -->
    </td>
</template>

<style lang="css" scoped>
.dish-table td {
    white-space: nowrap; /* prevents wrapping so width depends on content */
    padding: 8px 12px;
}
td:first-child {
  border-top-left-radius: 8px;
  border-bottom-left-radius: 8px;
}
td:last-child {
  border-top-right-radius: 8px;
  border-bottom-right-radius: 8px;
}

.spinner {
  border: 4px solid #ccc;
  border-top: 4px solid #3498db; /* blue color */
  border-radius: 50%;
  width: 14px;
  height: 14px;
  display: inline-block;
  animation: spin 1s linear infinite;
  vertical-align: middle;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
