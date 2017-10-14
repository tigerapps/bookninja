USE bookninja;

SET foreign_key_checks = 0;

DROP TABLE IF EXISTS
	authors, books, classes, messages, pictures, postings, semesters,
	schools, users, author_book, book_class, picture_posting;

CREATE TABLE authors (
	id			INTEGER NOT NULL AUTO_INCREMENT,
	name			VARCHAR(80) NOT NULL UNIQUE,
	PRIMARY KEY (id)
);

CREATE TABLE books (
	id			INTEGER NOT NULL AUTO_INCREMENT,
	covertype		ENUM('hard', 'loose', 'soft') NOT NULL,
	edition			VARCHAR(16),
	isbn			BIGINT NOT NULL UNIQUE,
	title			VARCHAR(255) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE classes (
	id			INTEGER NOT NULL AUTO_INCREMENT,
	school			INTEGER NOT NULL,
	FOREIGN KEY (school)	REFERENCES schools (id),
	PRIMARY KEY (id)
);

CREATE TABLE messages (
	id			INTEGER NOT NULL AUTO_INCREMENT,
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
	id			INTEGER NOT NULL AUTO_INCREMENT,
	format			ENUM('jpeg', 'png', 'webp') NOT NULL,
	hash			BINARY(32) NOT NULL UNIQUE,
	PRIMARY KEY (id)
);

CREATE TABLE postings (
	id			INTEGER NOT NULL AUTO_INCREMENT,
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
	id			INTEGER NOT NULL AUTO_INCREMENT,
	term			ENUM('winter', 'spring', 'summer', 'fall') NOT NULL,
	year			YEAR NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (term, year)
);

CREATE TABLE schools (
	id			INTEGER NOT NULL AUTO_INCREMENT,
	name			VARCHAR(100) NOT NULL UNIQUE,
	zipcode			MEDIUMINT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE users (
	id			INTEGER NOT NULL AUTO_INCREMENT,
	email			VARCHAR(254) NOT NULL,
	name			VARCHAR(80),
	password		BINARY(60) NOT NULL,
	username		VARCHAR(40) NOT NULL UNIQUE,
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

CREATE TABLE picture_posting (
	picture			INTEGER NOT NULL,
	posting			INTEGER NOT NULL,
	FOREIGN KEY (picture)	REFERENCES pictures (id),
	FOREIGN KEY (posting)	REFERENCES postings (id),
	PRIMARY KEY (picture, posting)
);

SET foreign_key_checks = 1;
