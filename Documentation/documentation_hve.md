# Présentation de l'application

## Projet

Le but de cette application est la mise en valeur de l'ouvrage des *Herbarum Vivae Eicones* d'Otto Brunfels, ouvrage de botanique parut à partir de 1530. 
Le site propose à l'utilisateur de cheminer de façon interactive dans l'ouvrage afin d'en découvrir l'histoire, la biographie de l'auteur, mais aussi la composition. 
Ainsi sont recencés les auteurs cité dans l'ouvrage. Pour chacun d'entre eux, un lien donne accès à sa biographie et des informations générales sur la bibliographie, ainsi qu'un lien vers les passages cités dans l'ouvrage. 
Les notices botaniques sont accessible par plantes. 
L'accès aux biographies des sources et aux images des plantes sont libres. 
En revanche, l'accès au texte est conditionné par une inscription préalable. 

## Mise en oeuvre

L'application repose sur deux blocs de données : 

### Une base de donnée

Une base de données, contenant les informations requêtées pour remplir les différentes notices d'informations au sujet des entités auteurs et plantes. 
La base contient cinq entités, reliées entre elles selon les modalités décrites dans le mcd et le mrd. 
Cette base a été crée via DB Browser et est requêtée via la librairie SQLalquemy.

### Des ressources textuelles

Les textes sont contenus dans un fichier .xml, parsé par l'une ou l'autre des deux feuilles de traitement .xslt. 


## Installation

Pour installer l'application, téléchargez le repository GitHub, créez un environnement virtuel python muni des dépendances et librairies décrites dans le fichier requirement.txt. Lancez le fichier run.py. 

## Organisation des fichiers

Documentation/
	documentation_hve.md
	MCD.svg
	MRD.mwb

HVE/
	__init__.py
	app.py
	constantes.py
	routes.py
	modeles/
		__init__.py
		donnees.py
		utilisateur.py
	static/
		css/
		img/
		texte/
	templates/
		conteneur.html
		pages/
		partials/

run.py
path.py
requirement.txt
HVE.sql
db.sqlite


