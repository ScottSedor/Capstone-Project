<template>
  <div class='card-form' >
    <form v-on:submit.prevent="saveCard">
      <!-- <h1>New Card:</h1> -->
      <div class='boxes'>
        <div class="form-field">
            <!-- <label for="card-front"></label> -->
            <textarea id="card-front" rows="5" cols="30" placeholder="Card front:" v-model="cardRequest.cardFront" ></textarea>
        </div>
        <div class="form-field">
            <!-- <label for="card-back"></label> -->
            <textarea id="card-back" rows="5" cols="30" placeholder="Card back:" v-model="cardRequest.cardBack"></textarea>
        </div>
        <div class="form-field">
            <!-- <label for="keywords"></label> -->
            <textarea id="card-back" rows="5" cols="30" placeholder="Key words:" v-model="cardRequest.keywords"></textarea>
        </div>
      </div>
      <input type="submit" value="Save Card" v-bind:disabled="!isValid" >
    </form>
  </div>
</template>

<script>
import deckService from '@/services/DeckService'

export default {
  // props: ['card'],
  data() {
    return {
      cardRequest: {}
    }
  },
  computed: {
    isValid() {
      return this.cardRequest.cardFront && this.cardRequest.cardBack && this.cardRequest.keywords;
    }
  },
  methods: {
      saveCard() {
        if (!this.$route.params.cardId) {
          this.createCard();
        } else {
          this.modifyCard();
        }
      },
      createCard() {
          const deckId = this.$route.params.deckId;
          deckService.createCard(deckId, this.cardRequest).then(response => {
              if (response.status >= 200) {
                  this.$store.commit(('ADD_TO_CARDS'), response.data);
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
      },
      modifyCard() {
          const deckId = this.$route.params.deckId;
          const cardId = this.$route.params.cardId;
          deckService.modifyCard(deckId, cardId, this.cardRequest).then(response => {
              if (response.status >= 200) {
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
</script>

<style>
div.form-field {
  display: flex;

}
</style>