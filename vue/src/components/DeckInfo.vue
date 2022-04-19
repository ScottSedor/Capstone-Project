<template>
  <div class="deck-info-card" >
      <h1> {{ $store.state.activeDeck.deckTitle }}</h1>
      <p>{{ $store.state.activeDeck.deckDescription }}</p>
  </div>
</template>

<script>
import deckService from '@/services/DeckService'

export default {
    name: "deck-info-card",
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

div.deck-info-card {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    color: #93c47dff;
}
div.deck-info-card > h1 {
    color: #93c47dff;
}

</style>
