SELECT
    *
FROM
    animals
WHERE
    name LIKE '%mon';

SELECT
    name
FROM
    animals
WHERE
    date_of_birth BETWEEN '2016-01-01'
    AND '2019-12-31';

SELECT
    name
FROM
    animals
WHERE
    neutered = TRUE
    AND escape_attempts < 3;

SELECT
    date_of_birth
FROM
    animals
WHERE
    name IN ('Agumon', 'Pikachu');

SELECT
    name,
    escape_attempts
FROM
    animals
WHERE
    weight_kg > 10.5;

SELECT
    *
FROM
    animals
WHERE
    neutered = TRUE;

SELECT
    *
FROM
    animals
WHERE
    name <> 'Gabumon';

SELECT
    *
FROM
    animals
WHERE
    weight_kg BETWEEN 10.4
    AND 17.3;

BEGIN;

-- Start the transaction
UPDATE
    animals
SET
    species = 'unspecified';

-- Verify the change
SELECT
    *
FROM
    animals;

ROLLBACK;

-- Roll back the transaction
BEGIN;

-- Start the transaction
-- Update species for animals with name ending in "mon"
UPDATE
    animals
SET
    species = 'digimon'
WHERE
    name LIKE '%mon';

-- Update species for animals without a species set
UPDATE
    animals
SET
    species = 'pokemon'
WHERE
    species IS NULL;

-- Verify the changes
SELECT
    *
FROM
    animals;

COMMIT;

-- Commit the transaction
-- Verify the changes persist after commit
SELECT
    *
FROM
    animals;

BEGIN;

-- Start the transaction
DELETE FROM
    animals;

-- Verify that records were deleted
SELECT
    *
FROM
    animals;

ROLLBACK;

-- Roll back the transaction
BEGIN;

-- Start the transaction
-- Delete animals born after Jan 1st, 2022
DELETE FROM
    animals
WHERE
    date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT weight_update;

-- Update all animals' weights to be their weight multiplied by -1
UPDATE
    animals
SET
    weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO weight_update;

-- Update negative weights to their positive values
UPDATE
    animals
SET
    weight_kg = ABS(weight_kg)
WHERE
    weight_kg < 0;

-- Commit transaction
COMMIT;

SELECT
    COUNT(*)
FROM
    animals;

SELECT
    COUNT(*)
FROM
    animals
WHERE
    escape_attempts = 0;

SELECT
    AVG(weight_kg)
FROM
    animals;

SELECT
    neutered,
    SUM(escape_attempts) AS total_escape_attempts
FROM
    animals
GROUP BY
    neutered;

SELECT
    species,
    MIN(weight_kg) AS min_weight,
    MAX(weight_kg) AS max_weight
FROM
    animals
GROUP BY
    species;

SELECT
    species,
    AVG(escape_attempts)
FROM
    animals
WHERE
    date_of_birth >= '1990/01/01'
    AND date_of_birth <= '2000/12/31'
GROUP BY
    species;