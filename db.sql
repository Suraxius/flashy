PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE boxes (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    class_id_on_correct INTEGER NOT NULL, 
    class_id_on_incorrect INTEGER NOT NULL,
    FOREIGN KEY(class_id_on_correct) REFERENCES boxes(id) ON UPDATE CASCADE,
    FOREIGN KEY(class_id_on_incorrect) REFERENCES boxes(id) ON UPDATE CASCADE
);
INSERT INTO boxes VALUES(0,'Failed Thrice',4,0);
INSERT INTO boxes VALUES(1,'Failed Twice',4,0);
INSERT INTO boxes VALUES(2,'Failed Once',4,1);
INSERT INTO boxes VALUES(3,'New',4,2);
INSERT INTO boxes VALUES(4,'Correct Once',5,2);
INSERT INTO boxes VALUES(5,'Correct Twice',6,2);
INSERT INTO boxes VALUES(6,'Correct Thrice',7,2);
INSERT INTO boxes VALUES(7,'Mastered',7,2);
CREATE TABLE classes (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);
INSERT INTO classes VALUES(0,'Pronoun');
INSERT INTO classes VALUES(1,'Noun');
INSERT INTO classes VALUES(2,'Verb (Infinitive)');
INSERT INTO classes VALUES(3,'Verb (Praesens)');
INSERT INTO classes VALUES(4,'Verb (Perfekt)');
INSERT INTO classes VALUES(5,'Verb (Praeteritum)');
INSERT INTO classes VALUES(6,'Verb (Plusquamperfekt)');
INSERT INTO classes VALUES(7,'Verb (Futur)');
INSERT INTO classes VALUES(8,'Verb (Futur II)');
INSERT INTO classes VALUES(9,'Adjective');
INSERT INTO classes VALUES(10,'Adverb');
CREATE TABLE cards (
    id INTEGER PRIMARY KEY,
    box_id INTEGER DEFAULT 3,
    class_id INTEGER NOT NULL,
    front TEXT NOT NULL,
    back TEXT NOT NULL,
    FOREIGN KEY(box_id) REFERENCES boxes(id) ON UPDATE CASCADE,
    FOREIGN KEY(class_id) REFERENCES classes(id) ON UPDATE CASCADE
);
INSERT INTO cards VALUES(1,3,1,'the house','das Haus');
INSERT INTO cards VALUES(2,3,1,'my house','mein Haus');
INSERT INTO cards VALUES(3,3,1,'your house','dein Haus');
INSERT INTO cards VALUES(4,3,1,'his house','sein Haus');
INSERT INTO cards VALUES(5,3,1,'her house','ihr Haus');
INSERT INTO cards VALUES(6,3,1,'our house','unser Haus');
INSERT INTO cards VALUES(7,3,1,'your house (plural)','euer Haus');
INSERT INTO cards VALUES(8,3,1,'their house','ihr Haus');
INSERT INTO cards VALUES(9,3,1,'the child','das Kind');
INSERT INTO cards VALUES(10,3,1,'my child','mein Kind');
INSERT INTO cards VALUES(11,3,1,'your child','dein Kind');
INSERT INTO cards VALUES(12,3,1,'his child','sein Kind');
INSERT INTO cards VALUES(13,3,1,'her child','ihr Kind');
INSERT INTO cards VALUES(14,3,1,'our child','unser Kind');
INSERT INTO cards VALUES(15,3,1,'your child (plural)','euer Kind');
INSERT INTO cards VALUES(16,3,1,'their child','ihr Kind');
INSERT INTO cards VALUES(17,3,2,'to eat','essen');
INSERT INTO cards VALUES(18,3,3,'i eat','ich esse');
INSERT INTO cards VALUES(19,3,3,'you eat (singular)','du isst');
INSERT INTO cards VALUES(20,3,3,'he eats','er isst');
INSERT INTO cards VALUES(21,3,3,'she eats','sie isst');
INSERT INTO cards VALUES(22,3,3,'we eat','wir essen');
INSERT INTO cards VALUES(23,3,3,'you eat (plural)','ihr esst');
INSERT INTO cards VALUES(24,3,3,'they eat','sie essen');
INSERT INTO cards VALUES(25,3,4,'i ate','ich ass');
INSERT INTO cards VALUES(26,3,4,'you ate','du asst');
INSERT INTO cards VALUES(27,3,4,'he ate','er ass');
INSERT INTO cards VALUES(28,3,4,'she ate','sie ass');
INSERT INTO cards VALUES(29,3,4,'we ate','wir assen');
INSERT INTO cards VALUES(30,3,4,'you ate (plural)','ihr asst');
INSERT INTO cards VALUES(31,3,4,'they ate','sie assen');
INSERT INTO cards VALUES(32,3,1,'the baker','der Bäcker');
INSERT INTO cards VALUES(33,3,1,'the children','die Kinder');
INSERT INTO cards VALUES(34,3,1,'my children','meine Kinder');
INSERT INTO cards VALUES(35,3,1,'your children','deine Kinder');
INSERT INTO cards VALUES(36,3,1,'his children','seine Kinder');
INSERT INTO cards VALUES(37,3,1,'her children','ihre Kinder');
INSERT INTO cards VALUES(38,3,1,'our children','unsere Kinder');
INSERT INTO cards VALUES(39,3,1,'your children (plural)','eure Kinder');
INSERT INTO cards VALUES(40,3,1,'their children','ihre Kinder');
INSERT INTO cards VALUES(41,3,1,'the bakers','die Bäcker');
INSERT INTO cards VALUES(42,3,9,'ruthless','rücksichtslos');
INSERT INTO cards VALUES(43,3,4,'it ate','es ass');
INSERT INTO cards VALUES(46,3,1,'the mountain','der Berg');
INSERT INTO cards VALUES(47,3,2,'to fit','passen');
INSERT INTO cards VALUES(48,3,1,'river','Fluss');
INSERT INTO cards VALUES(49,3,1,'the stage','die Bühne');
INSERT INTO cards VALUES(50,3,2,'to find','finden');
INSERT INTO cards VALUES(51,3,2,'to take','nehmen');
INSERT INTO cards VALUES(52,3,2,'to taste','schmecken');
INSERT INTO cards VALUES(53,3,1,'really','wirklick');
INSERT INTO cards VALUES(54,3,2,'to pay','Zahlen');
INSERT INTO cards VALUES(55,3,2,'to bring','bringen');
INSERT INTO cards VALUES(56,3,1,'bill','Die Rechnung');
INSERT INTO cards VALUES(57,3,1,'the waiter','Der Kellner');
INSERT INTO cards VALUES(58,3,2,'to order','bestellen');
INSERT INTO cards VALUES(59,3,2,'to wish','wünschen');
INSERT INTO cards VALUES(60,3,2,'to get','bekommen');
INSERT INTO cards VALUES(61,3,1,'exactly ','genau');
INSERT INTO cards VALUES(62,3,1,'something','etwas');
INSERT INTO cards VALUES(63,3,2,'to climb','klettern');
INSERT INTO cards VALUES(64,3,2,'to desire','begehren');
INSERT INTO cards VALUES(65,3,1,'the pub','Die Kneipe');
INSERT INTO cards VALUES(66,3,1,'again','wieder');
INSERT INTO cards VALUES(67,3,1,'open','geöffnet');
INSERT INTO cards VALUES(68,3,2,'to open','öffnen');
INSERT INTO cards VALUES(69,3,1,'closed','geschlossen');
INSERT INTO cards VALUES(70,3,2,'to close','schliessen');
INSERT INTO cards VALUES(71,3,1,'the resident','der Einwohner');
INSERT INTO cards VALUES(72,3,2,'to freeze','frieren');
INSERT INTO cards VALUES(73,3,1,'the desire','die Lust');
INSERT INTO cards VALUES(74,3,1,'the passenger','der Fahrgast');
INSERT INTO cards VALUES(75,3,1,'at','bei');
INSERT INTO cards VALUES(76,3,1,'all','alle');
INSERT INTO cards VALUES(77,3,1,'the area (surface)','die Fläche');
INSERT INTO cards VALUES(78,3,2,'to lie down','liegen');
INSERT INTO cards VALUES(79,3,1,'high','hoch');
INSERT INTO cards VALUES(80,3,1,'the border','die Grenze');
INSERT INTO cards VALUES(81,3,1,'the main train station','der Hauptbahnhof');
INSERT INTO cards VALUES(82,3,1,'the harbour','der Hafen');
INSERT INTO cards VALUES(83,3,1,'the Opera','die Oper');
INSERT INTO cards VALUES(84,3,1,'the church','die Kirche');
INSERT INTO cards VALUES(85,3,2,'last','dauern');
INSERT INTO cards VALUES(86,3,2,'to get there','hingelangen');
INSERT INTO cards VALUES(87,3,1,'the play','das Stück');
INSERT INTO cards VALUES(88,3,1,'the ticket','das Ticket');
INSERT INTO cards VALUES(89,3,1,'the fridge','der Kühlschrank');
INSERT INTO cards VALUES(90,3,1,'afterwards','nachher');
INSERT INTO cards VALUES(91,3,1,'rarely','selten');
INSERT INTO cards VALUES(92,3,2,'to cut','schneiden');
INSERT INTO cards VALUES(93,3,1,'both','beide');
INSERT INTO cards VALUES(94,3,2,'to sit','sitzen');
INSERT INTO cards VALUES(95,3,2,'to sit down','sich hinsetzen');
INSERT INTO cards VALUES(96,3,2,'to fetch','holen');
INSERT INTO cards VALUES(97,3,1,'the surface','die Oberfläche');
COMMIT;
