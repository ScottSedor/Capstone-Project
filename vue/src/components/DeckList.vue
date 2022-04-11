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
</style>