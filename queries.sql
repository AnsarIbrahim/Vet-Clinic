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

SELECT
    o.full_name AS owner_name,
    a.name AS animal_name
FROM
    owners o
    JOIN animals a ON o.id = a.owner_id
WHERE
    o.full_name = 'Melody Pond';

SELECT
    a.name
FROM
    animals a
    JOIN species s ON a.species_id = s.id
WHERE
    s.name = 'Pokemon';

SELECT
    o.full_name,
    COALESCE(array_agg(a.name), ARRAY [] :: VARCHAR [])
FROM
    owners o
    LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY
    o.full_name;

SELECT
    s.name,
    COUNT(a.id) AS animal_count
FROM
    species s
    LEFT JOIN animals a ON s.id = a.species_id
GROUP BY
    s.name;

SELECT
    a.name
FROM
    animals a
    JOIN owners o ON a.owner_id = o.id
    JOIN species s ON a.species_id = s.id
WHERE
    o.full_name = 'Jennifer Orwell'
    AND s.name = 'Digimon';

SELECT
    owners.full_name AS owner_name,
    animals.escape_attempts,
    animals.name AS animal_name
FROM
    animals
    JOIN owners ON animals.owner_id = owners.id
WHERE
    owners.full_name = 'Dean Winchester'
    AND animals.escape_attempts = 0
UNION
SELECT
    'Dean Winchester' AS owner_name,
    0 AS escape_attempts,
    NULL AS animal_name
LIMIT
    1;

SELECT
    o.full_name,
    COUNT(a.id) AS animal_count
FROM
    owners o
    LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY
    o.full_name
ORDER BY
    animal_count DESC
LIMIT
    1;

-- Who was the last animal seen by William Tatcher?
SELECT
    a.name AS animal_name
FROM
    animals a
    JOIN visits v ON a.id = v.animal_id
    JOIN vets vt ON v.vet_id = vt.id
WHERE
    vt.name = 'William Tatcher'
ORDER BY
    v.visit_date DESC
LIMIT
    1;

-- How many different animals did Stephanie Mendez see?
SELECT
    COUNT(DISTINCT v.animal_id) AS num_animals_seen
FROM
    visits v
    JOIN vets vt ON v.vet_id = vt.id
WHERE
    vt.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT
    v.name AS vet_name,
    s.name AS specialty
FROM
    vets v
    LEFT JOIN specializations sp ON v.id = sp.vet_id
    LEFT JOIN species s ON sp.species_id = s.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT
    a.name AS animal_name,
    v.visit_date
FROM
    animals a
    JOIN visits v ON a.id = v.animal_id
    JOIN vets vt ON v.vet_id = vt.id
WHERE
    vt.name = 'Stephanie Mendez'
    AND v.visit_date BETWEEN '2020-04-01'
    AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT
    a.name AS animal_name,
    COUNT(v.animal_id) AS num_visits
FROM
    animals a
    JOIN visits v ON a.id = v.animal_id
GROUP BY
    a.name
ORDER BY
    num_visits DESC
LIMIT
    1;

-- Who was Maisy Smith's first visit?
SELECT
    a.name AS animal_name,
    v.visit_date
FROM
    animals a
    JOIN visits v ON a.id = v.animal_id
    JOIN vets vt ON v.vet_id = vt.id
    JOIN owners o ON a.owner_id = o.id
WHERE
    o.full_name = 'Maisy Smith'
ORDER BY
    v.visit_date ASC
LIMIT
    1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
    a.name AS animal_name,
    v.visit_date,
    vt.name AS vet_name
FROM
    animals a
    JOIN visits v ON a.id = v.animal_id
    JOIN vets vt ON v.vet_id = vt.id
ORDER BY
    v.visit_date DESC
LIMIT
    1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT
    COUNT(*) AS num_visits
FROM
    visits v
    JOIN animals a ON v.animal_id = a.id
    JOIN vets vt ON v.vet_id = vt.id
    LEFT JOIN specializations sp ON vt.id = sp.vet_id
    AND a.species_id = sp.species_id
WHERE
    sp.vet_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT
    s.name AS potential_specialty,
    COUNT(*) AS num_visits
FROM
    visits v
    JOIN animals a ON v.animal_id = a.id
    JOIN owners o ON a.owner_id = o.id
    JOIN specializations sp ON a.species_id = sp.species_id
    JOIN species s ON sp.species_id = s.id
WHERE
    o.full_name = 'Maisy Smith'
GROUP BY
    s.name
ORDER BY
    num_visits DESC
LIMIT
    1;