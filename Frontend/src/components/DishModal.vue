<script>
export default {
    props: {
        dish: Object
    },
    methods: {
        submitForm() {
            console.log(this.form);
        }
    },
    data() {
        return {
            form: {
                Name: '',
                Country_Origin: '',
                Type: 'warm',
                Preparation_Time: 1,
                TypeIsVegetarian: false,
            }
        }
    },
    mounted() {
        this.form.Name = this.dish.Name;
        this.form.Country_Origin = this.dish.Country_Origin;
        this.form.Type = this.dish.Type;
        this.form.Preparation_Time = this.dish.Preparation_Time;
        this.form.TypeIsVegetarian = this.dish.IsVegetarian;
    }
}
</script>
<template>
    <div class="modal-backdrop" @click="$emit('closeModal')"></div>
    <div class="modal">
        <form @submit.prevent="submitForm" class="form-grid">
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
            <label for="TypeIsVegetarian">Vegetarian:</label>
            <input id="TypeIsVegetarian" v-model="form.TypeIsVegetarian" type="checkbox" />
            </div>

            <button type="submit">Submit</button>
        </form>
        <button @click="showModal = false">Close</button>
    </div>
</template>
<style lang="css" scoped>
.modal {
  position: fixed;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%); /* center the modal */
  width: 350px;
  height: 500px;
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
</style>