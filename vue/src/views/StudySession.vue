<template>
  <div class="container">
    <div class="study-session">
        <div class="prev-button">
          <button id="previous" data-toggle="popover" title="Back to Previous Card" v-on:click="previousCard" v-show="currentIndex != 0 && cards.length > 0">
            <img class="back-img" src="..\assets\back-arrow-icon.png" alt="back arrow icon">
          </button>
        </div>
        <div class="current-card" v-on:click="toggleFlip()">
          <transition name="flip" >
              <p v-if="cards.length === 0">No Cards Found in Deck. Please Select Another Deck to Study.</p>
              <h2 v-else class="card">
                {{ isFlipped ? currentCard.cardBack : currentCard.cardFront }}
              </h2>
          </transition>
        </div>
        <div class="next-button">
          <button id="next" data-toggle="popover" title="Next Card" v-on:click="nextCard" v-show="currentIndex != (cards.length - 1) && cards.length > 0">
            <img class="next-img" src="..\assets\next-arrow-icon.png" alt="next arrow icon">
          </button>
        </div>
        <div class="end-button">
          <span id="end" v-on:click="cancelStudySession" v-show="currentIndex != (cards.length - 1)">End Study Session</span>
        </div>
    </div>
    <div class="cancel">
          <button id="cancel" v-on:click="cancelStudySession" v-show="currentIndex != (cards.length - 1)">End Study Session</button>
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
div.current-card {
  grid-area: card;
  transition: all 0.3s ease;
  border-radius: 5px;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: rgba(106, 168, 79, 0.596);
  padding: 10px;
  height: 30vw;
  width: 48vw;
  cursor: pointer;
  will-change: transform;
  margin-top: 10px;
  border: 3px solid black;
  user-select: none;
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

  
 */

</style>