
# Importation des librairies et des packages

from flask import render_template, request, redirect, flash, url_for
import lxml.html
from lxml import etree
from flask_login import login_user, current_user, logout_user

# Importation des objets

from .app import app, login
from .modeles.donnees import Auteur, Oeuvre, Plante, Citation
from .modeles.utilisateur import User

# Définition des routes

@app.route("/")
def accueil():
    """ Route permettant l'accès à la page d'accueil
    : returns : page d'accueil
    :rtype : page html
    """
    return render_template("pages/accueil.html")

@app.route("/a_propos/biographie")
def biographie():
    """ Route permettant l'accès à la page d'information sur l'auteur de l'oeuvre
    : returns : page d'information biographique
    :rtype : page html
    """
    return render_template("pages/biographie.html")

@app.route("/a_propos/ouvrage")
def ouvrage():
    """ Route permettant l'accès à la page d'information sur l'oeuvre
    : returns : page d'information 
    :rtype : page html
    """
    return render_template("pages/presentation_ouvrage.html")

@app.route("/galerie_plantes")
def galerie_plantes():
    """ Route permettant l'accès à une galerie de toutes les plantes disponibles dans la base de données
    :returns : page de la galerie des plantes
    :rtype : page html
    """
    vegetal = Plante.query.order_by(Plante.plante_rhapsodie.asc()).all()
    return render_template("pages/galerie_plantes.html", plantes=vegetal)

@app.route("/galerie_auteurs")
def galerie_auteurs():
    """ Route permettant l'accès à une galerie de tous les auteurs disponibles dans la base de données
    :returns : page de la galerie des auteurs
    :rtype : page html
    """
    author = Auteur.query.order_by(Auteur.auteur_nom.asc()).all()
    return render_template("pages/galerie_auteurs.html", auteurs=author)

@app.route("/auteur/<int:auteur_id>")
def auteur(auteur_id):
    """ Route permettant l'accès à la notice biographique d'un auteur
    :param auteur_id : identifiant de l'auteur
    :type : int
    :returns : page de la notice de l'auteur
    :rtype : page html
    """
    author_simple = Auteur.query.get_or_404(auteur_id)
    oeuvres = Oeuvre.query.filter(Oeuvre.oeuvre_auteur_fk == Auteur.auteur_id)
    return render_template("pages/auteur.html", auteurs=author_simple, oeuvres=oeuvres)

@app.route("/plantes/<int:plante_id>")
def plantes(plante_id):
    """ Route permettant l'accès à la notice d'une plante
    :param auteur_id : identifiant de la plante
    :type : int
    :returns : page de la notice de la plante
    :rtype : page html
    """
    vegetal_simple = Plante.query.get_or_404(plante_id)
    return render_template("pages/plantes.html", plante=vegetal_simple)

@app.route("/resultat")
def resultat():
    """ Route permettant l'accès à la page de résultats après une requête
    :returns : page des résultats
    :rtype : page html
    """
    motclef = request.args.get("keyword", None)
    resultats_auteurs = []
    resultats_plantes = []
    titre = "Recherche"
    if motclef:
        resultats_auteurs = Auteur.query.filter(Auteur.auteur_nom.like("%{}%".format(motclef))).all()
        resultats_plantes = Plante.query.filter(Plante.plante_fran.like("%{}%".format(motclef))).all()
        titre = "Résultat pour la recherche '"+motclef+"'"
    return render_template("pages/resultat.html", resultats_auteurs=resultats_auteurs, resultats_plantes=resultats_plantes, titre=titre)

@app.route("/texte/<int:numero>")
def texte(numero):
    """ Route permettant le parsage du texte concernant une plante ainsi que la feuille xslt
    :param numero : identifiant du texte
    :type : int
    :returns : page contenant le résultat du parsage
    :rtype : page html
    """
    xslt_doc = etree.parse("HVE/static/XSLT/texte.xslt")
    xslt_transformer = etree.XSLT(xslt_doc)
    source_doc = etree.parse("HVE/static/XML/texte.xml")
    output_doc = xslt_transformer(source_doc, numero=str(numero))
    return render_template('pages/texte.html', HTML=output_doc, numero=int(numero))

@app.route("/notice/<int:numero>/<int:ident>")
def notice(numero, ident):
    """ Route permettant le parsage et l'affichage d'une partie du texte
    concernant une plante en fonction de son auteur
    :param numero : identifiant du texte
    :type : int
    :param ident : identifiant de l'auteur
    :type : int
    :returns : page contenant le résultat du parsage
    :rtype : page html
    """
    xslt_doc = etree.parse("HVE/static/XSLT/notice.xslt")
    xslt_transformer = etree.XSLT(xslt_doc)
    source_doc = etree.parse("HVE/static/XML/texte.xml")
    output_doc = xslt_transformer(source_doc, numero=str(numero), ident=str(ident))
    return render_template('pages/notice.html', HTML=output_doc, numero=int(numero), ident=int(ident))

@app.route("/register", methods=["GET", "POST"])
def inscription():
    """ Route permettant l'inscription d'un utilisateur
    :returns : redirection vers une page, variable en fonction du résultat de l'opération d'inscription
    :rtype : page html
    """
    if request.method == "POST":
        statut, donnees = User.creer(
            login=request.form.get("login", None),
            email=request.form.get("email", None),
            nom=request.form.get("nom", None),
            motdepasse=request.form.get("motdepasse", None)
        )
        if statut is True:
            flash("Enregistrement effectué. Identifiez-vous maintenant")
            return redirect("/")
        else:
            flash("Les erreurs suivantes ont été rencontrées : " + ",".join(donnees), "error")
            return render_template("pages/inscription.html")
    else:
        return render_template("pages/inscription.html")


@app.route("/connexion", methods=["POST", "GET"])
def connexion():
    """ Route permettant la connexion d'un utilisateur
    :returns : redirection vers une page, variable en fonction du résultat de l'opération de connexion
    :rtype : page html
    """
    if request.method == "POST":
        utilisateur = User.identification(
            login=request.form.get("login", None),
            motdepasse=request.form.get("motdepasse", None)
        )
        if utilisateur:
            login_user(utilisateur)
            flash(" vous êtes maintenent connecté", "info")
            return redirect('/')
        else:
            flash("Les identifiants n'ont pas été reconnus", "warning")
    return render_template("pages/connexion.html")

login.login_view = 'connexion'


@app.route("/deconnexion", methods=["POST", "GET"])
def deconnexion():
    """ Route permettant la déconnexion d'un utilisateur
    :returns : redirection vers la page d'accueil
    :rtype : page html
    """
    if current_user.is_authenticated is True:
        logout_user()
    flash("vous êtes déconnecté", "info")
    return redirect("/")

@app.errorhandler(404)
def page_not_found(error):
    """ Route conduisant à une page d'erreur si la page demandée n'existe pas
    :param error : paramètre par défaut
    :returns : page d'erreur
    :rtype : page html
    """
    return render_template("pages/error.html"), 404
