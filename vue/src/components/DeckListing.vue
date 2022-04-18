<template>
  <router-link v-bind:to="{name: 'cards-in-deck', params: {deckId: deck.deckId}}" style="text-decoration: none">
    <div class="deck-listing">
        <h2>{{deck.deckTitle}}</h2>
    </div>
  </router-link>
</template>

<script>
export default {
    name: 'deck-listing',
    props: ['deck']

}
</script>

<style>
  div.deck-listing {
   background-color: rgba(106, 168, 79, 0.596); 
   border: 3px #274e13ff solid;
   width: 16rem;
   height: 10rem;
   margin: 20px;
   border-radius: 5px;
   display: flex;
   flex-direction: column;
   text-align: center;
   justify-content: center;
   align-content: center;
   
}

div.deck-listing:hover {
  background: #93c47dff;
}

div.deck-listing > h2 {
  color: white;
  text-decoration: none !important;

}
 
</style>