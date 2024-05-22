# SoigneMoiMobile

SoigneMoi est une application web destinée à améliorer l'efficacité de l'accueil des patients et la gestion des plannings des praticiens dans l'hôpital SoigneMoi de la région lilloise.

## Table des matières

- [Aperçu](#aperçu)
- [Prérequis](#prérequis)
- [Installation](#installation)


## Aperçu

L'application SoigneMoi permet aux utilisateurs (docteur) de :
- Visuel des rendez-vous du jour.
- Créer des presciptions.
- Créer des avis.
- Visualiser l'historique médical des patients.

## Prérequis

Avant de commencer, assurez-vous d'avoir lancer le backend et avoir suivi les instructions:
https://github.com/VincePaulin/SoigneMoiBackend

Vous devez aussi avoir installé Flutter.



## Installation

1. Clonez le dépôt GitHub :

    ```bash
    git clone https://github.com/VincePaulin/SoigneMoiMobile.git
    cd SoigneMoiMobile
    ```

2. Lancer l'application en mode debug

   ```bash
    flutter run
    ```

Si vous testez l'application en mode debug sur un appareil physique, veuillez lier l'host à votre réseau wi-fi

   ```bash
    adb reverse tcp:8000 tcp:8000
   ```

### Explication de la Stack Technique

- **Framework :** L'application est développée en Flutter, un framework open-source créé par Google pour le développement d'applications nativement compilées pour mobile, web et desktop à partir d'une seule base de code.
- **Langage :** Dart, le langage de programmation utilisé par Flutter.
- **API REST :** L'application mobile communique avec le back-end de l'application web via des appels API RESTful. Cela permet de récupérer et d'envoyer des données entre le client mobile et le serveur.
- **Gestion des dépendances :** Les dépendances du projet sont gérées via le fichier `pubspec.yaml`.
- **Base de données locale :** SQLite est utilisé pour le stockage local si nécessaire, permettant à l'application de fonctionner hors ligne et de synchroniser les données lorsque la connexion est rétablie.
