<template>
  <div class="card-list">
      <p v-if="cards.length === 0">No Cards Found in Deck</p>
      <card-listing v-else v-for="card in cards"
            v-bind:key="card.id"
            v-bind:card="card" />
  </div>
</template>

<script>
import CardListing from '@/components/CardListing'; 

export default {
    name: 'card-list',
    components: {
        CardListing 
    },
    computed: {
        cards() {
            const cards = this.$store.state.cardsInDeck;
            return cards;
        }
    }
}
</script>

<style>

</style>