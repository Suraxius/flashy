PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE config (
    id INTEGER PRIMARY KEY,
    key TEXT NOT NULL,
    value TEXT NOT NULL
);
INSERT INTO config VALUES(0,'NEW_CARD_BOX_ID','4');
INSERT INTO config VALUES(1,'USERNAME','username');
INSERT INTO config VALUES(2,'PASSWORD','password');
CREATE TABLE boxes (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    class_id_on_correct INTEGER NOT NULL,
    class_id_on_incorrect INTEGER NOT NULL,
    FOREIGN KEY(class_id_on_correct) REFERENCES boxes(id) ON UPDATE CASCADE,
    FOREIGN KEY(class_id_on_incorrect) REFERENCES boxes(id) ON UPDATE CASCADE
);
INSERT INTO boxes VALUES(0,'Mastered',0,5);
INSERT INTO boxes VALUES(1,'Correct Thrice',0,5);
INSERT INTO boxes VALUES(2,'Correct Twice',1,5);
INSERT INTO boxes VALUES(3,'Correct Once',2,5);
INSERT INTO boxes VALUES(4,'New',3,5);
INSERT INTO boxes VALUES(5,'Failed Once',3,6);
INSERT INTO boxes VALUES(6,'Failed Twice',3,7);
INSERT INTO boxes VALUES(7,'Failed Thrice',3,7);
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
INSERT INTO cards VALUES(1,4,1,'the house','das Haus');
INSERT INTO cards VALUES(2,4,1,'my house','mein Haus');
INSERT INTO cards VALUES(3,4,1,'your house','dein Haus');
INSERT INTO cards VALUES(4,4,1,'his house','sein Haus');
INSERT INTO cards VALUES(5,4,1,'her house','ihr Haus');
INSERT INTO cards VALUES(6,4,1,'our house','unser Haus');
INSERT INTO cards VALUES(7,4,1,'your house (plural)','euer Haus');
INSERT INTO cards VALUES(8,4,1,'their house','ihr Haus');
INSERT INTO cards VALUES(9,4,1,'the child','das Kind');
INSERT INTO cards VALUES(10,4,1,'my child','mein Kind');
INSERT INTO cards VALUES(11,4,1,'your child','dein Kind');
INSERT INTO cards VALUES(12,4,1,'his child','sein Kind');
INSERT INTO cards VALUES(13,4,1,'her child','ihr Kind');
INSERT INTO cards VALUES(14,4,1,'our child','unser Kind');
INSERT INTO cards VALUES(15,4,1,'your child (plural)','euer Kind');
INSERT INTO cards VALUES(16,4,1,'their child','ihr Kind');
INSERT INTO cards VALUES(17,4,2,'to eat','essen');
INSERT INTO cards VALUES(18,4,3,'i eat','ich esse');
INSERT INTO cards VALUES(19,4,3,'you eat (singular)','du isst');
INSERT INTO cards VALUES(20,4,3,'he eats','er isst');
INSERT INTO cards VALUES(21,4,3,'she eats','sie isst');
INSERT INTO cards VALUES(22,4,3,'we eat','wir essen');
INSERT INTO cards VALUES(23,4,3,'you eat (plural)','ihr esst');
INSERT INTO cards VALUES(24,4,3,'they eat','sie essen');
INSERT INTO cards VALUES(25,4,4,'i ate','ich ass');
INSERT INTO cards VALUES(26,4,4,'you ate','du asst');
INSERT INTO cards VALUES(27,4,4,'he ate','er ass');
INSERT INTO cards VALUES(28,4,4,'she ate','sie ass');
INSERT INTO cards VALUES(29,4,4,'we ate','wir assen');
INSERT INTO cards VALUES(30,4,4,'you ate (plural)','ihr asst');
INSERT INTO cards VALUES(31,4,4,'they ate','sie assen');
INSERT INTO cards VALUES(32,4,1,'the baker','der Bäcker');
INSERT INTO cards VALUES(33,4,1,'the children','die Kinder');
INSERT INTO cards VALUES(34,4,1,'my children','meine Kinder');
INSERT INTO cards VALUES(35,4,1,'your children','deine Kinder');
INSERT INTO cards VALUES(36,4,1,'his children','seine Kinder');
INSERT INTO cards VALUES(37,4,1,'her children','ihre Kinder');
INSERT INTO cards VALUES(38,4,1,'our children','unsere Kinder');
INSERT INTO cards VALUES(39,4,1,'your children (plural)','eure Kinder');
INSERT INTO cards VALUES(40,4,1,'their children','ihre Kinder');
INSERT INTO cards VALUES(41,4,1,'the bakers','die Bäcker');
INSERT INTO cards VALUES(42,4,9,'ruthless','rücksichtslos');
INSERT INTO cards VALUES(43,4,4,'it ate','es ass');
INSERT INTO cards VALUES(46,4,1,'the mountain','der Berg');
INSERT INTO cards VALUES(47,4,2,'to fit','passen');
INSERT INTO cards VALUES(48,4,1,'the river','der Fluss');
INSERT INTO cards VALUES(49,4,1,'the stage','die Bühne');
INSERT INTO cards VALUES(50,4,2,'to find','finden');
INSERT INTO cards VALUES(51,4,2,'to take','nehmen');
INSERT INTO cards VALUES(52,4,2,'to taste','schmecken');
INSERT INTO cards VALUES(53,4,1,'really','wirklick');
INSERT INTO cards VALUES(54,4,2,'to pay','bezahlen');
INSERT INTO cards VALUES(55,4,2,'to bring','bringen');
INSERT INTO cards VALUES(56,4,1,'the bill','die Rechnung');
INSERT INTO cards VALUES(57,4,1,'the waiter','der Kellner');
INSERT INTO cards VALUES(58,4,2,'to order','bestellen');
INSERT INTO cards VALUES(59,4,2,'to wish','wünschen');
INSERT INTO cards VALUES(60,4,2,'to get','bekommen');
INSERT INTO cards VALUES(61,4,1,'exactly ','genau');
INSERT INTO cards VALUES(62,4,1,'something','etwas');
INSERT INTO cards VALUES(63,4,2,'to climb','klettern');
INSERT INTO cards VALUES(64,4,2,'to desire','begehren');
INSERT INTO cards VALUES(65,4,1,'the pub','die Kneipe');
INSERT INTO cards VALUES(66,4,1,'again','wieder');
INSERT INTO cards VALUES(67,4,9,'open','offen');
INSERT INTO cards VALUES(68,4,2,'to open','öffnen');
INSERT INTO cards VALUES(69,4,9,'closed','geschlossen');
INSERT INTO cards VALUES(70,4,2,'to close','schliessen');
INSERT INTO cards VALUES(71,4,1,'the resident','der Einwohner');
INSERT INTO cards VALUES(72,4,2,'to be cold','frieren');
INSERT INTO cards VALUES(73,4,1,'the desire','das Verlangen');
INSERT INTO cards VALUES(74,4,1,'the passenger','der Fahrgast');
INSERT INTO cards VALUES(75,4,9,'at (location)','bei');
INSERT INTO cards VALUES(76,4,1,'all','alle');
INSERT INTO cards VALUES(77,4,1,'the area (surface)','die Fläche');
INSERT INTO cards VALUES(78,4,2,'to lie (position)','liegen');
INSERT INTO cards VALUES(79,4,9,'high','hoch');
INSERT INTO cards VALUES(80,4,1,'the border','die Grenze');
INSERT INTO cards VALUES(81,4,1,'the main train station','der Hauptbahnhof');
INSERT INTO cards VALUES(82,4,1,'the harbour','der Hafen');
INSERT INTO cards VALUES(83,4,1,'the Opera','die Oper');
INSERT INTO cards VALUES(84,4,1,'the church','die Kirche');
INSERT INTO cards VALUES(86,4,2,'to get there','hingelangen');
INSERT INTO cards VALUES(87,4,1,'the play','das Stück');
INSERT INTO cards VALUES(88,4,1,'the ticket','das Ticket');
INSERT INTO cards VALUES(89,4,1,'the fridge','der Kühlschrank');
INSERT INTO cards VALUES(90,4,1,'afterwards','nachher');
INSERT INTO cards VALUES(91,4,1,'rarely','selten');
INSERT INTO cards VALUES(92,4,2,'to cut','schneiden');
INSERT INTO cards VALUES(93,4,1,'both','beide');
INSERT INTO cards VALUES(94,4,2,'to sit','sitzen');
INSERT INTO cards VALUES(95,4,2,'to sit down','hinsetzen');
INSERT INTO cards VALUES(96,4,2,'to fetch','holen');
INSERT INTO cards VALUES(97,4,1,'the surface','die Oberfläche');
INSERT INTO cards VALUES(98,4,1,'the lumberjack','der Holzfäller');
INSERT INTO cards VALUES(99,4,2,'to open','öffnen');
INSERT INTO cards VALUES(100,4,9,'at (time)','um');
INSERT INTO cards VALUES(101,4,2,'to lie (telling untruth)','lügen');
INSERT INTO cards VALUES(102,4,2,'to take (time)','dauert');
INSERT INTO cards VALUES(103,4,1,'admission','Eintritt');
INSERT INTO cards VALUES(104,4,0,'the change','die Änderung');
INSERT INTO cards VALUES(105,4,0,'to change','ändern');
COMMIT;
