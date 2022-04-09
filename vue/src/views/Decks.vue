<template>
  <div class="decks">

  </div>
</template>

<script>
import deckService from '@/services/DeckService';

export default {
    name: "Decks",
    components: {

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