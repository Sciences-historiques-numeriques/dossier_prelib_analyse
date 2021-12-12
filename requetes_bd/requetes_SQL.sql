/*
*  Requêtes à effectuer sur la base de données en ligne
*/

-- Chercher les oeuvres avec leur édition
select
	po.id,
	po.titre,
	po.descriptif,
	oe.id,
	pe.titre,
	pe.annee_publication
from
	prelib_oeuvre po
join prelib_oeuvreedition oe on
	oe.oeuvre_id = po.id
join prelib_edition pe on
	pe.id = oe.edition_id
order by
	po.id
limit  101

/*
*  La requête qui est à l'origine de la table "oeuvres_editions"
*  dans la base de données SQLite (données importées successivement, 
*  limit 1000 dans le résultat imposé par le serveur)
*/

select
po.id,
po.titre,
oe.id id_ed,
pe.annee_publication,
pp.id id_personne,
pp.nom_usuel,
pp.annee_naissance,
pp.annee_deces,
group_concat(feo.nom) fonctions,
group_concat(pto.intitule) types,
group_concat(plg.nom) langues
from
prelib_oeuvre po
join prelib_oeuvreedition oe on oe.oeuvre_id = po.id
join prelib_edition pe on pe.id = oe.edition_id
left join prelib_ecritoeuvre eco on eco.oeuvre_id = po.id
left join prelib_personne pp on pp.id = eco.personne_id
left join prelib_fonctionecritoeuvre feo on feo.id = eco.fonction_id
left join prelib_oeuvre_types pot on pot.oeuvre_id = oe.id
left join prelib_typeoeuvre pto on pto.id = pot.typeoeuvre_id
left join prelib_oeuvre_langue ovla on ovla.oeuvre_id = oe.id
left join prelib_langue plg on plg.id = ovla.langue_id
where pe.annee_publication > 0
group by
po.id,
po.titre,
oe.id,
pe.annee_publication,
pp.id,
pp.nom_usuel,
pp.annee_naissance,
pp.annee_deces
order by
po.id


-- Personnnes analysées dans l'article:

select
  id,sexe,nom_usuel,nom_etat_civil,prenom_etat_civil,particule_noblesse,jour_naissance,mois_naissance, annee_naissance,wikidata,	idref
from
  prelib_personne
where
  (nom_etat_civil IN (
    'Sévéno',
    'Le Bayon',
    'Madec',
    'Berthou',
    'Jaffrennou',
    'Carné',
    'Drezen',
    'Uguen',
    'Jézégou',
    'Gourvil',
    'Vallée',
    'Picart',
    'Herrieu',
    'Le Goff',
    'Ernault',
    'Perrot',
    'Riou',
    'Le Moal',
    'Herrieu',
    'Clisson',
    'Heno'
  ) OR id IN (338, 42) OR nom_usuel LIKE '%Drezen%' OR nom_usuel LIKE '%Héno%'OR nom_etat_civil LIKE '%Hemo%'
  OR nom_usuel LIKE '%Hemo%' OR nom_etat_civil LIKE '%Herrieu%' OR nom_usuel LIKE '%Herrieu%'
  OR nom_etat_civil LIKE '%Gourvil%' OR nom_usuel LIKE '%Gourvil%' )
   AND id not in (364, 1031, 651, 790, 1248, 1473, 555, 620, 191, 991, 1064, 908, 104, 249, 487, 525, 1285, 1286, 1287)

order by nom_etat_civil
