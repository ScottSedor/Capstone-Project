<template>
  <div>
    <div class="single-card" v-bind:card="activeCard">
      <div class="card-front">
        <h2>{{ card.cardFront }}</h2>
        <p>Keywords: {{ card.keywords }}</p>
      </div>
      <div class="card-back">
        <h2>{{ card.cardBack }}</h2>
      </div>
  </div>
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

div.single-card {
  display: flex;
  justify-content: center; 
}

div.card-front, div.card-back {
 border: 2px black solid;
   width: 20rem;
   height: 10rem;
   margin: 20px;
   border-radius: 5px;
   display: flex;
   flex-direction: column;
   text-align: center;
   justify-content: center;
  
}

div.card-front > p {
  justify-content: flex-end;
  align-items: flex-end;
  font-weight: lighter;
  font-size: small;
}

</style>