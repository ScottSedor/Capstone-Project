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
    div.decks {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
    }
    div.decks p {
        font-size: 1.5rem;
    }
</style>