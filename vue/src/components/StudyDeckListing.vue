<template>
  <router-link v-bind:to="{name: 'study-session', params: {deckId: deck.deckId}}" style="text-decoration: none">
    <div class="study-deck-listing">
        <h2>{{deck.deckTitle}}</h2>
    </div>
  </router-link>
</template>

<script>
export default {
    name: 'study-deck-listing',
    props: ['deck']

}
</script>

<style>
  div.study-deck-listing {
   background-color: rgba(106, 168, 79, 0.596); 
   border: 3px #274e13ff solid;
   /* width: 16rem;
   height: 10rem; */
   margin: 20px;
   border-radius: 5px;
   display: flex;
   flex-direction: column;
   text-align: center;
   justify-content: center;
   align-content: center;
    height: 300px;
    width: 400px;  
    border-radius: 40px;
    border-left: solid 15px #274e13ff; 
    border-bottom: solid 13px #274e13ff;


     box-shadow:
    0 2.8px 2.2px rgba(0, 0, 0, 0.034),
    0 6.7px 5.3px rgba(0, 0, 0, 0.048),
    0 12.5px 10px rgba(0, 0, 0, 0.06),
    0 22.3px 17.9px rgba(0, 0, 0, 0.072),
    0 41.8px 33.4px rgba(0, 0, 0, 0.086),
    0 100px 80px rgba(0, 0, 0, 0.12);
   
}

div.study-deck-listing:hover {
  background: #93c47dff;
}

div.study-deck-listing > h2 {
  color: white;
  text-decoration: none !important;

}
 
</style>