<template>
  <div class="decks">
      <create-deck-form />
      <deck-list />
  </div>
</template>

<script>
import deckService from '@/services/DeckService'
import DeckList from '@/components/DeckList'
import CreateDeckForm from '@/components/CreateDeckForm'

export default {
    name: "Decks",
    components: {
        DeckList,
        CreateDeckForm
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
        flex-direction: column;
    }
    div.decks p {
        font-size: 1.5rem;
    }
</style>