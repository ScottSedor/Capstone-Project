<template>
  <div>
    <div class="card-detail" v-bind:card="activeCard">
      <div class="card-front">
        <h2>{{ card.cardFront }}</h2>
      </div>
      <div class="card-back">
        <h2>{{ card.cardBack }}</h2>
      </div>
    </div>
      <p>{{ card.keywords }}</p>
  </div>
</template>

<script>

export default {
    name: "card-info",
    computed: {
      card() {
        return this.$store.state.cardsInDeck.find((c) => {
            return c.cardId == this.$store.state.activeCard;
        });
      }
    }
    
}
</script>

<style>

</style>