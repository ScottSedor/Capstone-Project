<template>
  <div class="card-detail">
    <card-info />

    <div class="edit-button">
      <button class="edit" data-toggle="popover" title="Edit Card" v-on:click="isEditing = !isEditing" v-show="!isEditing">
        <img class="edit-img" src="..\assets\edit-deck-icon.png" alt="edit icon">
      </button>

      <button v-on:click="isEditing = !isEditing"  v-show="isEditing">Cancel</button>
      <button class="remove" data-toggle="popover" title="Remove Card" v-on:click="removeCard">
        <img class="remove-img" src="..\assets\remove-deck-icon.png" alt="remove icon">
      </button>
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

div.card-detail {
  font-family: 'Roboto Mono', monospace;
  margin-top: 60px;
}
div.edit-button {
  display: flex;
  justify-content: space-evenly;
  margin-bottom: 10px;
  
}
button.edit, button.remove {
  background: none;
  border: none;
  cursor: pointer;
}

img.edit-img, img.remove-img {
  height: 100px;
  width: 100px;
  border-radius: 50px;
}
button.edit:hover, button.remove:hover {
  transform: scale(1.1);
}

</style>