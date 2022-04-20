<template>
  <div class="deck-list">
      <p v-if="decks.length === 0">No Decks Found</p>
      <deck-listing v-else v-for="deck in decks"
            v-bind:key="deck.id"
            v-bind:deck="deck" />
  </div>
</template>

<script>
import DeckListing from '@/components/DeckListing';

export default {
    name: 'deck-list',
    components: {
        DeckListing
    },
    computed: {
        decks() {
            const decks = this.$store.state.decks;
            return decks;
        }
    }
}
</script>

<style>

    div.deck-list {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
    }
    div.deck-listing {
    height: 300px;
    width: 400px;  
    border-radius: 40px;
    border-left: solid 15px #274e13ff; 
    border-bottom: solid 13px #274e13ff;
    box-shadow:
    0 2.8px 2.2px rgba(0, 0, 0, 0.034),
    0 6.7px 5.3px rgba(0, 0, 0, 0.048),
    0 12.5px 10px rgba(0, 0, 0, 0.06),
    0 22.3px 17.9px rgba(0, 0, 0, 0.072),
    0 41.8px 33.4px rgba(0, 0, 0, 0.086),
    0 100px 80px rgba(0, 0, 0, 0.12);
    }
    div.deck-listing:hover {
        transform: scale(1.02);
    }
</style>