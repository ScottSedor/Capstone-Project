<template>
  <div class="container">
    <div class="study-session" v-if="currentCard">
        <div class="prev-button">
          <button id="previous" data-toggle="popover" title="Back to Previous Card" v-on:click="previousCard" v-show="currentIndex != 0 && cards.length > 0">
            <img class="back-img" src="..\assets\back-arrow-icon.png" alt="back arrow icon">
          </button>
        </div>
        <div class="body-container">
          <div class="body">
            <div class="flip-card-container current-card">
                <div class="flip-card" v-bind:class="{'is-flipped': isFlipped}" v-on:click="toggleFlip">
                    <div class="flip-card-front">{{currentCard.cardFront}}</div>
                    <div class="flip-card-back">{{currentCard.cardBack}}</div>
                </div>
            </div>
          </div>
        </div>
        <div class="right-wrong-buttons">
          <div class="wrong-button" >
            <span id="wrong" v-on:click="markedWrong">WRONG</span>
          </div>
          <div class="right-button" >
            <span id="right" v-on:click="markedRight">RIGHT</span>
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
import deckService from '@/services/DeckService';

export default {
  data() {
    return {
        currentIndex: 0,
        isFlipped: false,
        // card: document.querySelector('.card'),
        markedCorrect: false,
        rightAnswers: 0,
        wrongAnswers: 0,
        previousAnswerCorrect: false
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
        if (this.markedCorrect === true) {
          this.rightAnswers++;
          this.$store.commit('SET_CURRENT_RIGHT_ANSWERS', this.rightAnswers);
          this.previousAnswerCorrect = true;
        } else {
          this.wrongAnswers++;
          this.$store.commit('SET_CURRENT_WRONG_ANSWERS', this.wrongAnswers);
          this.previousAnswerCorrect = false;
        }
        this.markedCorrect = false;
        this.isFlipped = false;

        // const card = document.querySelector('.flip-card');
        // if (card.classList.contains('is-flipped')) {
        //   card.classList.toggle('is-flipped');
        // }

        this.$store.commit('SET_CURRENT_INDEX', this.currentIndex);
      },
    previousCard() {
        this.currentIndex = this.currentIndex -1;

        if (this.previousAnswerCorrect === true) {
          this.rightAnswers--;
          this.$store.commit('SET_CURRENT_RIGHT_ANSWERS', this.rightAnswers);
        } else {
          this.wrongAnswers--;
          this.$store.commit('SET_CURRENT_WRONG_ANSWERS', this.wrongAnswers);
        }

        // const card = document.querySelector('.flip-card');
        // if (card.classList.contains('is-flipped')) {
        //   card.classList.toggle('is-flipped');
        // }
    },
    cancelStudySession() {
        if (confirm('End this study session?')) {
          this.$router.push({name: 'study-session-home'});
        }
    },
    markedRight() {
      this.markedCorrect = true;
    },
    markedWrong() {
      this.markedCorrect = false;
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
  },
  // mounted() {
  //   var card = document.querySelector('.flip-card');
  //   card.addEventListener( 'click', function() {
  //     card.classList.toggle('is-flipped');
  //   });
  // }
}
</script>

<style>
div.study-session {
  display: grid;
  grid-template-columns: 1fr 4fr 1fr;
  grid-template-areas: 
    "prev card next"
    ". answer ."
    ". end .";
  background-size: cover;
}
div.prev-button {
  grid-area: prev;
  display: flex;
  align-items: center;
}
div.body-container {
  grid-area: card;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 15px;
}
.body {
    margin-top: 10px;
    font-family: Arial, Helvetica, sans-serif;
    width: 42vw;
    height: 25vw;
}
.flip-card-container {
    width: 42vw;
    height: 25vw;
    perspective: 1000px;
}
.flip-card {
    border: 3px solid black;
    border-radius: 8px;
    position: relative;
    width: 42vw;
    height: 25vw;
    transition: transform 0.4s;
    transform-style: preserve-3d;
}
.flip-card.is-flipped {
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
div.right-wrong-buttons {
  grid-area: answer;
  display:flex;
  justify-content: center;
}
div.wrong-button {
  background-color: tomato;
}
div.right-button {
  background-color: dodgerblue;
}
div.right-button, div.wrong-button {
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px solid black;
  border-radius: 2px;
  max-width: 21vw;
  flex-grow: 1;
  height: 30px;
}
div.end-button {
  grid-area: end;
  max-width: 42vw;
  display: flex;
  justify-content: center;
  flex-grow: 1;
  align-items: center;
}
span#end {
  min-width: 20vw;
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