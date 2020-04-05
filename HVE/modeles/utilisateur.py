# Importation des librairies et packages
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin

# Importation des objets db et login
from .. app import db, login


class User(UserMixin, db.Model):
    user_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True, autoincrement=True)
    user_nom = db.Column(db.Text, nullable=False)
    user_login = db.Column(db.String(45), nullable=False, unique=True)
    user_email = db.Column(db.Text, nullable=False)
    user_password = db.Column(db.String(100), nullable=False)

    # Mise en place des méthodes liées à la classe User

    @staticmethod
    def identification(login, motdepasse):
        """ Identification de l'utilisateur. 
        La fonction, en cas de succès renvoie les données de l'utilisateurs.
        sinon, elle renvoie None

        :param login: Login de l'utilisateur
        :param motdepasse: Mot de passe envoyé par l'utilisateur
        :returns: Si réussite, données de l'utilisateur. Sinon None
        :rtype: User or None
        """
        utilisateur = User.query.filter(User.user_login == login).first()
        if utilisateur and check_password_hash(utilisateur.user_password, motdepasse):
            return utilisateur
        return None

    @staticmethod
    def creer(login, email, nom, motdepasse):
        """ Création d'un compte utilisateur. La fonction retourne un tuple :
        Si il y a une erreur, la fonction renvoie False suivi d'une liste d'erreur
        Sinon, elle renvoie True suivi de la donnée enregistrée

        :param login: Login de l'utilisateur
        :type : string
        :param email: Email de l'utilisateur
        :type : string
        :param nom: Nom de l'utilisateur
        :type : string
        :param motdepasse: Mot de passe de l'utilisateur
        :type : string d'un minimum de 6 caractères
        :returns : renvoie d'un tuple, composé du booléen False et d'une liste d'erreur s'il y a des erreurs
        sinon, la fonction renvoie un tupe, composé du booléen True et d'un objet utilisateur de classe User.
        :rtype : (False, liste) OU BIEN (True, utilisateur)
        """
        erreurs = []
        if not login:
            erreurs.append("Le login fourni est vide")
        if not email:
            erreurs.append("L'email fourni est vide")
        if not nom:
            erreurs.append("Le nom fourni est vide")
        if not motdepasse or len(motdepasse) < 6:
            erreurs.append("Le mot de passe fourni est vide ou trop court")

        uniques = User.query.filter(
            db.or_(User.user_email == email, User.user_login == login)
        ).count()
        if uniques > 0:
            erreurs.append("L'email ou le login sont déjà inscrits dans notre base de données")

        if len(erreurs) > 0:
            return False, erreurs

        utilisateur = User(
            user_nom=nom,
            user_login=login,
            user_email=email,
            user_password=generate_password_hash(motdepasse)
        )

        try:
            db.session.add(utilisateur)
            db.session.commit()
            return True, utilisateur
        except Exception as erreur:
            return False, [str(erreur)]

    def get_id(self):
        """ Retourne l'id de l'objet actuellement utilisé

        :returns: ID de l'utilisateur
        :rtype: int
        """
        return self.user_id


@login.user_loader
def trouver_utilisateur_via_id(identifiant):
    """ recherche une instance utilisateur
    :param identifiant : identifiant de l'utilisateur
    :type : int
    :returns : renvoie une instance utilisateur
    """
    return User.query.get(int(identifiant))
