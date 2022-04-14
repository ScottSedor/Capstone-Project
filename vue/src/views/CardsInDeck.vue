<template>
  <div class="cards-in-deck">
    <div class="add-button">
      <button v-on:click="isAdding = !isAdding">Add Card to Deck</button>
    </div>
    <div class="add-card-form" v-show="isAdding == true">
      <card-form />
    </div>
    <div class="search-card">
      <search-card />
    </div>
    <card-list />
  </div>
</template>

<script>
import deckService from '@/services/DeckService'
import CardList from '@/components/CardList'
import CardForm from '@/components/CardForm'
import SearchCard from '@/components/SearchCard'

export default {
    name: "CardsInDeck",
    components: {
      CardList,
      CardForm,
      SearchCard
    },
    data() {
      return {
        isAdding: false
      }
    },
    created() {
      const deckId = this.$route.params.deckId;
      deckService.getCardsInDeck(deckId).then( response => {
          if (response.status == 200) {
            this.$store.commit('SET_CARDS', response.data);
          }
      })
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
  div.add-button {
    display: flex;
    margin-bottom: 20px;
    justify-content: center;
  }
</style>