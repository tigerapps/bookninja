USE bookninja;

SET foreign_key_checks = 0;

DROP TABLE IF EXISTS
	authors, books, courses, listings, messages, pictures, semesters,
	schools, users, author_book, book_course, listing_picture;

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

CREATE TABLE courses (
	id			INTEGER NOT NULL AUTO_INCREMENT,
	course_number		VARCHAR(12) NOT NULL,
	name			VARCHAR(80) NOT NULL,
	school			INTEGER NOT NULL,
	FOREIGN KEY (school)	REFERENCES schools (id),
	PRIMARY KEY (id)
);

CREATE TABLE messages (
	id			INTEGER NOT NULL AUTO_INCREMENT,
	created			TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	listing			INTEGER NOT NULL,
	message			TEXT NOT NULL,
	previous		INTEGER,
	receiver		INTEGER NOT NULL,
	sender			INTEGER NOT NULL,
	FOREIGN KEY (listing)	REFERENCES listings (id) ON DELETE CASCADE,
	FOREIGN KEY (previous)	REFERENCES messages (id) ON DELETE CASCADE,
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

CREATE TABLE listings (
	id			INTEGER NOT NULL AUTO_INCREMENT,
	book			INTEGER NOT NULL,
	book_condition		ENUM('new', 'likenew', 'good', 'fair', 'poor') NOT NULL,
	created			TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	description		TEXT,
	modified		TIMESTAMP,
	price			INTEGER NOT NULL,
	seller			INTEGER NOT NULL,
	status			ENUM('hidden', 'posted', 'sold') NOT NULL,
	title			VARCHAR(80) NOT NULL,
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
	created			TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	email			VARCHAR(254) NOT NULL,
	name			VARCHAR(80),
	password		BINARY(60) NOT NULL,
	school			INTEGER,
	username		VARCHAR(40) NOT NULL UNIQUE,
	zipcode			MEDIUMINT,
	FOREIGN KEY (school)	REFERENCES schools (id) ON DELETE SET NULL,
	PRIMARY KEY (id)
);

CREATE TABLE author_book (
	author			INTEGER NOT NULL,
	book			INTEGER NOT NULL,
	FOREIGN KEY (author)	REFERENCES authors (id),
	FOREIGN KEY (book)	REFERENCES books (id),
	PRIMARY KEY (author, book)
);

CREATE TABLE book_course (
	book			INTEGER NOT NULL,
	course			INTEGER NOT NULL,
	semester		INTEGER NOT NULL,
	FOREIGN KEY (book)	REFERENCES books (id),
	FOREIGN KEY (course)	REFERENCES courses (id),
	FOREIGN KEY (semester)	REFERENCES semesters (id),
	PRIMARY KEY (book, course, semester)
);

CREATE TABLE listing_picture (
	picture			INTEGER NOT NULL,
	listing			INTEGER NOT NULL,
	FOREIGN KEY (listing)	REFERENCES listings (id),
	FOREIGN KEY (picture)	REFERENCES pictures (id) ON DELETE CASCADE,
	PRIMARY KEY (picture, listing)
);

SET foreign_key_checks = 1;
