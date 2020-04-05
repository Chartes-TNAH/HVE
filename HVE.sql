--Création de la table user : 
CREATE TABLE IF NOT EXISTS user (
	user_id	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	user_nom	TINYTEXT NOT NULL,
	user_login	VARCHAR ( 45 ) NOT NULL,
	user_email	TINYTEXT NOT NULL,
	user_password	VARCHAR ( 25 ) NOT NULL
);

-- Création de la table Auteur : 
CREATE TABLE IF NOT EXISTS Auteur (
	auteur_id	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	auteur_nom	TINYTEXT NOT NULL,
	auteur_origine	VARCHAR (45) NOT NULL,
	auteur_naissance	TINYTEXT,
	auteur_mort	TINYTEXT,
	auteur_profession VARCHAR (45),
	auteur_image BOOLEAN DEFAULT NULL,
	auteur_biographie TEXT
);

-- Création de la table Oeuvre : 
CREATE TABLE IF NOT EXISTS Oeuvre (
	oeuvre_id	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	oeuvre_titre_original	TINYTEXT NOT NULL,
	oeuvre_autre_titre TINYTEXT,
	oeuvre_date TINYTEXT,
	oeuvre_auteur_fk INTEGER NULL REFERENCES Auteur(auteur_id)
);

-- Création de la table Plante :
CREATE TABLE IF NOT EXISTS Plante (
	plante_id	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	plante_latin	VARCHAR (45) NOT NULL,
	plante_fran	VARCHAR (45) NOT NULL,
	plante_rhapsodie integer NOT NULL,
	plante_texte	integer NOT NULL
);

--Création de la table Citation : 
CREATE TABLE IF NOT EXISTS Citation (
	citation_id	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	citation_auteur_id integer NULL REFERENCES Auteur(auteur_id),
	citation_plante_id integer NULL REFERENCES Plante(plante_id)
);


-- Peuplement de la table Auteur : 
INSERT INTO Auteur(auteur_nom, auteur_origine, auteur_naissance, auteur_mort, auteur_profession, auteur_image, auteur_biographie) VALUES 
("Pédanius Dioscoride", "Grec", "20-40 après J-C", "90 après J-C", "médecin", 1, "Pedianus Dioscoride médecin et pharmacologue, né en Cilicie au Ier siècle après Jésus-Christ. Il fait ses études à Pergame, Alexandrie et semble avoir étudié Théophraste, Cratevas et Sextius Niger. Il est médecin dans l armée de Néron, ce qui lui permet d étudier la botanique spécifique de différentes provinces. Il est l auteur d un traité de pharmacologie en 5 tomes, le De materia medica qui mentionne de nombreuses drogues notamment végétales. Les plantes y sont classées selon leurs propriétés médicales et ordonnées sous forme de familles. Par la méthode qu il utilise et l exactitude des informations, son ouvrage fait encore référence à la Renaissance et a un rôle important dans l histoire de la botanique descriptive."),

("Pline l Ancien", "Romain", "23 après J-C", "79 après J-C", "naturaliste", 1, "Né à Côme, il appartient à l odre équestre, et effectue sa carrière au sein de l armée et de l administration romaine. Décédé à Strabies lors de l éruption du Vésuve, il laisse derrière lui une oeuvre encyclopédique, en trente-sept tomes, qui compile la somme des connaissances philosophiques, scientifiques, et culturelles qu il a pu recueillir de son vivant."),

("Hermolao Barbaro", "Vénitien", "21 Mai 1454", "14 Juin 1493", "professeur", 1, "(1453-1493) : Il est né à Venise, et commence ses études à Vérone où ses talents de poète sont reconnus dès 1468. Il est gradué en Art et en Droit Canon à Padoue. Il commence une carrière politique au service du Sénat de Venise dès 1483, puis à Rome auprès du Pape. Il meurt de la peste en 1493. Le succès de son œuvre notamment philosophique et scientifique est dû à son attention pour la qualité des sources grecques et latines qu il utilise. Il publie plusieurs œuvres d Aristote comme la Politique et une paraphrase de son Ethique. Pour les œuvres scientifiques, il est connu pour la publication des Castigationes Plinianae, à Rome entre 1492 et 1493 par Eucharius
Silber et considérées comme un ouvrage philologique de qualité. Quelques œuvres sont publiées après sa mort notamment des Dioscuridem corollarii en 1510 et un Compendium scientiae naturalis en 1545."),

("Théophraste", "Grec", "371 avant J-C", "288 avant J-C", "philosophe", 1, "Philosophe grec disciple d Aristote, il est né en 372-371 avant Jésus-Christ sur l île de Lesbos. Sa vie est connue par Diogène Laërce. Il reçoit une éducation soignée et rejoint, dès 354, Athènes où il suit l enseignement de Platon avec Aristote. Il suit ce dernier dans ses pérégrinations en Troade notamment et dans d autres lieux de la Grèce où ils font des observations botaniques et zoologiques. En 335, Théophraste assiste Aristote dans l ouverture du Lycée et prend la tête de l école lorsqu Aristote est chassé d Athènes. D après Diogènes, il meurt à 85 ans. Ces deux ouvrages les plus connus sont l Historia plantarum, qui traite de l aspect des végétaux et de leurs usages, ainsi que le De causis plantarum qui porte sur les questions de physiologie des plantes. Pour leur réalisation, il a lui même étudié et observé la nature, puis lorsqu il revient à Athènes avec Aristote, il envoie pour lui des émissaires et des observateurs."),

("Nicolao Léoniceno", "Italien", "1428", "1524", "professeur", NULL, "(1428-1524), il est issu du milieu intellectuel de Padoue où il suit une formation de latin-grec, puis de philosophie et médecine, il est gradué en 1453. Après dix ans sans informations à son sujet, les sources le mentionnent à nouveau, à l université de Ferrare, où il enseigne les mathématiques, la philosophie grecque et la médecine , essentiellement galénique mais vue par le prisme des traductions des textes de médecine arabe. Il est l un des premiers à s atteler aux tâches de retraductions et d éditions des textes galéniques, à partir des sources grecques, et développe pour ce faire une méthode philologique qui lui permet de publier des textes latins de meilleure qualité : en 1509 il publie les œuvres de Galien, avec traduction. Il s intéresse aussi dès les années 1490 à la question de la pertinence de l’œuvre de Pline l Ancien, qu il accuse dans sa correspondance avec Ange Politien d avoir confondu des termes et fait des erreurs d identification. En 1492, il publie un tract, De plinii et aliorum in medicina erroribus. Cette parution entraîne une réponse d Hermolao Barbaro, mais surtout une controverse avec Pandolfo Collenuccio par différents tracts jusqu en 1507."),

("Pandolfo Collenucio", "Italien", "Premier janvier 1444", "11 Juillet 1504", "juriste", 1, "Il est avocat et médecin à Florence. Il est chargé par l humaniste de cour, Ange Politien de défendre l œuvre de Pline face aux critiques de Leoniceno. En effet, Pandolfo Collenuccio reproche à Leoniceno de privilégier les manuscrits grecs en abandonnant complètement les sources latines."),

("Marcellus Vergilius Adriani", "Florentin", "1464", "1521", "humaniste", 1, "Elève de Machiavel, il a enseigné la rhétorique et l art poétique à Florence. Il est connu pour ses traductions de textes grecs, notamment l oeuvre de Dioscoride."),

("Serapion", "Arabe", "XIIème siècle", NULL, "médecin", NULL, "Médecin arabe dont la vie n’est pas connue, son œuvre est traduite au XIII° siècle, et circule notamment sous le titre Liber Serapionis Aggregatus in Medicinis Simplicibus ou Serapionis Aggregatoris de Simplicibus Comentarii."),

("Claude Galien", "Pergame", "129-131 après J-C", "216 après J-C", "médecin", 1, "Médecin et philosophe, né à Pergame. Il apprend la médecine hippocratique (qu il commente beaucoup dans ses ouvrages) ainsi que d autres enseignements lors de ses voyages dans le bassin méditerranéen comme la chirurgie à Alexandrie. Il voyage aussi à Smyrne, Corinthe, et à Rome, où il fait deux séjours, la première fois en tant que philosophe, en 162, puis à la demande de Marc Aurèle en tant que médecin officiel. Le lieu et la date exacte de sa mort sont inconnus. En médecine, Galien est surtout connu pour sa théorie sur les quatre humeurs qui équilibrent le corps. Ses écrits dans le domaine de la pharmacopée sont des compilations de travaux de médecins auxquels il apporte ses propres observations sur d autres remèdes. Il a accès à la bibliothèque impériale de Rome, tandis que ses voyages lui permettent de découvrir plusieurs traditions thérapeutiques, comme les remèdes tirés des sources crétoises. Il cherche à systématiser l usage des remèdes en fonction de leur efficacité face à la gravité des maladies correspondantes. Si cette recherche n aboutit pas complètement, sa classification des plantes devient un modèle notamment dans la médecine arabe. Ici, Brunfels parle des Simples de Galien, il peut s agir du traité Facultés des médicaments simples (De Simplicium medicamentorum temperamentis ac facultatibus libri XI), dont les huit premiers livres lors de son premier séjour à Rome, et les trois derniers sous le règne de Septime Sévère."),

("Simon de Gênes", "Gênois", "XIIIème siècle", NULL, "clerc", NULL, "Médecin et chapelain du pape Nicolas IV puis diacre de Boniface VIII, il connaît quelques rudiments de grec et d arabe. Il entreprend en collaboration avec le savant juif Abraham ben Sem Tob des travaux de traduction : un Synonymes ou Clef de guérison, glossaire de 6 000 termes médicaux en ordre alphabétique avec une définition pour chacun et une recherche de termes équivalents pour les langues grecque et latine. C est un traité technique, destiné aux médecins et qui ne connaît de vulgarisation, mais à la fin du Moyen Âge, il est considéré comme « le guide de tout médecin en matière de vocabulaire »(p 164).  (Jacquart et Micheau, La médecine arabe)"),

("Aemilius Macer", "Italien", "Ier siècle avant J-C", "16 avant J-C", "poète", 1, "Originaire de Vérone, Aemilieu Macer est un poète didactique du premier siècle avant Jésus-Christ. Proche d Ovide qui le mentionne notamment dans ses epistulae ex Ponto. Il a beaucoup emprunté à Nicandre de Colophon, poète diacritique du III° ou du II° siècle avant Jésus-Christ. Macer est connu notamment pour une Ornithogonia, dans laquelle des hommes sont transformés en oiseaux."),

("Pseudo-Apulée", "Italien", "IVème siècle après J-C", NULL, NULL, NULL, "Auteur dont la vie est inconnue, et qui cherche dans son texte à se faire passer pour Apulée de Madaure, le poère et philosophe romain.");

INSERT INTO Oeuvre(oeuvre_titre_original, oeuvre_autre_titre, oeuvre_date, oeuvre_auteur_fk) VALUES
("Περὶ ὕλης ἰατρικῆς", "De materia medica", NULL, 1),
("Naturalis historia", NULL, NULL, 2),
("Castigationes Pliniae", NULL, NULL, 3),
("Pliniana defensio Pandulphi Collenucii, adversus Nicolai Leoniceni accusationem", NULL, "1493", 6),
("Περὶ Φυτῶν Ιστορίας", NULL, "à partir de 314 avant J-C", 4),
("Pedacii Dioscoridae Anazarbei de medica materia libri V. De letalibus venenis eorumque praecautione et curatione. De cane rabido: deque notis quae morsus, ictusve animalium venenum relinquentium sequuntur, deque eorum curatione, interprete Marcello Vergilio. Ejusdem Marcelli Vergilii in hosce Dioscoridis libros commentarii doctissimi", NULL, "1529", 7),
("Kitâb al-Adwiyah al-Mufradah", "Liber Serapionis Aggregatus in Medicinis Simplicibus", NULL, 8),
("De simplicium medicamentorum temperamentis ac facultatibus libri", NULL, NULL, 9),
("De viribus herbarum", "De viris herbarum", NULL, 11),
("Herbarium Apuleii Platonici", NULL, NULL, 12);

INSERT INTO Plante(plante_latin, plante_fran, plante_rhapsodie, plante_texte) VALUES
("Narcissus", "Narcisse", 20, 1),
("Urtica", "Ortie", 24, 2),
("Personatia", "Bardane", 4, 3);

INSERT INTO Citation(citation_auteur_id, citation_plante_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(7,1),
(1,2),
(2,2),
(3,2),
(7,2),
(8,2),
(11,2),
(1,3),
(2,3),
(3,3),
(7,3),
(5,3),
(6,3),
(10,3),
(9,3),
(12,3);
