BEGIN TRANSACTION;

DROP TABLE IF EXISTS users_decks, decks_cards, cards, users, decks;
DROP SEQUENCE IF EXISTS seq_user_id;

CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');

CREATE TABLE decks(
deck_id serial NOT NULL,
deck_title varchar(50) NOT NULL,
CONSTRAINT PK_decks PRIMARY KEY (deck_id)	
);

CREATE TABLE cards(
	card_id serial PRIMARY KEY,
	user_id bigint NOT NULL,
	card_front varchar(256) NOT NULL,
	card_back varchar(2000) NOT NULL,
	keywords varchar(256) NOT NULL,

	CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE decks_cards(

    deck_id bigint NOT NULL,
	card_id bigint NOT NULL,

	CONSTRAINT FK_deck_id FOREIGN KEY (deck_id) REFERENCES decks(deck_id),
	CONSTRAINT FK_card_id FOREIGN KEY (card_id) REFERENCES cards(card_id),
	CONSTRAINT PK_decks_cards PRIMARY KEY (deck_id, card_id)
);

CREATE TABLE users_decks(
user_id bigint NOT NULL,
deck_id bigint NOT NULL,
CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES users(user_id),
CONSTRAINT FK_deck_id FOREIGN KEY (deck_id) REFERENCES decks(deck_id),
CONSTRAINT PK_users_decks PRIMARY KEY (user_id, deck_id)
);

INSERT INTO decks (deck_title) VALUES ('Deck One');
INSERT INTO decks (deck_title) VALUES ('Deck Two');
INSERT INTO decks (deck_title) VALUES ('Deck Three');

INSERT INTO cards (user_id, card_front, card_back, keywords) 
VALUES (1, 'Front Card One', 'Back Card One', 'Test'),
	   (1, 'Front Card Two', 'Back Card Two', 'Test'),
	   (1, 'Front Card Three', 'Back Card Three', 'Test'),
	   (1, 'Front Card Four', 'Back Card Four', 'Test'),
	   (1, 'Front Card Five', 'Back Card Five', 'Test'),
	   (1, 'Front Card Six', 'Back Card Six', 'Test');
	   
INSERT INTO decks_cards (deck_id, card_id) 
VALUES (1, 1), (1, 2), (2, 3), (2, 4), (3, 5), (3, 6);  

INSERT INTO users_decks (deck_id, user_id) VALUES (1,1), (2,1), (3,1);

COMMIT TRANSACTION;

