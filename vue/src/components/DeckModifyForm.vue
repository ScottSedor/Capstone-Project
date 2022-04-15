<template>
  <div class="modify-deck-form">
      <button v-on:click="isCreatingDeck = !isCreatingDeck">Modify Deck</button>
      <form v-show="isCreatingDeck" v-on:submit.prevent="modifyDeck" ref="deckCreate" >
          <div class="form-field">
              <label for="title">Modify Deck: </label>
              <input type="text" id="title" placeholder="New Deck Title" v-model.trim="deckRequest.deckTitle">
          </div>
          <div class="form-field">
              <label for="description">Description: </label>
              <input type="text" id="title" placeholder="Description of Deck" v-model.trim="deckRequest.deckDescription">
          </div>
          <div class="button">
              <input type="submit" value="Save Changes">
          </div>
      </form>
  </div>
  
</template>

<script>

import deckService from '@/services/DeckService'

export default {
    data() {
        return {
            deckRequest: {},
            isCreatingDeck: false 
        }
    },
    methods: {
        modifyDeck() {
            this.isCreatingDeck = true;
            const deckId = this.$route.params.deckId;
            deckService.updateDeck(deckId, this.deckRequest).then(response => {
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
        },
        created() {
    if(this.$route.params.cardId) {
      this.deckRequest.deckTitle = this.deck.deckTitle;
      this.deckRequest.deckDescription = this.deck.deckDescription;
    }
  }
    }




</script>

<style>

</style>