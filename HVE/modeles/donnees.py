# Importation de l'objet db
from .. app import db

# Représentation de la table Auteur
class Auteur(db.Model):
    auteur_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    auteur_nom = db.Column(db.Text)
    auteur_origine = db.Column(db.Text)
    auteur_naissance = db.Column(db.Text)
    auteur_mort = db.Column(db.Text)
    auteur_profession = db.Column(db.Text)
    auteur_image = db.Column(db.Boolean)
    auteur_biographie = db.Column(db.Text)
    citation = db.relationship("Citation", back_populates="auteur")

# Représentation de la table Plante

class Plante(db.Model) :
    plante_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    plante_latin = db.Column(db.Text)
    plante_fran = db.Column(db.Text)
    plante_rhapsodie = db.Column(db.Integer)
    plante_texte = db.Column(db.Integer)
    citation = db.relationship("Citation", back_populates="plante")


# Représentation de la table Oeuvres

class Oeuvre(db.Model) : 
    oeuvre_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    oeuvre_titre_original = db.Column(db.Text)
    oeuvre_autre_titre = db.Column(db.Text)
    oeuvre_date = db.Column(db.Text)
    oeuvre_auteur_fk = db.Column(db.Integer)


# Représentation de la table de relation entre les classes Auteur et Plante
class Citation(db.Model) :
    citation_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    citation_auteur_id = db.Column(db.Integer, db.ForeignKey('auteur.auteur_id'))
    citation_plante_id = db.Column(db.Integer, db.ForeignKey('plante.plante_id'))
    auteur = db.relationship("Auteur", back_populates="citation")
    plante = db.relationship("Plante", back_populates="citation")



