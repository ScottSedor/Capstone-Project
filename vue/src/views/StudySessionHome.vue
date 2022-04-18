<template>
    <div class="study-session-home">
        <div class="end-study-session" v-show="currentIndex != 0">
            <h1>Questions Complete: {{ currentIndex + 1 }}</h1>
        </div>
        <div class="decks">
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
            const percentage = this.currentIndex / cards.length;
            return percentage;    
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

</style>