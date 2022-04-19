<template>
  <div class="container">
    <div class="study-session">
        <div class="prev-button">
          <button id="previous" data-toggle="popover" title="Back to Previous Card" v-on:click="previousCard" v-show="currentIndex != 0 && cards.length > 0">
            <img class="back-img" src="..\assets\back-arrow-icon.png" alt="back arrow icon">
          </button>
        </div>
        <div class="body">
          <div class="flip-card-container current-card">
              <div class="flip-card">
                  <div class="flip-card-front">{{currentCard.cardFront}}</div>
                  <div class="flip-card-back">{{currentCard.cardBack}}</div>
              </div>
          </div>
        </div>
        <div class="next-button">
          <button id="next" data-toggle="popover" title="Next Card" v-on:click="nextCard" v-show="currentIndex != (cards.length - 1) && cards.length > 0">
            <img class="next-img" src="..\assets\next-arrow-icon.png" alt="next arrow icon">
          </button>
        </div>

        <div class="end-button">
          <span id="end" v-on:click="cancelStudySession" >End Study Session</span>
        </div>

    </div>
  </div>   
</template>

<script>
import deckService from '@/services/DeckService'

export default {
  data() {
    return {
        currentIndex: 0,
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
        this.isFlipped = false;
        this.$store.commit('SET_CURRENT_INDEX', this.currentIndex);
      },
    previousCard() {
        this.currentIndex = this.currentIndex -1;
        this.isFlipped = false;
    },
    cancelStudySession() {
        if (confirm('End this study session?')) {
          this.$router.push({name: 'study-session-home'});
        }
    }
  },
  created() {
    this.currentIndex = 0;
    this.$store.commit('SET_CURRENT_INDEX', this.currentIndex);
    const deckId = this.$route.params.deckId;
    this.$store.commit('SET_ACTIVE_DECK', deckId);
    deckService.getCardsInDeck(deckId).then(response => {
      if (response.status == 200) {
        this.$store.commit('SET_CARDS', response.data);
      }
    });
  }
}
</script>

<style>
div.study-session {
  display: grid;
  grid-template-columns: 1fr 3fr 1fr;
  grid-template-areas: 
    "prev card next"
    ". end .";
  background-size: cover;
}
div.prev-button {
  grid-area: prev;
  display: flex;
  align-items: center;
}
.body {
    grid-area: card;
    margin-top: 10px;
    font-family: Arial, Helvetica, sans-serif;
    width: 42vw;
    height: 25vw;
    display: flex;
    justify-content: center;
    align-items: center;
}
.flip-card-container {
    width: 42vw;
    height: 25vw;
    perspective: 1000px;
}
.flip-card {
    border: 3px solid black;
    position: relative;
    width: 42vw;
    height: 25vw;
    transition: transform 1s;
    transform-style: preserve-3d;
}
.flip-card-container:hover .flip-card {
    transform: rotateY(180deg);
}
.flip-card-container:hover .flip-card {
    transform: rotateY(180deg);
}
.flip-card-front, .flip-card-back {
    text-align: center;
    position: absolute;
    width: 42vw;
    height: 25vw;
    backface-visibility: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 2rem;
}
.flip-card-front {
    background-color: rgb(94, 148, 71);
    color: #fff;
}
.flip-card-back {
    background-color: rgb(94, 148, 71);
    color: #fff;
    transform: rotateY(180deg);
}
div.next-button {
  grid-area: next;
  display: flex;
  align-items: center;
}
div.end-button {
  grid-area: end;
}
button#previous, button#next {
  background: none;
  border: none;
}
button#previous:hover, button#next:hover {
  transform: scale(1.1);
}
img.back-img, img.next-img {
  height: 175px;
  width: 175px;
  border-radius: 50px;
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

}
span#end, div.cancel:hover {
  transform: scale(1.1);
}
span#end, div.cancel{
  border: solid 2px black;
  margin-top: 20px;
  color: #274e13ff;
  display: flex;
  justify-content: center;
  cursor: pointer;
}

</style>