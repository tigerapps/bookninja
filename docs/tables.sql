USE bookninja;

SET foreign_key_checks = 0;

DROP TABLE IF EXISTS authors, books, classes, messages, pictures, postings, semesters, schools, users, author_book, book_class;

CREATE TABLE authors (
	id			INTEGER AUTO_INCREMENT,
	name			VARCHAR(80) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE books (
	id			INTEGER AUTO_INCREMENT,
	covertype		ENUM('hard', 'loose', 'soft') NOT NULL,
	edition			VARCHAR(16),
	isbn			BIGINT NOT NULL,
	title			VARCHAR(255) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE classes (
	id			INTEGER AUTO_INCREMENT,
	school			INTEGER NOT NULL,
	FOREIGN KEY (school)	REFERENCES schools (id),
	PRIMARY KEY (id)
);

CREATE TABLE messages (
	id			INTEGER AUTO_INCREMENT,
	created			TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	message			TEXT NOT NULL,
	posting			INTEGER NOT NULL,
	receiver		INTEGER NOT NULL,
	sender			INTEGER NOT NULL,
	FOREIGN KEY (posting)	REFERENCES postings (id),
	FOREIGN KEY (receiver)	REFERENCES users (id),
	FOREIGN KEY (sender)	REFERENCES users (id),
	PRIMARY KEY (id)
);

CREATE TABLE pictures (
	id			INTEGER AUTO_INCREMENT,
	hash			BINARY(32) NOT NULL,
	posting			INTEGER NOT NULL,
	type			CHAR(4) NOT NULL,
	FOREIGN KEY (posting)	REFERENCES postings (id),
	PRIMARY KEY (id)
);

CREATE TABLE postings (
	id			INTEGER AUTO_INCREMENT,
	book			INTEGER NOT NULL,
	book_condition		ENUM('new', 'likenew', 'good', 'fair', 'poor') NOT NULL,
	created			TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	description		TEXT,
	price			INTEGER NOT NULL,
	seller			INTEGER NOT NULL,
	status			ENUM('hidden', 'posted', 'sold') NOT NULL,
	zipcode			MEDIUMINT NOT NULL,
	FOREIGN KEY (book)	REFERENCES books (id),
	FOREIGN KEY (seller)	REFERENCES users (id),
	PRIMARY KEY (id)
);

CREATE TABLE semesters (
	id			INTEGER AUTO_INCREMENT,
	term			ENUM('winter', 'spring', 'summer', 'fall') NOT NULL,
	year			YEAR NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE schools (
	id			INTEGER AUTO_INCREMENT,
	name			VARCHAR(100) NOT NULL,
	zipcode			MEDIUMINT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE users (
	id			INTEGER AUTO_INCREMENT,
	email			VARCHAR(254) NOT NULL,
	name			VARCHAR(80),
	password		BINARY(60) NOT NULL,
	username		VARCHAR(40) NOT NULL,
	zipcode			MEDIUMINT,
	PRIMARY KEY (id)
);

CREATE TABLE author_book (
	author			INTEGER NOT NULL,
	book			INTEGER NOT NULL,
	FOREIGN KEY (author)	REFERENCES authors (id),
	FOREIGN KEY (book)	REFERENCES books (id),
	PRIMARY KEY (author, book)
);

CREATE TABLE book_class (
	book			INTEGER NOT NULL,
	class			INTEGER NOT NULL,
	semester		INTEGER NOT NULL,
	FOREIGN KEY (book)	REFERENCES books (id),
	FOREIGN KEY (class)	REFERENCES classes (id),
	FOREIGN KEY (semester)	REFERENCES semesters (id),
	PRIMARY KEY (book, class, semester)
);

SET foreign_key_checks = 1;
