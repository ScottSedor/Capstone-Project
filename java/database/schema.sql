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
deck_description varchar(1000),
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

INSERT INTO cards (user_id, card_front, card_back, keywords)
VALUES (1, 'authorization', 'The process of giving a user permission to access a specific resource or function.', 'authorization'),
		(1, 'authentication', 'The process or action of verifying the identity of a user or process.', 'authentication'),
		(1, 'Boolean expression', 'Code which when evaluated provides a Boolean value (true or false).', 'Boolean'),
		(1, 'concatenation', 'The operation of joining two strings together.', 'concatenation'),
		(1, 'deserialization', 'The process of reconstructing the object from the serialized state.', 'deserialization'),
		(1, 'encapsulation', 'The idea of bundling data and methods that work on data within one unit.', 'encapsulation'),
		(1, 'heap', 'The area of memory used to store objects instatiated by applications running on the JVM.', 'heap'),
		(1, 'inheritance', 'A mechanism in which one object aquires all of the properties of a parent object.', 'inheritance'),
		(1, 'parse', 'Converting a value of one data type to an unlike data type', 'parse'),
		(1, 'reference data type', 'A data type that holds a reference to the location of a value rather than the value itself.', 'reference data type'),
		(1, 'serialization', 'The conversion of the state of an object into a byte stream.', 'serialization');

INSERT INTO decks_cards (deck_id, card_id)
VALUES (1, 14), (1, 15), (1, 16), (1, 17), (1, 18), (1, 19), (1, 20), (1, 21), (1, 22), (1, 23), (1, 24);

COMMIT TRANSACTION;

