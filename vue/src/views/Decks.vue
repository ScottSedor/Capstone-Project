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
        box-shadow:
        0 2.8px 2.2px rgba(0, 0, 0, 0.034),
        0 6.7px 5.3px rgba(0, 0, 0, 0.048),
        0 6.5px 5px rgba(0, 0, 0, 0.06),
        0 12.3px 7.9px rgba(0, 0, 0, 0.072),
        0 41.8px 23.4px rgba(0, 0, 0, 0.086),
        0 50px 80px rgba(0, 0, 0, 0.12); 
    }
    div.deck-list {
        background: rgb(240, 240, 240);
        border-bottom-left-radius: 20px;
        border-bottom-right-radius: 20px;
        /* box-shadow:
        0 2.8px 2.2px rgba(0, 0, 0, 0.034),
        0 6.7px 5.3px rgba(0, 0, 0, 0.048),
        0 6.5px 5px rgba(0, 0, 0, 0.06),
        0 12.3px 7.9px rgba(0, 0, 0, 0.072),
        0 41.8px 23.4px rgba(0, 0, 0, 0.086),
        0 50px 80px rgba(0, 0, 0, 0.12); */
    }
    div.decks p {
        font-size: 1.5rem;
    }
    
</style>