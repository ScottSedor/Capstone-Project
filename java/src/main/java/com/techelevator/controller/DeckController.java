package com.techelevator.controller;

import com.techelevator.dao.CardDao;
import com.techelevator.dao.DeckDao;
import com.techelevator.model.Card;
import com.techelevator.model.CardRequest;
import com.techelevator.model.Deck;
import com.techelevator.model.DeckRequest;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.io.PrintWriter;
import java.security.Principal;
import java.util.List;

@CrossOrigin
@RestController
@PreAuthorize("isAuthenticated()")
public class DeckController {

    private DeckDao deckDao;
    private CardDao cardDao;

    public DeckController(DeckDao deckDao, CardDao cardDao) {

        this.deckDao = deckDao;
        this.cardDao = cardDao;
    }

    @RequestMapping (path="/decks", method= RequestMethod.GET)
    public List<Deck> getAllDecks(Principal principal) {
        return deckDao.viewAllDecks(principal.getName());
    }

    @RequestMapping (path="/decks/{id}", method= RequestMethod.GET)
    public List<Card> getCardsInDeck(@PathVariable("id") int deckId) { return cardDao.viewCardsInDeck(deckId); }

    @RequestMapping(path="/decks/{id}/search", method=RequestMethod.GET)
    public List<Card> searchByKeyword(@RequestParam(required = false, name = "keyword") String keyword,
                                      @PathVariable("id") int deckId) {
        return deckDao.searchByKeyword(keyword, deckId);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path= "/decks", method= RequestMethod.POST)
    public Deck createDeck(Principal principal, @RequestBody DeckRequest deckRequest) {
        return deckDao.createDeck(principal.getName(), deckRequest.getDeckTitle(), deckRequest.getDeckDescription());
    }

    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path= "/decks/{id}", method= RequestMethod.POST)
    public Card createCard(Principal principal, @RequestBody CardRequest cardRequest, @PathVariable("id")int deckId) {
        return cardDao.addCard(cardRequest, principal.getName(), deckId);
    }

    @RequestMapping(path="/decks/{id}/card/{cardId}", method= RequestMethod.PUT)
    public void update(@PathVariable("id")int deckId, @PathVariable("cardId")int cardId, @RequestBody CardRequest cardRequest) {
        cardDao.modifyCard(cardId, cardRequest);
    }

    @RequestMapping(path="/decks/{id}/info", method = RequestMethod.PUT)
    public void updateDeck(@PathVariable("id")int deckId, @RequestBody DeckRequest deckRequest) {
        deckDao.modifyDeck(deckId, deckRequest);
    }

    @RequestMapping(path="/decks/{id}/info", method = RequestMethod.GET)
    public Deck getDeckInfoById(@PathVariable("id")int deckId) {
        return deckDao.getDeckInfoById(deckId);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @RequestMapping(path="/decks/{id}/card/{cardId}", method=RequestMethod.DELETE)
    public void deleteCardFromDeck(@PathVariable("id")int deckId, @PathVariable("cardId")int cardId) {
        deckDao.deleteCardFromDeck(deckId, cardId);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path="/decks/{id}/search/{cardId}", method=RequestMethod.POST)
    public void addSearchedCardToDeck(@PathVariable("id") int deckId, @PathVariable("cardId") int cardId) {
        deckDao.addSearchResultToDeck(deckId, cardId);
    }
}
