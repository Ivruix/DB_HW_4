CREATE DATABASE librarydb;

\c librarydb;

CREATE TABLE "Book" (
	"ISBN" VARCHAR(255) NOT NULL,
	"Title" VARCHAR(255) NOT NULL,
	"Author" VARCHAR(255) NOT NULL,
	"PagesNum" integer NOT NULL,
	"PubName" VARCHAR(255) NOT NULL,
	"PubYear" integer NOT NULL,
	CONSTRAINT "Book_pk" PRIMARY KEY ("ISBN")
);



CREATE TABLE "Publisher" (
	"PubName" VARCHAR(255) NOT NULL,
	"Address" VARCHAR(255) NOT NULL,
	CONSTRAINT "Publisher_pk" PRIMARY KEY ("PubName")
);



CREATE TABLE "Copy" (
	"ISBN" VARCHAR(255) NOT NULL,
	"CopyNumber" integer NOT NULL,
	"Shelf" integer NOT NULL,
	"Position" integer NOT NULL,
	CONSTRAINT "Copy_pk" PRIMARY KEY ("ISBN","CopyNumber")
);



CREATE TABLE "Borrowing" (
	"ReaderID" integer NOT NULL,
	"ISBN" VARCHAR(255) NOT NULL,
	"CopyNumber" integer NOT NULL,
	"ReturnDate" DATE NOT NULL,
	CONSTRAINT "Borrowing_pk" PRIMARY KEY ("ReaderID","ISBN","CopyNumber")
);



CREATE TABLE "Reader" (
	"ID" serial NOT NULL,
	"FirstName" VARCHAR(255) NOT NULL,
	"LastName" VARCHAR(255) NOT NULL,
	"Address" VARCHAR(255) NOT NULL,
	"BirthDate" DATE NOT NULL,
	CONSTRAINT "Reader_pk" PRIMARY KEY ("ID")
);



CREATE TABLE "BookCat" (
	"ISBN" VARCHAR(255) NOT NULL,
	"CategoryName" VARCHAR(255) NOT NULL,
	CONSTRAINT "BookCat_pk" PRIMARY KEY ("ISBN","CategoryName")
);


CREATE TABLE "Category" (
	"CategoryName" VARCHAR(255) NOT NULL,
	"ParentCategory" VARCHAR(255),
	CONSTRAINT "Category_pk" PRIMARY KEY ("CategoryName")
);


ALTER TABLE "Book" ADD CONSTRAINT "Book_fk0" FOREIGN KEY ("PubName") REFERENCES "Publisher"("PubName");

ALTER TABLE "Copy" ADD CONSTRAINT "Copy_fk0" FOREIGN KEY ("ISBN") REFERENCES "Book"("ISBN");

ALTER TABLE "Borrowing" ADD CONSTRAINT "Borrowing_fk0" FOREIGN KEY ("ReaderID") REFERENCES "Reader"("ID");
ALTER TABLE "Borrowing" ADD CONSTRAINT "Borrowing_fk1" FOREIGN KEY ("ISBN", "CopyNumber") REFERENCES "Copy"("ISBN", "CopyNumber");

ALTER TABLE "BookCat" ADD CONSTRAINT "BookCat_fk0" FOREIGN KEY ("ISBN") REFERENCES "Book"("ISBN");
ALTER TABLE "BookCat" ADD CONSTRAINT "BookCat_fk1" FOREIGN KEY ("CategoryName") REFERENCES "Category"("CategoryName");

ALTER TABLE "Category" ADD CONSTRAINT "Category_fk0" FOREIGN KEY ("ParentCategory") REFERENCES "Category"("CategoryName");

INSERT INTO "Publisher" ("PubName", "Address") VALUES
    ('123 Book Group', '12 Arbat St, Moscow, Russia'),
    ('Best Books', '17 Tverskaya St, Moscow, Russia'),
    ('ABC Publishing', '4 Nikolskaya St, Moscow, Russia');

INSERT INTO "Book" ("ISBN", "Title", "Author", "PagesNum", "PubName", "PubYear") VALUES
    ('ISBN001', 'Secrets of the Labyrinth', 'John Doe', 200, '123 Book Group', 2020),
    ('ISBN002', 'The Great Flying Mountain', 'Alice Johnson', 250, 'Best Books', 2019),
    ('ISBN003', 'Climbing Huge Mountains', 'Eva Brown', 180, 'ABC Publishing', 2021);

INSERT INTO "Copy" ("ISBN", "CopyNumber", "Shelf", "Position") VALUES
    ('ISBN001', 1, 1, 1),
    ('ISBN001', 2, 1, 2),
    ('ISBN002', 1, 2, 1),
    ('ISBN003', 1, 3, 1);

INSERT INTO "Reader" ("FirstName", "LastName", "Address", "BirthDate") VALUES
    ('Иван', 'Иванов', '7 Prostornaya St, Moscow, Russia', '1990-05-15'),
    ('Денис', 'Краснов', '34 Arbat St, Moscow, Russia', '1985-08-20'),
    ('Bob', 'Johnson', '789 Oak St, London, UK', '2000-02-10');

INSERT INTO "Category" ("CategoryName", "ParentCategory") VALUES
    ('Fiction', NULL),
    ('Fantasy', 'Fiction'),
    ('Mystery', 'Fiction'),
    ('Science Fiction', 'Fiction'),
    ('Non-Fiction', NULL),
    ('Travel', 'Non-Fiction'),
    ('Mountains', 'Non-Fiction');

INSERT INTO "BookCat" ("ISBN", "CategoryName") VALUES
    ('ISBN001', 'Fantasy'),
    ('ISBN001', 'Mystery'),
    ('ISBN002', 'Mountains'),
    ('ISBN002', 'Science Fiction'),
    ('ISBN003', 'Mountains'),
    ('ISBN003', 'Travel');

INSERT INTO "Borrowing" ("ReaderID", "ISBN", "CopyNumber", "ReturnDate")
VALUES
    (1, 'ISBN001', 2, '2023-09-14'),
    (2, 'ISBN003', 1, '2023-10-07'),
    (1, 'ISBN002', 1, '2024-03-12'),
    (3, 'ISBN001', 1, '2024-05-22');
