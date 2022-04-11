package com.techelevator.controller;

import com.techelevator.dao.CardDao;
import com.techelevator.model.Card;
import com.techelevator.model.CardRequest;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@CrossOrigin
@RestController

public class CardController {

    private CardDao cardDao;

    public CardController(CardDao cardDao) { this.cardDao = cardDao; }

    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path= "/cards/create", method= RequestMethod.POST)
    public void createCard(Principal principal, @RequestBody CardRequest cardRequest) {
        cardDao.addCard(cardRequest, principal.getName());
    }

}
