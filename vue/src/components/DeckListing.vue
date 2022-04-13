<template>
  <router-link v-bind:to="{name: 'cards-in-deck', params: {deckId: deck.deckId}}">
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
   border: 1px black solid;
   width: 15rem;
   height: 10rem;
   margin: 20px;
   border-radius: 5px;
   display: flex;
   flex-direction: column;
   text-align: center;
   justify-content: space-between;
   
}

div.deck-listing:hover {
  background: whitesmoke;
}
 
</style>