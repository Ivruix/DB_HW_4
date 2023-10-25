CREATE DATABASE hospitaldb;

\c hospitaldb;


CREATE TABLE "StationPersonnel" (
	"PersNr" integer NOT NULL,
	"Name" VARCHAR(255) NOT NULL,
	"StatNr" integer NOT NULL,
	CONSTRAINT "StationPersonnel_pk" PRIMARY KEY ("PersNr")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Station" (
	"StatNr" integer NOT NULL,
	"Name" VARCHAR(255) NOT NULL,
	CONSTRAINT "Station_pk" PRIMARY KEY ("StatNr")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Doctor" (
	"PersNr" integer NOT NULL,
	"Name" VARCHAR(255) NOT NULL,
	"StatNr" integer NOT NULL,
	"Area" VARCHAR(255) NOT NULL,
	"Rank" VARCHAR(255) NOT NULL,
	CONSTRAINT "Doctor_pk" PRIMARY KEY ("PersNr")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Caregiver" (
	"PersNr" integer NOT NULL,
	"Name" VARCHAR(255) NOT NULL,
	"StatNr" integer NOT NULL,
	"Qualification" VARCHAR(255) NOT NULL,
	CONSTRAINT "Caregiver_pk" PRIMARY KEY ("PersNr")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Patient" (
	"PatientNr" serial NOT NULL,
	"Name" VARCHAR(255) NOT NULL,
	"Disease" VARCHAR(255) NOT NULL,
	"RoomNr" integer NOT NULL,
	"from" TIMESTAMP NOT NULL,
	"to" TIMESTAMP NOT NULL,
	CONSTRAINT "Patient_pk" PRIMARY KEY ("PatientNr")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Room" (
	"RoomNr" integer NOT NULL,
	"StatNr" integer NOT NULL,
	"NumberOfBeds" integer NOT NULL,
	CONSTRAINT "Room_pk" PRIMARY KEY ("RoomNr")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Treats" (
	"PersNr" integer NOT NULL,
	"PatientNr" integer NOT NULL,
	CONSTRAINT "Treats_pk" PRIMARY KEY ("PersNr","PatientNr")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "StationPersonnel" ADD CONSTRAINT "StationPersonnel_fk0" FOREIGN KEY ("StatNr") REFERENCES "Station"("StatNr");


ALTER TABLE "Doctor" ADD CONSTRAINT "Doctor_fk0" FOREIGN KEY ("PersNr") REFERENCES "StationPersonnel"("PersNr");
ALTER TABLE "Doctor" ADD CONSTRAINT "Doctor_fk1" FOREIGN KEY ("StatNr") REFERENCES "Station"("StatNr");

ALTER TABLE "Caregiver" ADD CONSTRAINT "Caregiver_fk0" FOREIGN KEY ("PersNr") REFERENCES "StationPersonnel"("PersNr");
ALTER TABLE "Caregiver" ADD CONSTRAINT "Caregiver_fk1" FOREIGN KEY ("StatNr") REFERENCES "Station"("StatNr");

ALTER TABLE "Patient" ADD CONSTRAINT "Patient_fk0" FOREIGN KEY ("RoomNr") REFERENCES "Room"("RoomNr");

ALTER TABLE "Room" ADD CONSTRAINT "Room_fk0" FOREIGN KEY ("StatNr") REFERENCES "Station"("StatNr");

ALTER TABLE "Treats" ADD CONSTRAINT "Treats_fk0" FOREIGN KEY ("PersNr") REFERENCES "Doctor"("PersNr");
ALTER TABLE "Treats" ADD CONSTRAINT "Treats_fk1" FOREIGN KEY ("PatientNr") REFERENCES "Patient"("PatientNr");