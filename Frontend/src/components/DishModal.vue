<script>
import axios from "axios";
import { API_ENDPOINTS } from "@/config";

export default {
    props: {
        dish: Object,
        formType: String,
    },
    methods: {
        submitForm() {
            if (this.formType === "Editing dish") {
                this.submitEdit();
            }
            else {
                this.submitCreate();
            }
            
        },
        async submitEdit() {
            try {
                this.isLoading = true;
                const response = await axios.put(
                    `${API_ENDPOINTS.dishes}/${this.dish.id}`, this.form
                );
                this.dishes = response.data;
                this.$emit("finishedUpdate");
            } catch (error) {
                this.error = error.message || "An error occurred";
            } finally {
                this.isLoading = false;
                
            }
        },
        async submitCreate() {
            console.log("creating dish");
            try {
                this.isLoading = true;
                const response = await axios.post(
                    `${API_ENDPOINTS.dishes}`, this.form
                );
                this.dishes = response.data;
                this.$emit("finishedUpdate");
            } catch (error) {
                this.error = error.message || "An error occurred";
            } finally {
                this.isLoading = false;
                
            }
        },
        emitClose() {
            if (!this.isLoading) {
                this.$emit('closeModal'); //Prevent closing modal while updating
            }
        }
    },
    emits: ['closeModal', 'finishedUpdate'],
    data() {
        return {
            form: {
                Name: this.dish.Name,
                Country_Origin: this.dish.Country_Origin,
                Type: this.dish.Type,
                Preparation_Time: this.dish.Preparation_Time,
                IsVegetarian: this.dish.IsVegetarian,
            },
            isLoading: false,
            error: null,
        }
    }
}
</script>
<template>
    <div class="modal-backdrop" @click="this.emitClose()"></div>
    <div class="modal">
        <div v-if="error" class="alert alert-danger">
            {{ error }}
        </div>
        <h2 class="flex-center">{{ this.formType }}</h2>
        <form id="dishForm" @submit.prevent="submitForm" class="form-grid">
            <div>
            <label for="Name">Name:</label>
            <input id="Name" v-model="form.Name" type="text" required />
            </div>

            <div>
            <label for="country">Country of Origin:</label>
            <input id="country" v-model="form.Country_Origin" Type="text" required />
            </div>

            <div>
            <label for="Type">Type:</label>
            <select id="Type" v-model="form.Type" required>
                <option value="warm">Warm</option>
                <option value="cold">Cold</option>
                <option value="normal">Normal</option>
            </select>
            </div>

            <div>
            <label for="prep_time">Prep Time (seconds):</label>
            <input id="prep_time" v-model.number="form.Preparation_Time" type="number" min="1" required />
            </div>

            <div>
            <label for="IsVegetarian">Vegetarian:</label>
            <input id="IsVegetarian" v-model="form.IsVegetarian" type="checkbox" />
            </div>
        </form>
        <div v-if="!this.isLoading" class="modal-footer">
            <button class="btn submit-btn" type="submit" form="dishForm">Submit</button>
            <button class="btn close-btn" @click="this.$emit('closeModal')">Close</button>
        </div>
        <div v-else class="spinner-overlay">
            <div class="spinner"></div>
        </div>
        
    </div>
</template>
<style lang="css" scoped>
.flex-center {
    display:flex;
    padding: 10px;
    justify-content: center;
}
.modal {
  position: fixed;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%); /* center the modal */
  width: 350px;
  height: 400px;
  background: lightgray;
  z-index: 900;
  display:block;
  border-radius: 8px;
}

.modal-backdrop {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,0.4); /* translucent black */
  z-index: 900;
}
.modal-footer {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin-top: 1.5rem;
}
.btn {
  padding: 0.5rem 1.5rem;
  border: none;
  border-radius: 999px; /* fully round */
  color: white;
  font-weight: bold;
  cursor: pointer;
}

.submit-btn {
  background-color: #28a745; /* green */
}

.close-btn {
  background-color: #dc3545; /* red */
}
.form-grid {
  display: grid;
  grid-template-columns: 1fr 2fr;
  gap: 10px 20px;
  max-width: 500px;
  margin: auto; /* center horizontally */
  padding: 20px;
}

.form-grid label {
  text-align: right;
  align-self: center;
}

.form-grid input,
.form-grid select {
  width: 100%;
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