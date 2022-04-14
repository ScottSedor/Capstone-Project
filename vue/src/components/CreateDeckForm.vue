<template>
  <div class="create-deck-form">
      <h1>MY DECKS</h1>
      
      <form v-on:submit.prevent="createDeck" ref="deckCreate" >
          <div class="form-field">
              <label for="title">Add New Deck: </label>
              <input type="text" id="title" placeholder="New Deck Title" v-model.trim="deckRequest.deckTitle">
          </div>
          <div class="form-field">
              <label for="description">Description: </label>
              <input type="text" id="title" placeholder="Description of Deck" v-model.trim="deckRequest.deckDescription">
          </div>
          <div class="button">
              <input type="submit" value="Save Deck">
          </div>
      </form>
  </div>
</template>

<script>
import deckService from '@/services/DeckService'

export default {
    // props: ['deck'],
    data() {
        return {
            deckRequest: {}
        }
    },
    methods: {
        createDeck() {
            deckService.createDeck(this.deckRequest).then(response => {
                if (response.status >= 200) {
                    this.$store.commit('ADD_TO_DECKS', response.data);
                    this.$refs.deckCreate.reset();
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
div.button {
    margin-top: 10px;
    margin-bottom: 40px;
    display: flex;
    justify-content: center;
}
</style>