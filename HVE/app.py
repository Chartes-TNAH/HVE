# Importation des librairies
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
import os

# Importation des objets
from .constantes import SECRET_KEY

# Définition des chemins
chemin_actuel = os.path.dirname(os.path.abspath(__file__))
templates = os.path.join(chemin_actuel, "templates")
static = os.path.join(chemin_actuel, "static")

# Initialisation de l'objet app
app = Flask(
    "Application",
    template_folder=templates,
    static_folder=static
)

# Configuration de la base de données
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///./db.sqlite'
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

# Initialisation de l'objet db
db = SQLAlchemy(app)

# Configuration de la clef
app.config['SECRET_KEY'] = SECRET_KEY

# Initialisation de l'objet login
login = LoginManager(app)

# Importation de la route principale
from .routes import accueil