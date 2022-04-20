<template>
  <div>
    <div class="single-card">
      <a @click="$router.go(-1)">
         <img class="back-arrow-icon" data-toggle="popover" title="Back to Cards" src="..\assets\back-arrow-icon.png" alt="back arrow icon"> 
      </a>
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
import deckService from '@/services/DeckService'

export default {
    name: "card-info",
    computed: {
      card() {
        return this.$store.state.cardsInDeck.find((c) => {
            return c.cardId == this.$route.params.cardId;
        });
      }
    },
    created() {
      const deckId = this.$route.params.deckId;
      // const cardId = this.$route.params.cardId;
      this.$store.commit('SET_ACTIVE_DECK', deckId);
      deckService.getCardsInDeck(deckId).then( response => {
          if (response.status == 200) {
            this.$store.commit('SET_CARDS', response.data);
          }
      });
    }
    
}
</script>

<style>
div {
  color: white;
}

div#card-title {
  color: #274e13ff;
}

div.single-card {
  display: grid;
  grid-template-columns: 1fr 2fr 2fr 1fr;
  grid-template-areas: 
    "btn front back .";
  justify-content: center; 
}

div.card-front {
  grid-area: front;
  display: flex;
  flex-direction: column;
  align-items: center;
}

div.card-back {
  grid-area: back;
  display: flex;
  flex-direction: column;
  align-items: center;
}

div.card-info {
   background-color: rgba(106, 168, 79, 0.596);
   border: 3px #274e13ff solid;
   width: 25rem;
   height: 12rem;
   margin: 5px;
   margin-bottom: 20px;
   border-radius: 4px;
   padding: 5px;
   display: flex;
   flex-direction: column;
   align-content: center;
   text-align: center;
   justify-content: flex-start;
   overflow-y: auto;
 
   box-shadow:
    0 2.8px 2.2px rgba(0, 0, 0, 0.034),
    0 6.7px 5.3px rgba(0, 0, 0, 0.048),
    0 12.5px 10px rgba(0, 0, 0, 0.06),
    0 22.3px 17.9px rgba(0, 0, 0, 0.072),
    0 41.8px 33.4px rgba(0, 0, 0, 0.086),
    0 100px 80px rgba(0, 0, 0, 0.12);
}

div.card-info > h2 {
  padding: 5px;
}

div.card-front > p {
  justify-content: flex-end;
  align-items: flex-end;
  font-weight: lighter;
  font-size: small;
}

a {
  grid-area: btn;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
}

a:hover {
  transform: scale(1.1);
}

a > img.back-arrow-icon {
  width: 70px;
  height: 70px; 
}
.edit-button {
  margin-top: 30px;
}
</style>