package com.techelevator.dao;

import com.techelevator.model.Card;
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
    public List<Card> viewCardsInDeck(int deckID) {

        List<Card> cards = new ArrayList<Card>();
        String sql = "SELECT cards.card_id, user_id, card_front, card_back, keywords " +
        "FROM cards JOIN decks_cards ON cards.card_id = decks_cards.card_id " +
        "WHERE deck_id = ?;";

        SqlRowSet rows = jdbcTemplate.queryForRowSet(sql, deckID);

        while(rows.next()) {
            Card card = new Card();
            card.setCardID(rows.getInt("card_id"));
            card.setUserID(rows.getInt("user_id"));
            card.setCardBack(rows.getString("card_back"));
            card.setCardFront(rows.getString("card_front"));
            card.setKeywords(rows.getString("keywords"));
            cards.add(card);
        }
        return cards;
    }

}
