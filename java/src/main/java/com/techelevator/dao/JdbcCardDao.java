package com.techelevator.dao;

import com.techelevator.model.Card;
import com.techelevator.model.CardRequest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcCardDao implements CardDao {

    private JdbcTemplate jdbcTemplate;

    public JdbcCardDao (JdbcTemplate jdbcTemplate) {this.jdbcTemplate = jdbcTemplate;}

    @Override
    public List<Card> viewCardsInDeck(int deckId) {

        List<Card> cards = new ArrayList<Card>();
        String sql = "SELECT cards.card_id, user_id, card_front, card_back, keywords " +
        "FROM cards JOIN decks_cards ON cards.card_id = decks_cards.card_id " +
        "WHERE deck_id = ?;";

        SqlRowSet rows = jdbcTemplate.queryForRowSet(sql, deckId);

        while(rows.next()) {
            Card card = new Card();
            card.setCardId(rows.getInt("card_id"));
            card.setUserId(rows.getInt("user_id"));
            card.setCardBack(rows.getString("card_back"));
            card.setCardFront(rows.getString("card_front"));
            card.setKeywords(rows.getString("keywords"));
            cards.add(card);
        }
        return cards;
    }

    // Possibly add return card object...
    @Override
    public void addCard(CardRequest cardRequest, String username) {
        int userId = getIdFromUsername(username);
        String sql = "INSERT INTO cards (user_id, card_front, card_back, keywords) VALUES (?, ?, ?, ?);";
        jdbcTemplate.update(sql, userId, cardRequest.getCardFront(), cardRequest.getCardBack(), cardRequest.getKeywords());
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
