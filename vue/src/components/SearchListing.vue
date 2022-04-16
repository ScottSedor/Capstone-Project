<template>
  <div class="card-listing" @dragstart="drag($event)" draggable="true">
    <h2>{{card.cardFront}}</h2>
  </div>
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
    },
    methods: {
        drag(event) {
            event.dataTransfer.setData('cardId', this.card.cardId);
            // this.$store.commit('SET_DRAGGED_CARD', ev.data)
        },
    }
}
</script>

<style>
  div.card-listing {
    background-color: rgba(106, 168, 79, 0.596);
   border: 2px black solid;
   width: 16rem;
   height: 10rem;
   margin: 20px;
   border-radius: 4px;
   display: flex;
   flex-direction: column;
   text-align: center;
   justify-content: center;
   
}

div.card-listing > h2 {
  color: white;
}

div.card-listing:hover {
  background: #93c47dff;
}
</style>