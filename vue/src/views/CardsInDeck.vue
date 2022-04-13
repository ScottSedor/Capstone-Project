<template>
  <div class="cards-in-deck">
    <card-form />
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