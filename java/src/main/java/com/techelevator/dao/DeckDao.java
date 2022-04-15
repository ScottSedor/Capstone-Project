package com.techelevator.dao;

import com.techelevator.model.Card;
import com.techelevator.model.Deck;
import com.techelevator.model.DeckRequest;

import java.util.List;

public interface DeckDao {

    List<Deck> viewAllDecks();
    Deck createDeck(String username, String deckTitle, String deckDescription);
    void modifyDeck(int deckId, DeckRequest deckRequest);
    Deck getDeckInfoById(int deckId);
    void deleteCardFromDeck(int deckId, int cardId);
    List<Card> searchByKeyword(String keyword, int deckId);
}
