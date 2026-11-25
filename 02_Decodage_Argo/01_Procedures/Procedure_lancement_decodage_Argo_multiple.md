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

## 3. Organisation locale des répertoires

Les deux répertoires téléchargés/récupérés sont regroupés sous une même
racine de travail :

``` text
C:\Coriolis_Argo_multiple\
│
├── decArgo_20250516_076a\
│   ├── decArgo_config_floats\
│   ├── decArgo_doc\
│   └── decArgo_soft\
│
├── decArgo_demo\
│   ├── config\
│   ├── input\
│   └── output\
│
├── Run_Argo_chain_multiple_vio.m
├── Control_Argo_chain_multiple_vio.m
└── 120353.7z
```

## 4. Adaptation des fichiers pour le lancement local

Le répertoire de démonstration d'origine est prévu pour l'environnement
conteneurisé. Pour l'utiliser avec le code MATLAB local, deux fichiers
ont été adaptés :

1.  `start_decode.m`, pour indiquer où se trouvent le code source et le
    fichier de configuration sur le poste Windows ;
2.  `decoder_conf.json`, pour indiquer les chemins locaux des données
    d'entrée et des répertoires de sortie.

## 5. Modification du fichier `decoder_conf.json`

**Chemins d'entrée**

Les chemins suivants ont été configurés pour pointer vers les
répertoires locaux :

| Paramètre | Chemin configuré |
|---|---|
| `DIR_INPUT_JSON_FLOAT_DECODING_PARAMETERS_FILE` | `C:/Coriolis_Argo_multiple/decArgo_demo/config/decArgo_config_floats/json_float_info/` |
| `DIR_INPUT_RSYNC_DATA` | `C:/Coriolis_Argo_multiple/decArgo_demo/input/archive/cycle/` |
| `DIR_INPUT_RSYNC_LOG` | `C:/Coriolis_Argo_multiple/decArgo_demo/input/rsync_list/` |
| `DIR_INPUT_JSON_FLOAT_META_DATA_FILE` | `C:/Coriolis_Argo_multiple/decArgo_demo/config/decArgo_config_floats/json_float_meta_ir_sbd/` |
| `DIR_INPUT_JSON_TECH_LABEL_FILE` | `C:/Coriolis_Argo_multiple/decArgo_20250516_076a/decArgo_soft/config/_techParamNames/` |
| `DIR_INPUT_JSON_CONF_LABEL_FILE` | `C:/Coriolis_Argo_multiple/decArgo_20250516_076a/decArgo_soft/config/_configParamNames/` |

**Chemins de sortie**

Les répertoires de sortie sont configurés comme suit :

| Paramètre | Chemin configuré |
|---|---|
| `DIR_OUTPUT_LOG_FILE` | `C:/Coriolis_Argo_multiple/decArgo_demo/output/log/` |
| `DIR_OUTPUT_CSV_FILE` | `C:/Coriolis_Argo_multiple/decArgo_demo/output/csv/` |
| `DIR_OUTPUT_XML_FILE` | `C:/Coriolis_Argo_multiple/decArgo_demo/output/xml/` |
| `DIR_OUTPUT_NETCDF_FILE` | `C:/Coriolis_Argo_multiple/decArgo_demo/output/nc/` |
| `DIR_OUTPUT_NETCDF_TRAJ_3_1_FILE` | `C:/Coriolis_Argo_multiple/decArgo_demo/output/nc/` |
| `DIR_OUTPUT_NETCDF_TRAJ_3_2_FILE` | `C:/Coriolis_Argo_multiple/decArgo_demo/output/nc/` |


**On conserve bien "FLOAT_TRANSMISSION_TYPE" : "3" ; qui correspond au type de transmission des flotteurs en cours de décodage**
NB : 
- FLOAT_TRANSMISSION_TYPE" : "1"  ==> transmission de type Argos
- FLOAT_TRANSMISSION_TYPE" : "2"  ==> transmission de type Iridium Rudics
- FLOAT_TRANSMISSION_TYPE" : "3"  ==> transmission de type Iridium SBD classique
- FLOAT_TRANSMISSION_TYPE" : "4"  ==> transmission de type Iridium SBD bio
 

## 6. Modification du script `start_decode.m`

Le script utilisé est celui du code source MATLAB :

``` text
C:/Coriolis_Argo_multiple/decArgo_20250516_076a/decArgo_soft/soft/util/start_decode.m
```

### 6.1. Modifier les identifiants des flotteurs a décoder (les WMO) :
``` matlab
wmoList = [ ...
   6902892 ...
   6903014 ...
```


### 6.2. Modifier le chemin du fichier de configuration local explicitement :
``` matlab
configFile = 'C:/Coriolis_Argo_multiple/decArgo_demo/config/decoder_conf.json';
```


### 6.3. Adapter le nombre de flotteurs à décoder pour avoir une meilleure estimation du temps restant au décodage**
``` matlab
nbFloats = 2;
``` 


### 6.4. Remplacer le chemin du code MATLAB du décodeur**
``` matlab
   cmd = ['matlab -nodesktop -nosplash -r "decode_argo_2_nc_rt(''rsynclog'', ''all'', ''configfile'', ''' configFile ''', ''floatwmo'', ''' floatNumStr ''');exit"'];
```


par 


``` matlab
   softPath = 'C:/Coriolis_Argo_multiple/decArgo_20250516_076a/decArgo_soft/soft';
   cmd = ['matlab -nodesktop -nosplash -r "addpath(genpath(''' softPath ''')); decode_argo_2_nc_rt(''rsynclog'', ''all'', ''configfile'', ''' configFile ''', ''floatwmo'', ''' floatNumStr ''');exit"'];

```

nb: Le script ajoute le répertoire `soft` et tous ses sous-répertoires au chemin MATLAB
Il lance ensuite une seconde instance de MATLAB, sans interface
graphique, pour exécuter la fonction `decode_argo_2_nc_rt`.


## 7. Création des répertoires de sortie

Le répertoire `C:\Coriolis_Argo_multiple\decArgo_demo\output` reçoit les résultats du traitement.
Les répertoires csv , nc ,log, xml et iridium ont été créés manuellement lors de la préparation de l'environnement local.

## 8. Lancement du décodage

Ouvrir `Run_Argo_chain_vio.m`
qui lance en seconde instance `Control_Argo_chain.m`

| Code Matlab | Description |
|---|---|
| `Run_Argo_chain_vio.m` | Ce code ajoute le chemin vers la fonction `start_decode.m` qui a été modifiée précédemment (cf paragraphe 6). <br><br> Puis il lance la fonction `start_decode.m`, et enfin il lance à la fin le Control_Argo_chain_vio.m |
| `Control_Argo_chain_vio.m` | Ce code permet de réaliser une figure par flotteur décodé. <br><br> La figure contient tous les profils verticaux de température et de salinité qui ont été décodés|








