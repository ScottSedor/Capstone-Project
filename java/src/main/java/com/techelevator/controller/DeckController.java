package com.techelevator.controller;

import com.techelevator.dao.CardDao;
import com.techelevator.dao.DeckDao;
import com.techelevator.model.Card;
import com.techelevator.model.CardRequest;
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
    @RequestMapping(path= "/decks", method= RequestMethod.POST)
    public Deck createDeck(Principal principal, @RequestBody DeckRequest deckRequest) {
        return deckDao.createDeck(principal.getName(), deckRequest.getDeckTitle());
    }

    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path= "/decks/{id}", method= RequestMethod.POST)
    public Card createCard(Principal principal, @RequestBody CardRequest cardRequest, @PathVariable("id")int deckId) {
        return cardDao.addCard(cardRequest, principal.getName(), deckId);
    }

    @RequestMapping(path="/decks/{id}/card/{cardId}", method= RequestMethod.PUT)
    public void update(@PathVariable("id")int deckId, @PathVariable("cardId")int cardId, @RequestBody Card card) {
        cardDao.modifyCard(cardId, card);
    }
}
