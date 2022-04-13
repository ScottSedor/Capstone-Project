import axios from 'axios';

export default {

    getAllDecks() {
        return axios.get('/decks');
    },
    getCardsInDeck(deckId) {
        return axios.get('/decks/' + deckId)
    },
    createDeck(deckRequest) {
        return axios.post('/decks', deckRequest)
    },
    createCard(deckId, cardRequest) {
        return axios.post('/decks/' + deckId, cardRequest)
    },
    modifyCard(deckId, cardId, cardRequest) {
        return axios.put('/decks/' + deckId + '/card/' + cardId, cardRequest)
    }

}