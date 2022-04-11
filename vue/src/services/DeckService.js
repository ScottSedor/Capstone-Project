import axios from 'axios';

export default {

    getAllDecks() {
        return axios.get('/decks');
    
    },
    getCardsInDeck(deckId) {
        return axios.get('/decks/' + deckId)
    }

}