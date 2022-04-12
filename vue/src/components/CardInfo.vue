<template>
  <div>
    <div class="card-detail">
      <div class="card-front">
        <h2>{{ card.cardFront }}</h2>
      </div>
      <div class="card-back">
        <h2>{{ card.cardBack }}</h2>
      </div>
    </div>
      <p>{{ card.cardKeywords }}</p>
  </div>
</template>

<script>

export default {
    name: "card-info",
    computed: {
      card() {
        return this.$store.state.cardsInDeck.find((c) => {
            return c.cardId == this.$store.state.activeCardId;
        });
      }
    }
    
}
</script>

<style>

</style>