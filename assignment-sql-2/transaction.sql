SET autocommit = 0;

SELECT * FROM productlines;

START transaction;
-- Insert 5 record
INSERT INTO productlines (productLine, textDescription, htmlDescription, image) VALUES 
('Electric Cars', 'Deskripsi mobil listrik', NULL, NULL),
('Bicycles', 'Deskripsi sepeda', NULL, NULL),
('Scooters', 'Deskripsi scooter', NULL, NULL),
('Speed Boats', 'Deskripsi speed boat', NULL, NULL),
('Helicopters', 'Deskripsi helikopter', NULL, NULL);
SELECT * FROM productlines;
-- Commit
COMMIT;


-- Insert/update/delete di 1 sesi dan read table di sesi yg berbeda. 

-- Session 1
START TRANSACTION;

SAVEPOINT savepoint_update;

UPDATE productlines SET textDescription = 'Update deskripsi scooters'
WHERE productLine = 'Scooters';

SELECT * FROM productlines;

-- Rollback ke savepoint
ROLLBACK TO SAVEPOINT savepoint_update;
COMMIT;
SELECT * FROM productlines;