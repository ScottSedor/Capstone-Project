<template>
  <div class="cards-in-deck">
    <div class="deck-info">
      <div class="back">
        <a @click="$router.go(-1)">Back</a>
      </div>
      <div class="deck-info-detail">
        <deck-info />
      </div>
      <div class="deck-modify-form">
        <deck-modify-form/>
      </div>
    </div>
    <div class="buttons">
      <div class="add-button" v-show="isSearching == false">
        <button id="add-button" v-on:click="isAdding = !isAdding" v-show="isAdding == false">Create Card</button>
        <button v-on:click="isAdding = !isAdding" v-show="isAdding == true">Cancel</button>
      </div>
      <div class="search-button" v-show="isAdding == false">
        <button id="search-button" v-on:click="isSearching = !isSearching" v-show="isSearching == false">Search for New Cards</button>
        <button v-on:click="cancelSearch" v-show="isSearching == true">Cancel Search</button>
      </div>
    </div>
    <div class="add-card-form" v-show="isAdding == true">
      <card-form />
    </div>
    <div class="search-card" v-show="isSearching == true">
      <div class="search-form">
        <form v-on:submit.prevent="search" ref="searchForm">
            <label for="search-field" >Search Keyword: </label>
            <input id="search-field" type="text" placeholder="Keyword" v-model.trim="keyword">
            <input type="submit" value="Search" >
        </form>
      </div>
      <div class="search-results-title" v-show="hasSearched">
        <h3>Search Results:</h3>
      </div>
      <div class="search-results">
          <p v-if="results.length === 0 && hasSearched">No Results Found</p>
          <search-listing id="search-listing" v-else v-for="result in results" v-bind:key="result.cardId" v-bind:card="result"/>
      </div>
    </div>
    <div class="current-cards" @drop="drop" @dragover="allowDrop">
      <div class="card-list-title" v-show="hasSearched">
          <h3>Cards In Deck:</h3>
        </div>
      <div class="card-list">
        <card-list />
    </div>
    </div>
  </div>
</template>

<script>
import deckService from '@/services/DeckService'
import CardList from '@/components/CardList'
import CardForm from '@/components/CardForm'
import DeckInfo from '@/components/DeckInfo'
import SearchListing from '@/components/SearchListing'
import DeckModifyForm from '../components/DeckModifyForm.vue'

export default {
    name: "CardsInDeck",
    components: {
      CardList,
      CardForm,
      DeckModifyForm,
      DeckInfo,
      SearchListing
    },
    data() {
   
        return {
        isAdding: false,
        isSearching: false,
        searchCancelled: false,
        keyword: '',
        hasSearched: false
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
    computed: {
        results() {
            const searchResults = this.$store.state.searchResults;
            return searchResults;
        }
    },
    methods: {
      cancelSearch() {
        this.isSearching = false;
        this.clearForm();
      },
      search() {
        const deckId = this.$route.params.deckId;
        deckService.search(deckId, this.keyword).then(response => {
            this.hasSearched = true;
            if (response.status == 200) {
                this.$store.commit('SET_SEARCH_RESULTS', response.data);
            }
        })
      },
      clearForm() {
        this.keyword = '';
        this.hasSearched = false;
        this.$store.commit('CLEAR_SEARCH_RESULTS');
      },
      addCard(cardId) {
        const deckId = this.$route.params.deckId;
        deckService.addCardToDeck(deckId, cardId).then(response => {
          if (response.status >= 200) {
            this.search();
            deckService.getCardsInDeck(deckId).then( response => {
                if (response.status == 200) {
                  this.$store.commit('SET_CARDS', response.data);
                }
            });
          }
        })
      },
      // Below this is drag and drop methods
      allowDrop(ev) {
        ev.preventDefault();
      },
      drop(ev) {
        ev.preventDefault();
        let data = ev.dataTransfer.getData('cardId');
        this.addCard(data);
      }
    }
}
</script>

<style>
  div.cards-in-deck {
      margin-top: 40px;
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
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  div.search-results {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        border-bottom: 3px solid white;
    }
  div.search-results-title {
    display: flex;
    justify-content: flex-start;
    align-items: flex-start;
    margin-top: 2vh;
  }
  div.card-list-title {
    display: flex;
    justify-content: center;
  }
  div.deck-info {
    display: grid;
    grid-template-columns: 1fr 2fr 1fr;
    grid-template-areas: ". info form";
    height: 225px;
  }
  div.deck-info-detail {
    grid-area: info;
    display: flex;
    justify-content: center;
    flex-grow: 1;
  }
  div.deck-modify-form {
    grid-area: form;
    display: flex;
    align-content: flex-end;
    justify-content: center;
  }

</style>