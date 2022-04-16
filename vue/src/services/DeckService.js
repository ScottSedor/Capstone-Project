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
    },
    search(deckId, keyword) {
        return axios.get('/decks/' + deckId + '/search?keyword=' + keyword)
    },
    updateDeck(deckId, deckRequest) {
        return axios.put('/decks/' + deckId + '/info', deckRequest)
    },
    getDeckInfoById(deckId) {
        return axios.get('/decks/' + deckId + '/info')
    },
    deleteCardFromDeck(deckId, cardId) {
        return axios.delete('/decks/' + deckId + '/card/' + cardId)
    },
    addCardToDeck(deckId, cardId) {
        return axios.post('/decks/' + deckId + '/card/' + cardId)
    }


}