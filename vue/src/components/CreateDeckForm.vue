<template>
  <div class="create-deck-form">
      <form v-on:submit.prevent="createDeck">
          <div class="form-field">
              <label for="title">Add New Deck: </label>
              <input type="text" id="title" placeholder="Deck Title" v-model.trim="deckRequest.deckTitle">
          </div>
          <div class="form-field">
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

</style>