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