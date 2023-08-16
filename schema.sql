-- Table for Animal
CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(10, 2) NOT NULL
);

-- Animal Table Alter
ALTER TABLE
    animals
ADD
    COLUMN species VARCHAR(100);

-- Animal Table Alter Change Column Name
ALTER TABLE
    animals
ADD
    COLUMN species_id INT REFERENCES species(id);

-- Animal Table Alter Change Column
ALTER TABLE
    animals
ADD
    COLUMN owner_id INT REFERENCES owners(id);

-- Drop Column from Animal Table
ALTER TABLE
    animals DROP COLUMN species;

-- Table for Owners
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    age INT
);

-- Table for Species
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);