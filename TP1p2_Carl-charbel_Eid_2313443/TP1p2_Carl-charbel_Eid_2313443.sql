-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom:  Carl-Charbel Eid                       Votre DA: 2313443
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2

Desc outils_emprunt;
Desc outils_outil;
Desc outils_usager;

-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2

select concat(prenom , ' ' , nom_famille) "Prenom  Nom de Famille"
from outils_usager;


-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2

select distinct ville "ville"
from outils_usager
order by ville asc;


-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2

 Select code_outil "Code de l'outil" , nom "nom"
 from outils_outil
 order by nom, code_outil;

-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2

select num_emprunt "numero d'emprunt"
from outils_emprunt
where date_retour is null;

-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./3

select num_emprunt "numero d'emprunt", date_emprunt "date d'emprunt"
from outils_emprunt
where date_emprunt < '01-Jan-14' ;

-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3

select nom "nom de l'outil", code_outil "code d'outil" , caracteristiques "caracterisques"
from outils_outil
where upper(caracteristiques) like ( '%J%' ) ;

-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2

select nom "nom de l'outil", code_outil "code d'outil" , fabricant "fabriquant"
from outils_outil
where upper(fabricant) like 'STANLEY';

-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2

select nom "nom de l'outil", code_outil "code d'outil" , fabricant "fabriquant", annee "annee"
from outils_outil
where annee between 2006 and 2008;

-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3
select nom "nom de l'outil", code_outil "code d'outil" , caracteristiques "caracteristiques"
from outils_outil
where caracteristiques not like ( '%20 volt%');

-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2

select nom "nom de l'outil", code_outil "code d'outil" , fabricant "fabriquant"
from outils_outil
where fabricant not like ( 'Makita');

-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5

select concat(prenom, ' ', u.nom_famille) "Nom complet",
u.num_usager "Numero d'usager",
e.num_emprunt "Numero d'emprunt",
o.prix "Prix" ,
e.date_emprunt "Date d'emprunt",
e.date_retour "Date de retour",
u.ville "Ville"
from outils_usager u
inner join outils_emprunt e 
on u.num_usager = e.num_usager
inner join outils_outil o 
on e.code_outil = o.code_outil
where date_retour is not null and PRIX is not null and ville in('Vancouver');

-- 13.  Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4

select concat(u.prenom, ' ', u.nom_famille) "Nom complet",
e.code_outil "Code d'outil",
e.date_emprunt "Date d'emprunt",
e.date_retour "Date de retour"
from outils_usager u
inner join outils_emprunt e 
on u.num_usager = e.num_usager
where date_retour is null ;

-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3

select distinct concat (u.prenom, ' ', u.nom_famille) "Nom complet", u.courriel
from outils_usager u
left join outils_emprunt e
on u.num_usager = e.num_usager
where u.num_usager not in (select num_usager
from outils_emprunt);
 
-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4

select distinct o.code_outil, o.prix
from outils_outil o
left outer join outils_emprunt e
on o.code_outil=e.code_outil
where o.code_outil not in(select code_outil from outils_emprunt) and prix is not null;

-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4

select o.nom ,o.prix
from outils_outil o
group by nom,prix,fabricant
having upper(fabricant) like 'MAKITA' and prix>(select avg(NVL(prix, avg(prix)))
from outils_outil o
group by o.prix);

-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4

select u.nom_famille "Nom de famille", u.prenom "Prenom" , u.adresse "Addresse", o.code_outil "Code de l'outil", o.nom "Nom de l'outil"
from outils_usager u
join outils_emprunt e
on u.num_usager=e.num_usager
join outils_outil o
on e.code_outil=o.code_outil
where e.date_emprunt>'31-DEC-14'
order by u.nom_famille;

-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4

select o.nom "Nom de l'outil", o.prix "Prix"
from outils_outil o
join outils_emprunt e
on o.code_outil=e.code_outil
group by e.code_outil,o.nom,o.prix
having count (e.code_outil)>=2;

-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

--  Une jointure

select distinct concat(prenom, ' ',nom_famille) "Nom complet", adresse "addresse" , ville "Ville"
from outils_usager u
inner join outils_emprunt e
on u.num_usager=e.num_usager;

--  IN

select concat(prenom, ' ',nom_famille) "Nom complet", adresse "addresse" , ville "Ville"
from outils_usager u
where u.num_usager in(select e.num_usager from outils_emprunt e);

--  EXISTS

select concat(prenom, ' ',nom_famille) "Nom complet", adresse "addresse" , ville "Ville"
from outils_usager u
where exists(select e.num_usager from outils_emprunt e where e.num_usager=u.num_usager);

-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3

select fabricant "Marque", AVG(prix) "Moyenne des prix"
from outils_outil
group by fabricant;

-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4

select ville,sum(o.prix) "Somme des prix"
from outils_outil o
join outils_emprunt e
on o.code_outil = e.code_outil
join outils_usager u
on e.num_usager=u.num_usager
group by u.ville
order by sum(o.prix) desc;

-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2

insert into OUTILS_OUTIL (CODE_OUTIL , NOM , FABRICANT , CARACTERISTIQUES ,ANNEE , PRIX)
values('De890','Scie','Dewalt','2 pieds et leger','2020','575');

-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2

insert into outils_outil (code_outil,nom,annee)
values('MW302','Souffleur à dos','2020');


-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2

delete from outils_outil where annee=2020;

-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2

update outils_usager
set nom_famille=upper(nom_famille);