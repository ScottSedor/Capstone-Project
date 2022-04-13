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
   border: 2px black solid;
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
  background: whitesmoke;
}

div.deck-listing > h2 {
  color: black;
  text-decoration: none !important;

}
 
</style>