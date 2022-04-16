<template>
  <div class="card-detail">
    <card-info />
      <img src="vue\src\assets\Capture.JPG" alt="Edit Icon">
    <div class="edit-button">
      <button v-on:click="isEditing = !isEditing" v-show="!isEditing">Edit Card</button>
      <button v-on:click="isEditing = !isEditing"  v-show="isEditing">Cancel</button>
      <button v-on:click="removeCard">Remove Card</button>
    </div>
    <div class="card-edit-form" v-show="isEditing == true">
      <card-form />
    </div>
  </div>
</template>

<script>
import CardInfo from '@/components/CardInfo.vue'
import CardForm from '@/components/CardForm.vue'
import deckService from '@/services/DeckService'

export default {
  components: { 
        CardInfo,
        CardForm
  },
  data() {
    return {
      isEditing: false
    }
  },
  created() {
      const cardId = this.$route.params.cardId;
      this.$store.commit('SET_ACTIVE_CARD', cardId);
  },
  methods: {
    removeCard() {
      const deckId = this.$route.params.deckId;
      const cardId = this.$route.params.cardId;
      if (confirm('Delete this flash card?')) {
      deckService.deleteCardFromDeck(deckId, cardId).then(response => {
        if(response.status >= 200) {
          this.$router.push({name: 'cards-in-deck'});
        }
      }).catch(error => {
              if(error.response) {
                  console.error(error.status + " " + error.statusText);
              } else if (error.request) {
                  console.error("Could not connect to server");
              } else {
                  console.error(error);
              }
          })
      }
    }
  }

}
</script>

<style>
img {
  width: 100px;
  height: 100px;
}
div.card-detail {
  font-family: Arial, Helvetica, sans-serif;
  margin-top: 60px;
    }

div.edit-button {
  display: flex;
  justify-content: space-evenly;
  margin-bottom: 10px;
}
    
</style>