import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

/*
 * The authorization header is set for axios when you login but what happens when you come back or
 * the page is refreshed. When that happens you need to check for the token in local storage and if it
 * exists you should set the header so that it will be attached to each request
 */
const currentToken = localStorage.getItem('token')
const currentUser = JSON.parse(localStorage.getItem('user'));

if(currentToken != null) {
  axios.defaults.headers.common['Authorization'] = `Bearer ${currentToken}`;
}

export default new Vuex.Store({
  state: {
    token: currentToken || '',
    user: currentUser || {},
    decks: [],
    cardsInDeck: [],
    searchResults: [],
    activeCard: 0,
    activeDeckId: 0,
    activeDeck: {}
  },
  mutations: {
    SET_AUTH_TOKEN(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
    },
    SET_USER(state, user) {
      state.user = user;
      localStorage.setItem('user',JSON.stringify(user));
    },
    LOGOUT(state) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      state.token = '';
      state.user = {};
      axios.defaults.headers.common = {};
    },
    SET_DECKS(state, decks) {
      state.decks = decks;
    },
    SET_CARDS(state, cardsInDeck) {
      state.cardsInDeck = cardsInDeck;
    },
    ADD_TO_DECKS(state, deck) {
      state.decks.push(deck);
    },
    ADD_TO_CARDS(state, card) {
      state.cardsInDeck.push(card);
    },
    SET_ACTIVE_CARD(state, cardId) {
      state.activeCard = cardId;
    },
    SET_ACTIVE_DECK_ID(state, deckId) {
      state.activeDeckId = deckId;
    },
    SET_ACTIVE_DECK(state, deck) {
      state.activeDeck = deck;
    },
    SET_SEARCH_RESULTS(state, cards) {
      state.searchResults = cards;
    }
  }
})
