BEGIN TRANSACTION;

DROP TABLE IF EXISTS users_decks, users, decks;
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

INSERT INTO users_decks (deck_id, user_id) VALUES (1,1), (2,1), (3,1);

COMMIT TRANSACTION;
