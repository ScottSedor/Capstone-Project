<template>
  <div class="card-list">
      <p v-if="cards.length === 0">No Cards Found in Deck</p>
      <card-listing v-else v-for="card in cards"
            v-bind:key="card.cardId"
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
   
    div.card-list {
        
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        background: rgb(240, 240, 240);
        box-shadow:
        0 2.8px 2.2px rgba(0, 0, 0, 0.034),
        0 6.7px 5.3px rgba(0, 0, 0, 0.048),
        0 6.5px 5px rgba(0, 0, 0, 0.06),
        0 12.3px 7.9px rgba(0, 0, 0, 0.072),
        0 41.8px 23.4px rgba(0, 0, 0, 0.086),
        0 50px 80px rgba(0, 0, 0, 0.12);
        border-radius: 15px;
        margin-top: 40px;

    }
</style>