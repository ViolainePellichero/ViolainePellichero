# Mise en place du décodeur Argo Coriolis sur plusieurs flotteurs

## 1. Objet
La précédente procédure, **Procedure_lancement_decodage_Argo.md**, 
décrit l’installation locale du décodeur Argo Coriolis sous Windows et
sa mise en œuvre pour réaliser une démonstration de décodage sur un flotteur unique.


La présente procédure a pour objectif de décrire l’installation et 
la configuration du décodeur dans le cadre d’un décodage **multiple**, 
permettant de traiter simultanément plusieurs flotteurs Argo.


## 2. Sources des fichiers

### 2.1. Code source MATLAB du décodeur

Le code source du décodeur a été téléchargé depuis SEANOE :

-   Page de téléchargement :
    <https://www.seanoe.org/data/00345/45589/#120353>
-   Identifiant de version téléchargée : `decArgo_20250516_076a`

L'archive téléchargée a été décompressée dans le répertoire :

``` text
C:\Coriolis_Argo\decArgo_20250516_076a\
```

Ce répertoire contient le code MATLAB du décodeur, les fonctions
associées, les fichiers de configuration génériques, les informations
sur les flotteurs et la documentation technique.

Il constitue la **source logicielle de l'installation locale**.

### 2.2. Fichiers de démonstration

Les fichiers de démonstration ne sont pas récupérés dans l'archive
MATLAB téléchargée sur SEANOE. Ils sont disponibles dans le dépôt GitHub
consacré à la version conteneurisée :

<https://github.com/euroargodev/Coriolis-data-processing-chain-for-Argo-floats-container>

Le répertoire `decArgo_demo` de ce dépôt a été récupéré afin de disposer
d'un jeu de données d'exemple pour effectuer les premiers essais.

Dans cette démonstration, on réutilise notamment :

-   les fichiers bruts Iridium, dont les noms commencent par `co_` ;
-   les fichiers journaux RSYNC, dont les noms commencent par `rsync_` ;
-   les fichiers JSON d'information et de métadonnées des flotteurs.

**Important :** le dépôt conteneurisé est utilisé uniquement comme
source de fichiers de démonstration. Docker, Docker Compose, les scripts
de lancement du conteneur et l'environnement MATLAB Runtime conteneurisé
ne sont pas utilisés. Le décodage est exécuté directement avec MATLAB
installé localement.

Le répertoire de démonstration utilisé pour les essais est placé ici :

``` text
C:\Coriolis_Argo\decArgo_demo\
```
