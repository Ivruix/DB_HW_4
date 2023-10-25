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
	"ParentCategory" VARCHAR(255) NOT NULL,
	CONSTRAINT "Category_pk" PRIMARY KEY ("CategoryName")
);


ALTER TABLE "Book" ADD CONSTRAINT "Book_fk0" FOREIGN KEY ("PubName") REFERENCES "Publisher"("PubName");

ALTER TABLE "Copy" ADD CONSTRAINT "Copy_fk0" FOREIGN KEY ("ISBN") REFERENCES "Book"("ISBN");

ALTER TABLE "Borrowing" ADD CONSTRAINT "Borrowing_fk0" FOREIGN KEY ("ReaderID") REFERENCES "Reader"("ID");
ALTER TABLE "Borrowing" ADD CONSTRAINT "Borrowing_fk1" FOREIGN KEY ("ISBN", "CopyNumber") REFERENCES "Copy"("ISBN", "CopyNumber");

ALTER TABLE "BookCat" ADD CONSTRAINT "BookCat_fk0" FOREIGN KEY ("ISBN") REFERENCES "Book"("ISBN");
ALTER TABLE "BookCat" ADD CONSTRAINT "BookCat_fk1" FOREIGN KEY ("CategoryName") REFERENCES "Category"("CategoryName");

ALTER TABLE "Category" ADD CONSTRAINT "Category_fk0" FOREIGN KEY ("ParentCategory") REFERENCES "Category"("CategoryName");