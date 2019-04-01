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
  `capital` int(11) NOT NULL,
  PRIMARY KEY (`investorID`),
)ENGINE=InnoDB;

CREATE TABLE `company` (
  `compID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `industryID` int(11) NOT NULL,
  `marketCap` int(11) NOT NULL,
  `ticker` varchar(255) NOT NULL
  PRIMARY KEY (`compID`),
  CONSTRAINT `fk_company_industryID` 
    FOREIGN KEY (`industryID`) 
    REFERENCES `industry` (`industryID`)
)ENGINE=InnoDB;

/*no industry then CEO will have no specialized expertise but can still be CEO so no cascade*/
CREATE TABLE `ceo` (
  `ceoID` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`ceoID`),
  CONSTRAINT fname_lname_ceo UNIQUE (`fname`, `lname`)
  CONSTRAINT `fk_ceo_industryID` 
	 FOREIGN KEY (`industryID`)
	 REFERENCES`industry` (`industryID`)
)ENGINE=InnoDB;

CREATE TABLE `industry` (
  `industryID` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `size` int(11) NOT NULL,
  PRIMARY KEY (`industryID`)
)ENGINE=InnoDB;

CREATE TABLE `company_investor` (
  `compID` int(11) NOT NULL ,
  `investorID` int(11) NOT NULL ,
  PRIMARY KEY (`compID`, `investorID`),
  CONSTRAINT `compID_on_ci` 
    FOREIGN KEY (`compID`) 
    REFERENCES `company` (`compID`),
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `investorID_on_ci` 
    FOREIGN KEY (`investorID`) 
    REFERENCES `investor` (`investorid`)
)ENGINE=InnoDB;



INSERT INTO `investor` (`title`, `capital`) VALUES
('Mutual Fund', '578000000'), 
('REIT', '928000000'), 
('Hedge Fund', '50000000'), 
('Venture Capital', '50000000'), 
('Pension', '5000000'), 
('Government Asset', '50000000'), 
('Accredited Investor', '50000000');

INSERT INTO `industry` (`type`, `size`) VALUES
('Semiconductor', '3000'), 
('Retail', '5000'), 
('Technology', '12000'), 
('Finance', '8000'), 
('Restaurant', '7000'), 
('Fashion', '50000'), 
('Architecture', '30000');

INSERT INTO `ceo` (`fname`,`lname`,`age`,`industryID`) VALUES
('Elon', 'Musk', '45', (SELECT `industryID` FROM `industry` WHERE `type` = 'Technology')),
('Ginny', 'Rometty', '58', (SELECT `industryID` FROM `industry` WHERE `type` = 'Technology')),
('James', 'Dimon', '55', (SELECT `industryID` FROM `industry` WHERE `type` = 'Finance')),
('Alain', 'Wertheimer', '68', (SELECT `industryID` FROM `industry` WHERE `type` ='Fashion')),
('Jack', 'Dorsey' '41', (SELECT `industryID` FROM `industry` WHERE `type` ='Technology'));


INSERT INTO `company_investor` (`compID`,`investorID`) VALUES
(1,1), (1,2), (2,2), (2,3), (3,3), (3,7) (4,4), (5,5), (6,6), (7,1), (7,2), (7,5),
(8,4), (9,3), (10,3) (10,5);

INSERT INTO `company` (`name`, `ceoID`, `industryID`, `marketCap`, `ticker`)  VALUES 
('Tesla',(SELECT `ceoID` FROM `ceo` WHERE `fname` = 'Elon' and `lname`='Musk'), (SELECT `industryID` FROM `industry` WHERE `type` = 'Technology'),'58310000000', 'TSLA'),,
('IBM',(SELECT `ceoID` FROM `ceo` WHERE `fname` = 'Ginny' and `lname`='Rometty'), (SELECT `industryID` FROM `industry` WHERE `type` = 'Technology'), '147770000', 'IBM'),
('JP Morgan',(SELECT `ceoID` FROM `ceo` WHERE `fname` = 'James' and `lname`='Dimon'), (SELECT `industryID` FROM `industry` WHERE `type` = 'Finance'), '316260000', 'JPM');

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












