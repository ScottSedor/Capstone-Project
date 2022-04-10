<template>
  <div class="decks">
      <deck-list />
  </div>
</template>

<script>
import deckService from '@/services/DeckService'
import DeckList from '@/components/DeckList'

export default {
    name: "Decks",
    components: {
        DeckList
    },
    created() {
        deckService.getAllDecks().then( response => {
            if( response.status == 200 ) {
                this.$store.commit('SET_DECKS', response.data);
            }
        })
    }
}
</script>

<style>

</style>