<template>
  <div class="create-deck-form">
      <h1 id="title">Deck Library</h1>
      <div class="create-deck-button">
        <button class="create" data-toggle="popover" title="Create Deck" v-on:click="isCreatingDeck = !isCreatingDeck" v-show="!isCreatingDeck">
            <img class="create-img" src="..\assets\create-deck-icon.png" alt="create deck icon">
        </button>
        <button class="cancel-button" v-on:click="isCreatingDeck = !isCreatingDeck"  v-show="isCreatingDeck">Cancel</button>
      </div>
      <form v-show="isCreatingDeck" v-on:submit.prevent="createDeck" ref="deckCreate" >
          <div class="form-field">
              <label for="title">Add New Deck: </label>
              <input type="text" id="title" placeholder="New Deck Title" v-model.trim="deckRequest.deckTitle">
          </div>
          <div class="form-field">
              <label for="description">Description: </label>
              <input type="text" id="title" placeholder="Description of Deck" v-model.trim="deckRequest.deckDescription">
          </div>
          <div class="button">
              <input class="save-deck" type="submit" value="Save Deck">
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
            deckRequest: {},
            isCreatingDeck: false
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

button > img.create-img {
    height: 300px;
    width: 300px;
}
h1#title {
    text-decoration-color: white;
    color: #274e13ff;
    text-shadow: rgba(0, 0, 0, 0.651);
}
div.button, div.create-deck-button {
    margin-top: 10px;
    margin-bottom: 40px;
    display: flex;
    justify-content: center;
}
button.create {
    background: none;
    border: none;
    cursor: pointer;
}
button.create:hover {
    transform: scale(1.1);
}
button.cancel-button {
    background: rgb(202, 202, 202);
    border: solid 1px rgb(0, 0, 0);
    border-radius: 5px;
   
}
button.cancel-button:hover {
    background: rgb(238, 238, 238);
    border: solid 1px rgb(0, 0, 0);
    border-radius: 5px;
    -webkit-box-shadow: 0px 8px 6px -6px rgba(119, 119, 119, 0.534); 
}
button.save-deck:hover {
    background: rgb(238, 238, 238);
    border: solid 1px rgb(0, 0, 0);
    border-radius: 5px;
    -webkit-box-shadow: 0px 8px 6px -6px rgba(119, 119, 119, 0.534); 
}



</style>