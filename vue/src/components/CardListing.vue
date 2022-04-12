<template>
<router-link v-bind:to="{name: 'card-info', params: {cardId: card.cardId}}">
  <div class="card-listing">
    <h2>{{card.cardFront}}</h2>
  </div>
</router-link>
</template>

<script>
export default {
    name: "card-listing",
    props: ['card']
}
</script>

<style>
  div.card-listing {
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

div.card-listing:hover {
  background: whitesmoke;
}
</style>