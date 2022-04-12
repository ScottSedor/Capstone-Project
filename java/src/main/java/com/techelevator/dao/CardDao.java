package com.techelevator.dao;

import com.techelevator.model.Card;
import com.techelevator.model.CardRequest;

import java.util.List;

public interface CardDao {

    List<Card> viewCardsInDeck(int deckID);
    Card addCard(CardRequest cardRequest, String username, int deckId);
}
