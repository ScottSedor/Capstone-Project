package com.techelevator.controller;

import com.techelevator.dao.CardDao;
import com.techelevator.dao.DeckDao;
import com.techelevator.model.Card;
import com.techelevator.model.Deck;
import com.techelevator.model.DeckRequest;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@CrossOrigin
@RestController
//pre-auth
public class DeckController {

    private DeckDao deckDao;
    private CardDao cardDao;

    public DeckController(DeckDao deckDao, CardDao cardDao) {

        this.deckDao = deckDao;
        this.cardDao = cardDao;
    }

    @RequestMapping (path="/decks", method= RequestMethod.GET)
    public List<Deck> getAllDecks() {
        return deckDao.viewAllDecks();
    }

    @RequestMapping (path="/decks/{id}", method= RequestMethod.GET)
    public List<Card> getCardsInDeck(@PathVariable("id") int deckId) { return cardDao.viewCardsInDeck(deckId); }


    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path= "/decks/create", method= RequestMethod.POST)
    public void createDeck(Principal principal, @RequestBody DeckRequest deckRequest) {
        deckDao.createDeck(principal.getName(), deckRequest.getDeckTitle());
    }
}
