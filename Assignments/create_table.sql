SET FOREIGN_KEY_CHECKS =0;
DROP TABLE IF EXISTS `company`;
DROP TABLE IF EXISTS `company_investor`;
DROP TABLE IF EXISTS `investor`;
DROP TABLE IF EXISTS `ceo`;
DROP TABLE IF EXISTS `industry`;
SET FOREIGN_KEY_CHECKS =1;



CREATE TABLE `investor` (
  `investorID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `capital` int(11) ,
  PRIMARY KEY (`investorID`),
  UNIQUE (`title`)
)ENGINE=InnoDB;

CREATE TABLE `company` (
  `compID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `ceoID` int(11) NOT NULL,
  `industryID` int(11),
  `ticker` int(11) NOT NULL,
  PRIMARY KEY (`compID`),
  CONSTRAINT teamID_on_teams_ath FOREIGN KEY (`teamID`) REFERENCES `teams` (`id`)
)ENGINE=InnoDB;

/*no industry then CEO will have no specialized expertise but can still be CEO so no cascade*/
CREATE TABLE `ceo` (
  `ceoID` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) NOT NULL,
  `age` int(11) NOT NULL,
  `industryID` int(11) NOT NULL,
  PRIMARY KEY (`ceoID`),
  CONSTRAINT fname_lname_ceo UNIQUE (`fname`, `lname`)
  CONSTRAINT `fk_ceo_industryID` 
	FOREIGN KEY (`industryID`)
	REFERENCES`industry` (`industryID`)
)ENGINE=InnoDB;

CREATE TABLE `positions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
)ENGINE=InnoDB;

CREATE TABLE `company_investor`` (
  `compID` int(11) NOT NULL ,
  `investorID` int(11) NOT NULL ,
  PRIMARY KEY (`compID`, `investorID`),
  CONSTRAINT compID_on_ci FOREIGN KEY (`compID`) REFERENCES `company` (`compID`),
  CONSTRAINT `investorID_on_ci` FOREIGN KEY (`investorID`) REFERENCES `investor` (`investorid`)
)ENGINE=InnoDB;

CREATE TABLE `position_coach_team` (
  `coachID` int(11) NOT NULL ,
  `positionID` int(11) NOT NULL ,
  `teamID` int(11) NOT NULL ,
  PRIMARY KEY (`coachID`, `positionID`, `teamID`),
  CONSTRAINT coachID_on_coaches_pct FOREIGN KEY (`coachID`) REFERENCES `coaches` (`id`),
  CONSTRAINT positionID_on_position_pct FOREIGN KEY (`positionID`) REFERENCES `positions` (`id`),
  CONSTRAINT teamID_on_teams_pct FOREIGN KEY (`teamID`) REFERENCES `teams` (`id`)
)ENGINE=InnoDB;


insert into `positions` (`type`) values
('Outside'), ('Right Side'), ('Middle'), ('Setter'), ('Defensive Specialist '), ('Libero'), ('Head Coach'), ('Assistant Coach');


insert into `coaches` (`first_name`,`last_name`) values
('John', 'Linkin'),
('Marvin', 'Smith'),
('Phillip', 'Luckow'),
('Linda', 'Debusk'),
('Golda', 'Pixley'),
('Jon', 'Mahan'),
('Zane', 'Seward'),
('Reinaldo', 'Durney'),
('Shay', 'Dutcher'),
('Katrina', 'Farrar'),
('Phil', 'Worrall'),
('Prudence', 'Ryans');



insert into `teams` (`name`,`age_group`,`level`) values
('Bears', '18 & under', '4'),
('Lions', '17 & under', '3'),
('Warriors', '17 & under', '1'),
('Fire Breathing Rubber Duckies', '14 & under', '3'),
('Falcons', '15 & under', '3'),
('Dragons', '12 & under', '3');

insert into `athletes` (`first_name`,`last_name`,`age`,`teamID`) values
('Bobby', 'Joe', '18',(SELECT `id` FROM `teams` WHERE `name` = 'Bears')),
('Peggy', 'Sue', '18',(SELECT `id` FROM `teams` WHERE `name` = 'Bears')),
('Gary', 'Beck', '18',(SELECT `id` FROM `teams` WHERE `name` = 'Bears')),
('Tracey', 'Roy', '18',(SELECT `id` FROM `teams` WHERE `name` = 'Bears')),
('Estela', 'Lilly', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Bears')),
('Gwenn', 'Felder', '18',(SELECT `id` FROM `teams` WHERE `name` = 'Bears')),
('Jim', 'Roy', '16',(SELECT `id` FROM `teams` WHERE `name` = 'Bears')),

('Linda', 'Walder', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Lions')),
('Lucas', 'Debellis', '16',(SELECT `id` FROM `teams` WHERE `name` = 'Lions')),
('Deane', 'Marro', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Lions')),
('Catarina', 'Cassese', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Lions')),
('Billy', 'Dean', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Lions')),
('Antony', 'Kimbrough', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Lions')),

('Courtney', 'Diaz', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Warriors')),
('Michael', 'Gilham', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Warriors')),
('Janell', 'Hunt', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Warriors')),
('Freda', 'Roybal', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Warriors')),
('Gargarete', 'Tracey', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Warriors')),
('Tommy', 'Eckhart', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Warriors')),
('Lien', 'Judge', '17',(SELECT `id` FROM `teams` WHERE `name` = 'Warriors')),

('Bill', 'Fennel', '14',(SELECT `id` FROM `teams` WHERE `name` = 'Fire Breathing Rubber Duckies')),
('Kizzy', 'Lamere', '14',(SELECT `id` FROM `teams` WHERE `name` = 'Fire Breathing Rubber Duckies')),
('Evonne', 'Yost', '12',(SELECT `id` FROM `teams` WHERE `name` = 'Fire Breathing Rubber Duckies')),
('Jerrod', 'Dopp', '14',(SELECT `id` FROM `teams` WHERE `name` = 'Fire Breathing Rubber Duckies')),
('Bell', 'Higgs', '13',(SELECT `id` FROM `teams` WHERE `name` = 'Fire Breathing Rubber Duckies')),
('Derrick', 'Mclead', '14',(SELECT `id` FROM `teams` WHERE `name` = 'Fire Breathing Rubber Duckies')),
('Stephenie', 'Tynan', '14',(SELECT `id` FROM `teams` WHERE `name` = 'Fire Breathing Rubber Duckies')),

('Morgan', 'Ram', '15',(SELECT `id` FROM `teams` WHERE `name` = 'Falcons')),
('Heidy', 'Decesare', '15',(SELECT `id` FROM `teams` WHERE `name` = 'Falcons')),
('Shayne', 'Gillispie', '15',(SELECT `id` FROM `teams` WHERE `name` = 'Falcons')),
('Hank', 'Bibler', '15',(SELECT `id` FROM `teams` WHERE `name` = 'Falcons')),
('Vito', 'Bady', '15',(SELECT `id` FROM `teams` WHERE `name` = 'Falcons')),
('Tyron', 'Lagon', '15',(SELECT `id` FROM `teams` WHERE `name` = 'Falcons')),
('Rocky', 'Iskra', '15',(SELECT `id` FROM `teams` WHERE `name` = 'Falcons')),

('Erica', 'Maxton', '12',(SELECT `id` FROM `teams` WHERE `name` = 'Dragons')),
('Sue', 'Baggett', '12',(SELECT `id` FROM `teams` WHERE `name` = 'Dragons')),
('Tessa', 'Lavalley', '12',(SELECT `id` FROM `teams` WHERE `name` = 'Dragons')),
('Marica', 'Overbay', '10',(SELECT `id` FROM `teams` WHERE `name` = 'Dragons')),
('Sanora', 'Gift', '12',(SELECT `id` FROM `teams` WHERE `name` = 'Dragons')),
('Twana', 'Brocious', '11',(SELECT `id` FROM `teams` WHERE `name` = 'Dragons')),
('Rickey', 'Soden', '12',(SELECT `id` FROM `teams` WHERE `name` = 'Dragons')),
('Jonah', 'Felts', '11',(SELECT `id` FROM `teams` WHERE `name` = 'Dragons'));


insert into `athlete_position` (`athleteID`,`positionID`) values
(1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,1), (1,2), (2,3),
(8,4), (9,3), (10,3), (11,2), (12,1), (13,5), (8,6), (8,1), (10,5), 
(14,3), (15,2), (16,2), (17,1), (18,6), (19,5), (20,6), (14,2), (17,2), 
(21,6), (22,5), (23,4), (24,3), (25,2), (26,1), (27,2), (23,3), (25,4), 
(28,4), (29,4), (30,3), (31,2), (32,1), (33,6), (34,5), (34,1), (32,3), 
(35,2), (36,1), (37,2), (38,4), (39,3), (40,5), (41,6), (42,5), (42,1);

insert into `position_coach_team` (`coachID`,`positionID`, `teamID`) values
((SELECT `id` FROM `coaches` WHERE `first_name` = 'John' AND `last_name` = 'Linkin' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Head Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Bears')),

((SELECT `id` FROM `coaches` WHERE `first_name` = 'Phillip' AND `last_name` = 'Luckow' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Assistant Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Bears')),



((SELECT `id` FROM `coaches` WHERE `first_name` = 'John' AND `last_name` = 'Linkin' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Assistant Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Lions')),

((SELECT `id` FROM `coaches` WHERE `first_name` = 'Marvin' AND `last_name` = 'Smith' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Head Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Lions')),

((SELECT `id` FROM `coaches` WHERE `first_name` = 'Linda' AND `last_name` = 'Debusk' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Assistant Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Warriors')),

((SELECT `id` FROM `coaches` WHERE `first_name` = 'Prudence' AND `last_name` = 'Ryans' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Head Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Warriors')),

((SELECT `id` FROM `coaches` WHERE `first_name` = 'Reinaldo' AND `last_name` = 'Durney' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Head Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Fire Breathing Rubber Duckies')),

((SELECT `id` FROM `coaches` WHERE `first_name` = 'Golda' AND `last_name` = 'Pixley' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Assistant Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Fire Breathing Rubber Duckies')),

((SELECT `id` FROM `coaches` WHERE `first_name` = 'Zane' AND `last_name` = 'Seward' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Head Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Falcons')),

((SELECT `id` FROM `coaches` WHERE `first_name` = 'Jon' AND `last_name` = 'Mahan' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Assistant Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Falcons')),



((SELECT `id` FROM `coaches` WHERE `first_name` = 'Shay' AND `last_name` = 'Dutcher' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Head Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Dragons')),

((SELECT `id` FROM `coaches` WHERE `first_name` = 'Katrina' AND `last_name` = 'Farrar' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Assistant Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Dragons')),

((SELECT `id` FROM `coaches` WHERE `first_name` = 'Phil' AND `last_name` = 'Worrall' ), 
  (SELECT `id` FROM `positions` WHERE `type` = 'Assistant Coach'), 
  (SELECT `id` FROM `teams` WHERE `name` = 'Dragons'));












