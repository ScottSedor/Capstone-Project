<template>
  <div class="search-card">
      <div class="search-form">
        <form v-on:submit.prevent="search" >
            <label for="search-field" >Search Keyword: </label>
            <input id="search-field" type="text" placeholder="Keyword" v-model.trim="keyword">
            <input type="submit" value="Search" >
        </form>
      </div>
      <div class="search-results">
          <p v-if="results.length === 0 && hasSearched">No Search Results</p>
          <card-listing v-else v-for="result in results" v-bind:key="result.cardId" v-bind:card="result"/>
      </div>
  </div>
</template>

<script>
import deckService from '@/services/DeckService'
import CardListing from '@/components/CardListing'

export default {
    name: 'search-card',
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
        }
    },
    methods: {
        search() {
            const deckId = this.$route.params.deckId;
            deckService.search(deckId, this.keyword).then(response => {
                this.hasSearched = true;
                if (response.status == 200) {
                    this.$store.commit('SET_SEARCH_RESULTS', response.data)
                }
            })
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
        border-bottom: 3px solid white;
    }
    div.search-results {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
    }
</style>