-- Insert Information into the Dogs table
-- Identify the database being used
USE doggy_day_care;

INSERT INTO Dogs (DogID, DogName, Breed, Weight, Age, SpecialInstructions)
VALUES
(1, 'Toby', 	'Pomeranian', 		3.9, 	3, 		'Does not enjoy walking'),
(2, 'Frodo',	'Pomeranian', 		2.5, 	1, 		'Teething so needs a lot of toys'),
(3, 'Oscar', 	'YorkiePoo', 		NULL, 	10,		NULL),
(4, 'Poppy', 	'Jack Russell', 	4.7, 	16, 	'Very timid so walk alone'),
(5, 'Lady', 	'Sheep Dog', 		6.2, 	15, 	NULL),
(6, 'Rollers', 	 NULL, 				5, 		4, 		NULL),
(7, 'Max', 		'German Shephard', 	16.5, 	11, 	'Needs a lot of exercise and eats a lot'),
(8, 'Bruce', 	'Chihuahua', 		11, 	12, 	'Needs a lot of cuddles'),
(9, 'Spot', 	'Dalmantion', 		12.9, 	3, 		'Aggressive around small dogs'),
(10, 'Piddles', 'Poodle', 			9.2, 	4, 		'Needs toilet training');
