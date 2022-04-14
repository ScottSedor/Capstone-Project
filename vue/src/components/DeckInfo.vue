<template>
  <div class="deck-info" v-bind:deck="activeDeckId">
      <h2> {{ deck.deckTitle }}</h2>
      <p>{{ deck.deckDescription }}</p>
  </div>
</template>

<script>
import deckService from '@/services/DeckService'
export default {
    name: "deck-info",
    computed: {
        deck() {
            return this.$store.state.decks.find((d) => {
                return d.deckId == this.$store.state.activeDeckId;
            }); 
        }
    },
    created() {
        const deckId = this.$route.params.deckId;
        deckService.getDeckInfoById(deckId).then(response => {
            if(response.status == 200) {
                this.$store.commit('SET_ACTIVE_DECK', response.data);
            }
        })
    }

}
</script>

<style>

</style>
