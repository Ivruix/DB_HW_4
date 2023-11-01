-- Найдите все прямые рейсы из Москвы в Тверь.
SELECT DISTINCT "TrainNr"
FROM "Train" AS T
JOIN "Station" AS S1 ON T."StartStationName" = S1."Name"
JOIN "Station" AS S2 ON T."EndStationName" = S2."Name"
WHERE S1."CityName" = 'Москва' AND S2."CityName" = 'Тверь'
AND NOT EXISTS (
    SELECT 1
    FROM "Connection" as C
    WHERE (C."FromStation" != T."StartStationName" OR C."ToStation" != T."EndStationName")
    AND C."TrainNr" = T."TrainNr"
);

-- Найдите все многосегментные маршруты, имеющие точно однодневный трансфер из Москвы в Санкт-Петербург (первое отправление и прибытие в конечную точку должны быть в одну и ту же дату). Вы можете применить функцию DAY () к атрибутам Departure и Arrival, чтобы определить дату.
SELECT DISTINCT T."TrainNr"
FROM "Train" AS T
JOIN "Station" AS S1 ON T."StartStationName" = S1."Name"
JOIN "Station" AS S2 ON T."EndStationName" = S2."Name"
JOIN "Connection" as C1 ON T."TrainNr" = C1."TrainNr"
WHERE S1."CityName" = 'Москва' AND S2."CityName" = 'Санкт-Петербург'
AND C1."FromStation" = T."StartStationName" AND C1."ToStation" = T."EndStationName"
AND EXISTS (
    SELECT 1
    FROM "Connection" as C2
    WHERE (C2."FromStation" != T."StartStationName" OR C2."ToStation" != T."EndStationName")
        AND C2."TrainNr" = T."TrainNr"
)
AND EXTRACT(DAY FROM C1."Departure") = EXTRACT(DAY FROM C1."Arrival")
AND EXTRACT(YEAR FROM C1."Departure") = EXTRACT(YEAR FROM C1."Arrival");