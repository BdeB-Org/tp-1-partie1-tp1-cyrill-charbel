-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom: Cyrill Olano                        Votre DA: 2389891
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
DESC OUTILS_OUTIL;
DESC OUTILS_EMPRUNT;
DESC OUTILS_USAGER;

-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
SELECT CONCAT(PRENOM, ' ' , NOM_FAMILLE) AS "Nom complet"
    FROM outils_usager;

-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2
SELECT DISTINCT VILLE as "ville"
    FROM outils_usager
    ORDER BY VILLE ASC;

-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
SELECT CODE_OUTIL AS "Code", NOM AS "Nom", FABRICANT AS "Fabricant", CARACTERISTIQUES AS "Caracteristiques",ANNEE as "Année", PRIX as "Prix"
    FROM outils_outil
    ORDER BY NOM ASC, CODE_OUTIL ASC;

-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2
SELECT NUM_EMPRUNT as "Numéro d'emprunt"
FROM outils_emprunt
    WHERE DATE_RETOUR IS null;

-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./3
SELECT NUM_EMPRUNT as "Numéro d'emprunt"
    FROM outils_emprunt
    WHERE date_emprunt < '2014-01-01';

-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3
SELECT CODE_OUTIL AS "Code outil",  NOM AS "nom"
    FROM OUTILS_OUTIL
    WHERE UPPER(CARACTERISTIQUES) LIKE '%J%';

-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
SELECT NOM AS "Nom", CODE_OUTIL AS "Code"
    FROM outils_outil
    WHERE FABRICANT = 'Stanley';

-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2
SELECT NOM AS "Nom", FABRICANT AS "Fabricant"
    FROM outils_outil
    WHERE ANNEE BETWEEN 2006 AND 2008;

-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3
SELECT NOM AS "Nom", CODE_OUTIL AS "Code"
    FROM OUTILS_OUTIL
    WHERE CARACTERISTIQUES <> '20 volt';

-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2
SELECT COUNT(*) AS "Nombre d'outils pas fabriqués par Makita"
    FROM outils_outil
    WHERE FABRICANT != 'Makita';

-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5
SELECT CONCAT(c.PRENOM, ' ' , c.NOM_FAMILLE) AS "Nom complet", 
            b.NUM_EMPRUNT AS "Numéro d'emprunt",
            b.DATE_RETOUR AS "Date de retour", 
            b.DATE_EMPRUNT AS "Date d'emprunt",
            ROUND(nvl(a.PRIX, 0), 2) AS "Prix"
FROM outils_emprunt b
INNER JOIN outils_usager c ON b.NUM_USAGER = c.NUM_USAGER
INNER JOIN outils_outil a ON b.CODE_OUTIL = a.CODE_OUTIL
WHERE c.VILLE IN ('Vancouver' , 'Regina')
    AND b.DATE_RETOUR IS NOT NULL
    AND a.PRIX IS NOT NULL;

-- 13.  Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4
SELECT a.NOM as "Nom", b.CODE_OUTIL as "Code d'outil"
FROM OUTILS_EMPRUNT B
    INNER JOIN outils_outil a ON b.CODE_OUTIL = a.CODE_OUTIL
    WHERE b.DATE_RETOUR IS NULL;

-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3
SELECT PRENOM AS "prenom", COURRIEL AS "Courriel"
FROM OUTILS_USAGER
    WHERE NUM_USAGER NOT IN (SELECT DISTINCT NUM_USAGER FROM OUTILS_EMPRUNT);
-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4
SELECT a.CODE_OUTIL AS "Code d'outil" , a.PRIX AS "Prix"
FROM OUTILS_OUTIL a
LEFT OUTER JOIN OUTILS_EMPRUNT b ON a.CODE_OUTIL = b.CODE_OUTIL
    WHERE b.CODE_OUTIL IS NULL
    AND a.PRIX IS NOT NULL;
-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
SELECT NOM as "Nom", PRIX AS "Prix"
FROM outils_outil
WHERE FABRICANT = 'Makita'
AND PRIX > (SELECT AVG(PRIX) FROM outils_outil);

-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4
SELECT c.PRENOM as "Prenom", 
        c.NOM_FAMILLE as "Nom de Famille", 
        c.ADRESSE as "Adresse", 
        a.NOM as "Nom d'outil",
        a.CODE_OUTIL as "Code d'outil"
FROM outils_usager c
INNER JOIN OUTILS_EMPRUNT b ON c.NUM_USAGER = b.NUM_USAGER
INNER JOIN OUTILS_OUTIL a ON b.CODE_OUTIL = a.CODE_OUTIL
    WHERE (b.DATE_EMPRUNT) > '14-01-01'
    ORDER BY c.NOM_FAMILLE;

-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4
SELECT a.NOM AS "Nom", a.PRIX AS "Prix"
FROM outils_outil a
INNER JOIN OUTILS_EMPRUNT b ON a.CODE_OUTIL = b.CODE_OUTIL
    GROUP BY a.NOM, a.PRIX
    HAVING COUNT(b.NUM_EMPRUNT) > 1;
-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

--  Une jointure
SELECT c.NOM_FAMILLE AS "Nom de famille", 
        c.ADRESSE AS "Adresse", 
        c.VILLE AS "Ville"
FROM OUTILS_USAGER c
INNER JOIN outils_emprunt b ON c.NUM_USAGER = b.NUM_USAGER;

--  IN
SELECT CONCAT(PRENOM, ' ' , NOM_FAMILLE) AS "Nom complet",ADRESSE AS "Adresse", VILLE AS "Ville"
FROM OUTILS_USAGER
    WHERE NUM_USAGER IN (SELECT NUM_USAGER FROM OUTILS_EMPRUNT);
--  EXISTS
SELECT CONCAT(PRENOM, ' ' , NOM_FAMILLE) AS "Nom complet",ADRESSE AS "Adresse", VILLE AS "Ville"
FROM OUTILS_USAGER C
    WHERE EXISTS (SELECT 1 FROM OUTILS_EMPRUNT b WHERE b.NUM_USAGER = c.NUM_USAGER);

-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3
SELECT FABRICANT AS "Marque", ROUND(AVG(PRIX), 2) AS "Moyenne du prix"
FROM OUTILS_OUTIL
    GROUP BY FABRICANT;

-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4
SELECT c.VILLE AS "Ville", SUM(a.PRIX) AS "Somme"
FROM OUTILS_USAGER c
INNER JOIN OUTILS_EMPRUNT b ON c.NUM_USAGER = b.NUM_USAGER
INNER JOIN OUTILS_OUTIL a ON b.CODE_OUTIL =a.CODE_OUTIL
    GROUP BY c.VILLE
    ORDER BY 'Somme' DESC;
-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO OUTILS_OUTIL (CODE_OUTIL , NOM , FABRICANT , CARACTERISTIQUES ,ANNEE , PRIX)
VALUES ('MS789', ' Couteau ', ' Honda ' , ' 20 once ' , 2010, 99);

-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2
INSERT INTO OUTILS_OUTIL (CODE_OUTIL, NOM, ANNEE)
VALUES('DG533' , 'SAGES' , 2005);

-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2
DELETE FROM OUTILS_OUTIL
WHERE CODE_OUTIL IN ('MS789', 'DG533');

-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2
UPDATE OUTILS_USAGER
SET NOM_FAMILLE = UPPER(NOM_FAMILLE);

