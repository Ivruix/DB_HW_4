CREATE DATABASE trainsdb;

\c trainsdb;

CREATE TABLE "City" (
	"Name" VARCHAR(255) NOT NULL,
	"Region" VARCHAR(255) NOT NULL,
	CONSTRAINT "City_pk" PRIMARY KEY ("Name","Region")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Station" (
	"Name" VARCHAR(255) NOT NULL,
	"NumberOfTracks" integer NOT NULL,
	"CityName" VARCHAR(255) NOT NULL,
	"Region" VARCHAR(255) NOT NULL,
	CONSTRAINT "Station_pk" PRIMARY KEY ("Name")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Train" (
	"TrainNr" integer NOT NULL,
	"Length" integer NOT NULL,
	"StartStationName" VARCHAR(255) NOT NULL,
	"EndStationName" VARCHAR(255) NOT NULL,
	CONSTRAINT "Train_pk" PRIMARY KEY ("TrainNr")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Connection" (
	"FromStation" VARCHAR(255) NOT NULL,
	"ToStation" VARCHAR(255) NOT NULL,
	"TrainNr" integer NOT NULL,
	"Departure" TIMESTAMP NOT NULL,
	"Arrival" TIMESTAMP NOT NULL,
	CONSTRAINT "Connection_pk" PRIMARY KEY ("FromStation","ToStation","TrainNr")
) WITH (
  OIDS=FALSE
);


ALTER TABLE "Station" ADD CONSTRAINT "Station_fk0" FOREIGN KEY ("CityName", "Region") REFERENCES "City"("Name", "Region");

ALTER TABLE "Train" ADD CONSTRAINT "Train_fk0" FOREIGN KEY ("StartStationName") REFERENCES "Station"("Name");
ALTER TABLE "Train" ADD CONSTRAINT "Train_fk1" FOREIGN KEY ("EndStationName") REFERENCES "Station"("Name");

ALTER TABLE "Connection" ADD CONSTRAINT "Connection_fk0" FOREIGN KEY ("FromStation") REFERENCES "Station"("Name");
ALTER TABLE "Connection" ADD CONSTRAINT "Connection_fk1" FOREIGN KEY ("ToStation") REFERENCES "Station"("Name");
ALTER TABLE "Connection" ADD CONSTRAINT "Connection_fk2" FOREIGN KEY ("TrainNr") REFERENCES "Train"("TrainNr");


INSERT INTO "City" ("Name", "Region")
VALUES
  ('Москва', 'Московская область'),
  ('Тверь', 'Тверская область'),
  ('Санкт-Петербург', 'Ленинградская область');

INSERT INTO "Station" ("Name", "NumberOfTracks", "CityName", "Region")
VALUES
  ('Курский вокзал', 8, 'Москва', 'Московская область'),
  ('Тверской вокзал', 4, 'Тверь', 'Тверская область'),
  ('Витебский вокзал', 5, 'Санкт-Петербург', 'Ленинградская область');

INSERT INTO "Train" ("TrainNr", "Length", "StartStationName", "EndStationName")
VALUES
  (101, 500, 'Курский вокзал', 'Витебский вокзал'),
  (103, 400, 'Курский вокзал', 'Витебский вокзал'),
  (102, 300, 'Курский вокзал', 'Тверской вокзал');

INSERT INTO "Connection" ("FromStation", "ToStation", "TrainNr", "Departure", "Arrival")
VALUES
  ('Курский вокзал', 'Тверской вокзал', 101, '2023-10-31 08:00:00', '2023-10-31 14:30:00'),
  ('Тверской вокзал', 'Витебский вокзал', 101, '2023-10-31 15:00:00', '2023-10-31 23:00:00'),
  ('Курский вокзал', 'Витебский вокзал', 101, '2023-10-31 08:00:00', '2023-10-31 23:00:00'),
  ('Курский вокзал', 'Тверской вокзал', 103, '2023-10-31 10:30:00', '2023-10-31 17:20:00'),
  ('Тверской вокзал', 'Витебский вокзал', 103, '2023-10-31 17:40:00', '2023-11-01 3:00:00'),
  ('Курский вокзал', 'Витебский вокзал', 103, '2023-10-31 10:30:00', '2023-11-01 3:00:00'),
  ('Курский вокзал', 'Тверской вокзал', 102, '2023-10-31 04:30:00', '2023-10-31 12:45:00');