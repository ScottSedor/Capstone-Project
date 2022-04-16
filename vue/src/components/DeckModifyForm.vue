<template>
  <div class="modify-deck-form">
      <div class="btn">
        <button v-if="!isChangingDeck" v-on:click="isChangingDeck = !isChangingDeck">Modify Deck</button>
        <button id="cancel-btn" v-else v-on:click="isChangingDeck = !isChangingDeck">Cancel</button>
      </div>
      <form v-show="isChangingDeck" v-on:submit.prevent="modifyDeck" ref="deckModify" >
          <div class="form-field">
              <label for="title">Modify Deck: </label>
              <input type="text" id="title" placeholder="New Deck Title" v-model.trim="deckRequest.deckTitle">
          </div>
          <div class="form-field">
              <label for="description">Description: </label>
              <input type="text" id="title" placeholder="Description of Deck" v-model.trim="deckRequest.deckDescription">
          </div>
          <div class="form-field">
              <label for="deck-color">Deck Color: </label>
              <input type="text" id="title" placeholder="Color of Deck">
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
            isChangingDeck: false 
        }
    },
    methods: {
        modifyDeck() {
            this.isChangingDeck = true;
            const deckId = this.$route.params.deckId;
            deckService.updateDeck(deckId, this.deckRequest).then(response => {
              if (response.status >= 200) {
                  this.refreshDeck();
                  this.$refs.deckModify.reset();
                  this.isChangingDeck = false;
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
            refreshDeck() {
                  const deckId = this.$route.params.deckId;
        deckService.getDeckInfoById(deckId).then(response => {
            if(response.status == 200) {
                this.$store.commit('SET_ACTIVE_DECK', response.data);
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
    div.btn {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 10px;
    }
</style>