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

INSERT INTO decks (deck_title) VALUES ('Java terminology');
INSERT INTO decks (deck_title) VALUES ('Java technical interview questions');
INSERT INTO decks (deck_title) VALUES ('Deck Three');

INSERT INTO cards (user_id, card_front, card_back, keywords) 
VALUES (1, 'class', 'A blueprint or template for objects that defines variables and methods.', 'class'),
	   (1, 'object', 'An instance of class, contains state and behavior.', 'object'),
	   (1, 'method', 'Contains the executable body that can can be applied to the specific object of the class.', 'method'),
	   (1, 'null', 'When a reference variable does not point to any value it is assigned null.', 'null'),
	   (1, 'package', 'A mechanism to group related classes, interfaces and enums into a single module.', 'package'),
	   (1, 'bytecode', 'Is a machine independent language and contains a set of instructinos which are to be executed only by JVM.', 'bytecode');
	   
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
		(1, 'heap', 'The area of memory used to store objects instantiated by applications running on the JVM.', 'heap'),
		(1, 'inheritance', 'A mechanism in which one object acquires all of the properties of a parent object.', 'inheritance'),
		(1, 'parse', 'Converting a value of one data type to an unlike data type', 'parse'),
		(1, 'reference data type', 'A data type that holds a reference to the location of a value rather than the value itself.', 'reference data type'),
		(1, 'serialization', 'The conversion of the state of an object into a byte stream.', 'serialization'),
		(1, 'access modifiers', 'Public, private, protected and default determines access control of a class, method or variable.', 'access modifiers'),
		(2, 'constructor vs method', 'A constructor is used to initialize an object. A method is used to exhibit functionality of an object.', 'constructor, method'),
		(2, 'HTTP GET vs HTTP POST', 'GET is less secure than POST because data sent is part of the URL', 'HTTP GET, HTTP POST'),
		(2, 'Rules of REST', 'Uniform interface, client-server separation, stateless, cacheable, layered system and code on demand.', 'REST'),
		(2, 'Priciples of Object Oriented Programming(OOP)', 'Encapsulation, inheritance and polymorphism.', 'Priciples of OOP'),
		(2, 'primary key vs foreign key', 'A primary key is used to assure the value in the particular column is unique. The foreign key provides the link between tables.', 'primary key, foreign key'),
		(2, 'method overloading vs method overriding', 'Overloading is performed within class, parameters must be different, compile time polymorphism and return type can be same or different. Overriding occurs in two classes, parameters must be same, run time polymorphism and return type must be same or covariant.', 'overloading, overriding'),
		(2, 'What problem does the MVC pattern solve?', 'The MVC keeps the user interface separate from the rest of the program.', 'MVC pattern'),
		(2, 'stack vs heap', 'The stack is a limited linear area of memory that holds primitive data types. The heap is a free floating area of memory that holds objects.', 'stack, heap'),
  		(2, 'What happens when a web browser requests a web page?', 'The browser looks up an IP address of the requested domain name using a DNS server.  The browser sends an HTTP GET request to the IP address.  The web server retrieves the resource requested and returns it as an HTTP response with the status code 200 if found. The web browser parses the HTTP response as HTML and renders the page on the screen.', 'web browser request'),
		(2, 'stack vs queue', 'In the stack elements are added/retrieved last-in-first-out(LIFO), in the queue elements are added/retrieved first-in-first-out (FIFO).', 'stack, queue'),
		(2, 'length vs length()', 'The length() method is used to return the number of characters in a string.  The length instance variable in arrays which will return the number of values or objects in the array.', 'length'),
		(2, 'State some situations where exceptions may arise?', 'Accessing an element that does not exist in array, invalid conversion of a number to a string, invalid casting of a class, trying to create an object for an interface or abstract class.', 'exceptions'),
		(2, 'How do we handle exceptions?', 'By specifying try catch block where we can catch the exception or declaring a method with a throws clause.', 'exception handling'),
		(2, 'List the benefits of object oriented programming.', 'Easy maintenance, code reusability, code extendability and reliable.', 'object oriented programming, OOP'); 


INSERT INTO decks_cards (deck_id, card_id)
VALUES (1, 7), (1, 8), (1, 9), (1, 10), (1, 11), (1, 12), (1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18), (2, 19), (2, 20), (2, 21), (2, 22), (2, 23), (2, 24), (2, 25), (2, 26), (2, 27), (2, 28), (2, 29), (2, 30), (2, 31), (2, 32);

COMMIT TRANSACTION;

