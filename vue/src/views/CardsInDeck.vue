<template>
  <div class="cards-in-deck">
    <card-list />
  </div>
</template>

<script>
import deckService from '@/services/DeckService';
import CardList from '@/components/CardList';

export default {
    name: "CardsInDeck",
    components: {
      CardList
    },
    created() {
      const deckId = this.$route.params.deckId;
      deckService.getCardsInDeck(deckId).then( response => {
          if (response.status === 200) {
            this.$store.commit('SET_CARDS', response.data);
          }
      })
    }
}
</script>

<style>

</style>