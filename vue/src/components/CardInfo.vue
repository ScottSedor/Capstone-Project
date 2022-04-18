<template>
  <div>
    <div class="single-card">
      <a @click="$router.go(-1)">Back</a>
      <div class="card-front">
        <div id="card-title">
          <h2>Card Front</h2>
        </div>
        <div class="card-info">
          <h2>{{ card.cardFront }}</h2>
          <p>Keywords: {{ card.keywords }}</p>
        </div>
      </div>
      <div class="card-back">
        <div id="card-title">
          <h2>Card Back</h2>
        </div>
        <div class="card-info">
          <h2>{{ card.cardBack }}</h2>
        </div>
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
            return c.cardId == this.$route.params.cardId;
        });
      }
    }
    
}
</script>

<style>
div {
  color: white;
}

div.single-card {
  display: flex;
  justify-content: center; 
}

div.card-front, div.card-back {
  display: flex;
  flex-direction: column;
  align-items: center;
}

div.card-info {
   background-color: rgba(106, 168, 79, 0.596);
   border: 3px #274e13ff solid;
   width: 20rem;
   height: 10rem;
   margin: 5px;
   margin-bottom: 20px;
   border-radius: 4px;
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