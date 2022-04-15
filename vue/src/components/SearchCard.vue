<template>
  <div class="search-card">
      <!-- <div class="cancel-button">
        <button v-on:click="clearForm">Cancel Search</button>
      </div> -->
      <div class="search-form">
        <form v-on:submit.prevent="search" ref="searchForm">
            <label for="search-field" >Search Keyword: </label>
            <input id="search-field" type="text" placeholder="Keyword" v-model.trim="keyword">
            <input type="submit" value="Search" >
        </form>
      </div>
      <div class="search-results">
          <p v-if="results.length === 0 && hasSearched">No Results Found</p>
          <card-listing id="card-listing" v-else v-for="result in results" v-bind:key="result.cardId" v-bind:card="result"/>
      </div>
  </div>
</template>

<script>
import deckService from '@/services/DeckService'
import CardListing from '@/components/CardListing'

export default {
    name: 'search-card',
    props: ['searchCancelled'],
    components: {
        CardListing
    },
    data() {
        return {
            keyword: '',
            hasSearched: false
        }
    },
    computed: {
        results() {
            const searchResults = this.$store.state.searchResults;
            return searchResults;
        },
        cancelSearch() {
            if(this.searchCancelled == true) {
                return this.clearForm();
            } else {return false;}
        }
    },
    methods: {
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
            if(this.searchCancelled == true) {
                this.keyword = '';
                this.hasSearched = false;
                this.$store.commit('CLEAR_SEARCH_RESULTS');
                this.$refs.searchForm.reset();
            }
        }
    }
}
</script>

<style>
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
</style>