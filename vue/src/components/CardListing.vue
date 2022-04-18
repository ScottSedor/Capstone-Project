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
   /* border: 2px black solid;    */
   background-color: rgba(106, 168, 79, 0.596);
   width: 16rem;
   height: 10rem;
   margin: 20px;
   border-radius: 4px;
   display: flex;
   flex-direction: column;
   text-align: center;
   justify-content: center;
   
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