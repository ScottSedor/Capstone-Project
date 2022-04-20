<template>
  <router-link v-bind:to="{name: 'card-info', params: {deckId: currentDeckId, cardId: card.cardId}}" style="text-decoration: none">
    <div class="card-listing">
      <h2>{{card.cardFront}}</h2>
    </div>
  </router-link>
</template>

<script>
export default {
    name: "card-listing",
    props: ['card'],
    computed: {
      currentDeckId() {
        const deckId = this.$route.params.deckId;
        return deckId;
      } 
    }
}
</script>

<style>
  div.card-listing {
   background-color: rgba(106, 168, 79, 0.596);
   width: 200px;
   height: 300px;
   margin: 20px;
   border-radius: 30px;
   display: flex;
   flex-direction: column;
   text-align: center;
   justify-content: center;
   box-shadow:
    0 2.8px 2.2px rgba(0, 0, 0, 0.034),
    0 6.7px 5.3px rgba(0, 0, 0, 0.048),
    0 12.5px 10px rgba(0, 0, 0, 0.06),
    0 22.3px 17.9px rgba(0, 0, 0, 0.072),
    0 41.8px 33.4px rgba(0, 0, 0, 0.086),
    0 100px 80px rgba(0, 0, 0, 0.12);
}

div.card-listing:hover {
    transform: scale(1.02);
  }

div.card-listing > h2 {
  color: white;
}

div.card-listing:hover {
  background: #93c47dff;
}
</style>