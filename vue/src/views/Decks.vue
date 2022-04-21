<template>
  <div class="decks">
      <div class="deck-form">
        <create-deck-form />
      </div>
      <div class="deck-list">
        <deck-list />
      </div>    
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
        /* padding-top: 60px; */
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        flex-direction: column;
        font-family: 'Roboto Mono', monospace;
    }
    div.deck-form {
        display: flex;
        justify-content: center;
        padding-top: 20px;
        background: rgb(240, 240, 240);
        border-top-left-radius: 20px;
        border-top-right-radius: 20px;
        }
    div.deck-list {
        background: rgb(240, 240, 240);
        border-bottom-left-radius: 20px;
        border-bottom-right-radius: 20px;
         
    }
    div.decks p {
        font-size: 1.5rem;
    }
    
</style>