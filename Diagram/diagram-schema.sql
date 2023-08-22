CREATE TABLE "animals"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "date_of_birth" DATE NOT NULL,
    "escape_attempts" INTEGER NOT NULL,
    "neutered" BOOLEAN NOT NULL,
    "owners_id" INTEGER NOT NULL,
    "species_id" INTEGER NOT NULL,
    "weight_kg" DECIMAL(8, 2) NOT NULL
);

ALTER TABLE
    "animals"
ADD
    PRIMARY KEY("id");

CREATE TABLE "specialization"(
    "species_id" INTEGER NOT NULL,
    "vet_id" INTEGER NOT NULL
);

ALTER TABLE
    "specialization"
ADD
    PRIMARY KEY("species_id");

ALTER TABLE
    "specialization"
ADD
    PRIMARY KEY("vet_id");

CREATE TABLE "species"(
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL
);

ALTER TABLE
    "species"
ADD
    PRIMARY KEY("id");

CREATE TABLE "visit"(
    "animal_id" INTEGER NOT NULL,
    "vet_id" INTEGER NOT NULL,
    "date_of_visit" DATE NOT NULL
);

ALTER TABLE
    "visit"
ADD
    PRIMARY KEY("animal_id");

ALTER TABLE
    "visit"
ADD
    PRIMARY KEY("vet_id");

CREATE TABLE "vets"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL,
    "DATE_OF_GRADUATION" DATE NOT NULL
);

ALTER TABLE
    "vets"
ADD
    PRIMARY KEY("id");

CREATE TABLE "owners"(
    "id" SERIAL NOT NULL,
    "full_name" VARCHAR(255) NULL,
    "email" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL
);

ALTER TABLE
    "owners"
ADD
    PRIMARY KEY("id");

ALTER TABLE
    "vets"
ADD
    CONSTRAINT "vets_id_foreign" FOREIGN KEY("id") REFERENCES "visit"("vet_id");

ALTER TABLE
    "animals"
ADD
    CONSTRAINT "animals_species_id_foreign" FOREIGN KEY("species_id") REFERENCES "species"("id");

ALTER TABLE
    "specialization"
ADD
    CONSTRAINT "specialization_species_id_foreign" FOREIGN KEY("species_id") REFERENCES "species"("id");

ALTER TABLE
    "specialization"
ADD
    CONSTRAINT "specialization_vet_id_foreign" FOREIGN KEY("vet_id") REFERENCES "vets"("id");

ALTER TABLE
    "visit"
ADD
    CONSTRAINT "visit_animal_id_foreign" FOREIGN KEY("animal_id") REFERENCES "animals"("id");

ALTER TABLE
    "animals"
ADD
    CONSTRAINT "animals_owners_id_foreign" FOREIGN KEY("owners_id") REFERENCES "owners"("id");