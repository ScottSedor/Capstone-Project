<template>
    <div class="study-session-home">
        <div class="end-study-session" v-show="currentIndex != 0">
                <div class="p">
                    <p id ="previous">Previous Session Results: </p>
                    <p id="cards">Flashcards Studied: {{ currentIndex + 1 }}</p>
                    <p id="percent">Deck Completion: {{percentComplete}}%</p>
                    <p id="right">Correct Answers: {{ rightAnswers }} </p>
                    <p id="wrong">Incorrect Answers: {{ wrongAnswers }} </p>
                </div>
            <a id="restart" @click="$router.go(-1)">
                <img class="restart-icon" data-toggle="popover" title="Restart Study Session" src="..\assets\restart-icon.png" alt="restart icon">
            </a>
        </div>
        <div class="decks">
            <div class="deck-title">
                <h2>Choose a Deck to Study:</h2>
            </div>
            <div class="deck-list">
                    <p v-if="decks.length === 0">No Decks Found</p>
                    <study-deck-listing v-else v-for="deck in decks"
                        v-bind:key="deck.id"
                        v-bind:deck="deck" />
            </div>
        </div>  
    </div>
</template>

<script>
import StudyDeckListing from '@/components/StudyDeckListing'
import deckService from '@/services/DeckService'

export default {
    components: {
        StudyDeckListing
    },
    computed: {
        decks() {
            const decks = this.$store.state.decks;
            return decks;
        },
        currentIndex() {
            const currentIndex = this.$store.state.currentStudyIndex;
            return currentIndex;
        },
        percentComplete() {
            let cards = this.$store.state.cardsInDeck;
            const percentage = (this.currentIndex / (cards.length - 1)) * 100;
            return percentage.toFixed();    
        },
        rightAnswers() {
            const rightAnswers = (this.$store.state.currentRightAnswers);
            return rightAnswers;
        },
        wrongAnswers() {
            const wrongAnswers = (this.$store.state.currentWrongAnswers);
            return wrongAnswers;
        }
    },
     created() {
        deckService.getAllDecks().then( response => {
            if( response.status == 200 ) {
                this.$store.commit('SET_DECKS', response.data);
            }
        })
    }

}
</script>

<style>
    h2 {
        margin-left: 30px;
    }
    div.deck-list {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        
    }
    div.study-deck-listing:hover {
        transform: scale(1.02);
    }
    div.decks {
        margin-top: 60px;
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        flex-direction: column;
        font-family: 'Roboto Mono', monospace;
        background: rgb(240, 240, 240);
        box-shadow:
            0 2.8px 2.2px rgba(0, 0, 0, 0.034),
            0 6.7px 5.3px rgba(0, 0, 0, 0.048),
            0 6.5px 5px rgba(0, 0, 0, 0.06),
            0 12.3px 7.9px rgba(0, 0, 0, 0.072),
            0 41.8px 23.4px rgba(0, 0, 0, 0.086),
            0 50px 80px rgba(0, 0, 0, 0.12);
         border-radius: 5px;
    }
    div.end-study-session {
       display: flex;
       justify-content: space-evenly;
       background: rgb(240, 240, 240);
        box-shadow:
            0 2.8px 2.2px rgba(0, 0, 0, 0.034),
            0 6.7px 5.3px rgba(0, 0, 0, 0.048),
            0 6.5px 5px rgba(0, 0, 0, 0.06),
            0 12.3px 7.9px rgba(0, 0, 0, 0.072),
            0 41.8px 23.4px rgba(0, 0, 0, 0.086),
            0 50px 80px rgba(0, 0, 0, 0.12);
         border-radius: 5px;
    }
    p {
        color: #274e13ff;
        font-size: 18px;
        text-align: left;
    }
    div.p {
        display: flex;
        flex-direction: column;
        margin-top: 20px;
    }
    div > p {
        text-align: left;
    }
    img.restart-icon {
        height: 20vw;
        width: 20vw;
    }
    div.deck-title {
        color: #274e13ff;
    }
    p#previous {
        font-size: x-large;
        font-weight: bold;
    }

</style>