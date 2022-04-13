<template>
  <div class="cards-in-deck">
    <div class="addButton">
      <button v-on:click="isAdding = !isAdding">Add Card to Deck</button>
    </div>
    <div class="add-card-form" v-show="isAdding == true">
      <card-form />
    </div>
    <card-list />
  </div>
</template>

<script>
import deckService from '@/services/DeckService'
import CardList from '@/components/CardList'
import CardForm from '@/components/CardForm'

export default {
    name: "CardsInDeck",
    components: {
      CardList,
      CardForm
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
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      flex-direction: column;
  }
  div.cards-in-deck p {
      font-size: 1.5rem;
  }
</style>