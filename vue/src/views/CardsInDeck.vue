<template>
  <div class="cards-in-deck">
    <div class="deck-info">
      <deck-info />
    </div>
    <div class="buttons">
      <div class="add-button" v-show="isSearching == false">
        <button id="add-button" v-on:click="isAdding = !isAdding" v-show="isAdding == false">Create Card</button>
        <button v-on:click="isAdding = !isAdding" v-show="isAdding == true">Cancel</button>
      </div>
      <div class="search-button" v-show="isAdding == false">
        <button id="search-button" v-on:click="isSearching = !isSearching" v-show="isSearching == false">Search for New Cards</button>
        <!-- <button v-on:click="isSearching = !isSearching" v-show="isSearching == true">Cancel Search</button> -->
      </div>
    </div>
    <div class="add-card-form" v-show="isAdding == true">
      <card-form />
    </div>
    <div class="search-card" v-show="isSearching == true">
      <search-card />
    </div>
    <div class="card-list">
      <card-list />
    </div>
  </div>
</template>

<script>
import deckService from '@/services/DeckService'
import CardList from '@/components/CardList'
import CardForm from '@/components/CardForm'
import SearchCard from '@/components/SearchCard'
import DeckInfo from '@/components/DeckInfo'

export default {
    name: "CardsInDeck",
    props: ['searchCancelled'],
    components: {
      CardList,
      CardForm,
      SearchCard,
      DeckInfo
    },
    data() {
      return {
        isAdding: false,
        isSearching: false
      }
    },
    computed: {
      cancelSearch() {
        return this.checkSearchCancelled();
      }
    },
    created() {
      const deckId = this.$route.params.deckId;
      this.$store.commit('SET_ACTIVE_DECK', deckId);
      deckService.getCardsInDeck(deckId).then( response => {
          if (response.status == 200) {
            this.$store.commit('SET_CARDS', response.data);
          }
      });
    },
    methods: {
      checkSearchCancelled() {
        if (this.searchCancelled == true) {
          this.isSearching = false;
        }
      }
    }
}
</script>

<style>
  div.cards-in-deck {
      margin-top: 60px;
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      flex-direction: column;
      font-family: Arial, Helvetica, sans-serif;
  
  }
  div.cards-in-deck p {
      font-size: 1.5rem;
  }
  div.buttons {
    display: flex;
    margin-bottom: 20px;
    justify-content: center;
  }
  button#add-button {
    margin-right: 3vw;
  }
  button#search-button {
    margin-left: 3vw;
  }
  div.search-card {
    display: flex;
    justify-content: center;
  }
</style>