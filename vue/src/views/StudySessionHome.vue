<template>
    <div class="study-session-home">
        <div class="end-study-session" v-show="currentIndex != 0">
            <h1 id="flashcards">Flashcards Completed: {{ currentIndex + 1 }}</h1>
            <h1 id="percentage">Percent Complete: {{percentComplete}}%</h1>
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
    }
    div.end-study-session {
        display: grid;
        grid-template-columns: 3fr 1fr;
        grid-template-areas: 
            "cards restart"
            "percent restart";
    }
    h1#flashcards {
        color: #274e13ff;
        grid-area: cards;
        text-align: center;
    }
    h1#percentage {
        color: #274e13ff;
        grid-area: percent;
        text-align: center;
    }
    a#restart {
        grid-area: restart;
    }
    img.restart-icon {
        height: 120px;
        width: 120px;
    }
    div.deck-title {
        color: #274e13ff;
    }

</style>