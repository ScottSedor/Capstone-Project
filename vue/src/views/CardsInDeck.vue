<template>
  <div class="cards-in-deck">
    <div class="deck-info">
      <div class="deck-modify-form">
        <deck-modify-form/>
      </div>
      <deck-info />
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
// import SearchCard from '@/components/SearchCard'
import DeckInfo from '@/components/DeckInfo'
import SearchListing from '@/components/SearchListing'
// import CardListing from '@/components/CardListing'
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
        // this.$refs.searchForm.reset();
      },
      addCard(cardId) {
        const deckId = this.$route.params.deckId;
        deckService.addCardToDeck(deckId, cardId).then(response => {
          if (response.status == 200) {
            this.$store.commit('ADD_SEARCH_RESULT_TO_DECK', cardId);
          }
        })
      },
      // Below this is all drag and drop methods
      allowDrop(ev) {
        ev.preventDefault();
      },
      drop(ev) {
        ev.preventDefault();
           let data = ev.dataTransfer.getData('itemId');
        this.addCard(data);
        // this.$store.commit('ADD_SEARCH_RESULT_TO_DECK', data);

      },
      // drag(ev) {
      //   ev.dataTransfer.setData(ev.target.id);
      //   this.$store.commit('SET_DRAGGED_CARD', ev.data)
      // },
    //   onDragging(ev){
    //     ev.dataTransfer.setData("text", ev.target.id);
    // },
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
    justify-content: space-evenly;
  }
  /* button#add-button {
    margin-right: 3vw;
  }
  button#search-button {
    margin-left: 3vw;
  } */
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
  div.deck-modify-form {
    display: flex;
    align-content: flex-start;
  }

</style>