package com.techelevator.dao;

import com.techelevator.model.Deck;

import java.util.ArrayList;
import java.util.List;
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
    public void createDeck(String username, String deckTitle) {
        int userId = getIdFromUsername(username);
        String sql = "INSERT INTO  decks(deck_title) VALUES (?);";
        int deckId = jdbcTemplate.update(sql, deckTitle);
        String sqlTwo = "INSERT INTO users_decks(user_id, deck_id) VALUES (?, ?);";
        jdbcTemplate.update(sqlTwo, userId, deckId);
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
