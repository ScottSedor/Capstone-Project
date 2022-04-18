<template>
  <div class="study-session">
          <p v-if="cards.length === 0">No Cards Found in Deck. Please Select Another Deck to Study.</p>
      <div v-else class="current-card" v-on:click="toggleFlip()">
        <transition name="flip" >
            <h2 class="card">
              {{ isFlipped ? currentCard.cardBack : currentCard.cardFront }}
            </h2>
        </transition>
      </div>
   </div>
</template>

<script>
import deckService from '@/services/DeckService'

export default {
  data() {
    return {
        currentIndex: 0,
        currentDeck: 1,
        isFlipped: false
    }
  },
  computed: {
    cards() {
        const cards = this.$store.state.cardsInDeck;
            return cards;
      },
    currentCard() {
        return this.cards[this.currentIndex];
    }
  },
  methods: {
    toggleFlip() {
      this.isFlipped = !this.isFlipped;
    },
    nextCard() {
        this.currentIndex = this.currentIndex + 1;
      },
    previousCard() {
        this.currentIndex = this.currentIndex -1;
    }

  },
  created() {
    // const deckId = this.$route.params.deckId;
    this.$store.commit('SET_ACTIVE_DECK', this.currentDeck);
    deckService.getCardsInDeck(this.currentDeck).then(response => {
      if (response.status == 200) {
        this.$store.commit('SET_CARDS', response.data);
      }
    });
  }
}
</script>

<style>
/* ul {
    padding-left: 0;
    display: flex;
    flex-flow: row wrap;
  }
  
  div {
    list-style-type: none;
    padding: 10px 10px;
    transition: all 0.3s ease;
  }

   .card {
    display: block;
    width: 150px;
    height: 175px;
    padding: 80px 50px;
    background-color: #51aae5;
    border-radius: 7px;
    margin: 5px;
    text-align: center;
    line-height: 27px;
    cursor: pointer;
    position: relative;
    color: #fff;
    font-weight: 600;
    font-size: 20px;
    -webkit-box-shadow: 9px 10px 22px -8px rgba(209,193,209,.5);
    -moz-box-shadow: 9px 10px 22px -8px rgba(209,193,209,.5);
    box-shadow: 9px 10px 22px -8px rgba(209,193,209,.5);
    will-change: transform;
  }
  
  div:hover{
    transform: scale(1.1);
  }

  .flip-enter-active {
    transition: all 0.4s ease;
  }
  
  .flip-leave-active {
    display: none;
  }
  
  .flip-enter, .flip-leave {
    transform: rotateY(180deg);
    opacity: 0;
  
  } */

</style>