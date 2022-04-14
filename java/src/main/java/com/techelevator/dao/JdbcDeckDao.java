package com.techelevator.dao;

import com.techelevator.model.Card;
import com.techelevator.model.Deck;

import java.util.ArrayList;
import java.util.List;

import com.techelevator.model.DeckRequest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

@Component
public class JdbcDeckDao implements DeckDao {

    private JdbcTemplate jdbcTemplate;

    public JdbcDeckDao (JdbcTemplate jdbcTemplate)  {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Deck> viewAllDecks() {

        List<Deck> decks = new ArrayList<Deck>();
        String sql = "SELECT deck_id, deck_title " +
                     "FROM decks;";

        SqlRowSet rows = jdbcTemplate.queryForRowSet(sql);

        while(rows.next()) {
            Deck deck = new Deck();
            deck.setDeckId(rows.getInt("deck_id"));
            deck.setDeckTitle(rows.getString("deck_title"));
            decks.add(deck);
        }
        return decks;
    }

    @Override
    public Deck createDeck(String username, String deckTitle, String deckDescription) {
        int userId = getIdFromUsername(username);
        String sql = "INSERT INTO  decks(deck_title, deck_description) VALUES (?, ?) RETURNING deck_id;";
        Integer deckId = jdbcTemplate.queryForObject(sql, Integer.class, deckTitle, deckDescription);
        String sqlTwo = "INSERT INTO users_decks(user_id, deck_id) VALUES (?, ?);";
        jdbcTemplate.update(sqlTwo, userId, deckId);
        Deck deck = new Deck();
        deck.setDeckDescription(deckDescription);
        deck.setDeckTitle(deckTitle);
        deck.setDeckId(deckId);
        return deck;
    }

    @Override
    public void modifyDeck(int deckId, DeckRequest deckRequest) {
        String sql = "UPDATE decks SET deck_title=?, deck_description=? WHERE deck_id=?;";
        jdbcTemplate.update(sql, deckRequest.getDeckTitle(), deckRequest.getDeckDescription(), deckId);
    }

    @Override
    public Deck getDeckInfoById(int deckId, String deckTitle, String deckDescription) {
        Deck deck = new Deck();
        String sql = "SELECT deck_id, deck_title, deck_description FROM decks WHERE deck_id = ?;";

        SqlRowSet rows = jdbcTemplate.queryForRowSet(sql, deckId);

        while(rows.next()) {
            deck.setDeckId(deckId);
            deck.setDeckTitle(rows.getString("deck_title"));
            deck.setDeckDescription(rows.getString("deck_description"));
        }
        return deck;
    }

    @Override
    public void deleteCardFromDeck(int deckId, int cardId) {
        String sql = "DELETE FROM decks_cards WHERE decks_cards.deck_id = ? AND decks_cards.card_id = ?;";
        jdbcTemplate.update(sql, deckId, cardId);
    }

    @Override
    public List<Card> searchByKeyword(String keyword) {
        List<Card> listOfMatches = new ArrayList<Card>();
        String newKeyword = "%" + keyword + "%";
        String sql= "SELECT card_id, user_id, card_front, card_back, keywords FROM cards WHERE keywords ILIKE ?;";

        SqlRowSet rows = jdbcTemplate.queryForRowSet(sql, newKeyword);

        while(rows.next()) {
            Card card = new Card();
            card.setCardId(rows.getInt("card_id"));
            card.setUserId(rows.getInt("user_id"));
            card.setCardFront(rows.getString("card_front"));
            card.setCardBack(rows.getString("card_back"));
            card.setKeywords(rows.getString("keywords"));
            listOfMatches.add(card);
        }
        return listOfMatches;
    }


    private int getIdFromUsername(String username) throws NullPointerException {
        int id;
        String sql = "SELECT user_id FROM users WHERE username = ?;";
        Integer userId = jdbcTemplate.queryForObject(sql, Integer.class, username);

        if (userId != null) {
            id = userId;
            return id;
        }
        throw new NullPointerException("Id Not Found");
    }

}
