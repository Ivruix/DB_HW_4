-- Какие фамилии читателей в Москве?
SELECT "LastName"
FROM "Reader"
WHERE "Address" LIKE '%Moscow%';

-- Какие книги (author, title) брал Иван Иванов?
SELECT DISTINCT B."Author", B."Title"
FROM "Borrowing" AS BR
JOIN "Book" AS B ON BR."ISBN" = B."ISBN"
JOIN "Reader" AS R ON BR."ReaderID" = R."ID"
WHERE R."FirstName" = 'Иван' AND R."LastName" = 'Иванов';

-- Какие книги (ISBN) из категории "Горы" не относятся к категории "Путешествия"? Подкатегории не обязательно принимать во внимание!
SELECT BC."ISBN"
FROM "BookCat" AS BC
WHERE BC."CategoryName" = 'Mountains'
AND BC."ISBN" NOT IN (
    SELECT BC2."ISBN"
    FROM "BookCat" AS BC2
    WHERE BC2."CategoryName" = 'Travel'
);

-- Какие читатели (LastName, FirstName) вернули копию книги?
SELECT DISTINCT R."LastName", R."FirstName"
FROM "Borrowing" AS B
JOIN "Reader" AS R ON B."ReaderID" = R."ID"
WHERE CURRENT_DATE >= B."ReturnDate";

-- Какие читатели (LastName, FirstName) брали хотя бы одну книгу (не копию), которую брал также Иван Иванов (не включайте Ивана Иванова в результат)?
SELECT DISTINCT R."LastName", R."FirstName"
FROM "Reader" AS R
JOIN "Borrowing" AS B ON R."ID" = B."ReaderID"
WHERE B."ISBN" IN (
    SELECT "ISBN"
    FROM "Borrowing"
    WHERE "ReaderID" = (
        SELECT "ID"
        FROM "Reader"
        WHERE "FirstName" = 'Иван' AND "LastName" = 'Иванов'
    )
) AND NOT (R."FirstName" = 'Иван' AND R."LastName" = 'Иванов');
