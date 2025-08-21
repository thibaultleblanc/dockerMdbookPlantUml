# README

## Mdbook

Ce conteneur Docker permet de générer et de servir une documentation `mdbook` pour un projet Git. Il inclut également le support pour les diagrammes PlantUML.
La visualisation de la documentation se fait via le navigateur. Pour exporter la documentation en PDF, il suffit de cliquer sur imprimer.

## Setup

### Prérequis

- Docker
- Docker Compose

### Installation

1. Lancez le conteneur :

   ```sh
   docker-compose up
   ```

### Utilisation

Une fois le conteneur lancé, vous pouvez accéder à la documentation générée par `mdbook` en ouvrant votre navigateur et en allant à l'adresse suivante :

```
http://localhost:3000
```

### Structure du projet

- `docker-compose.yml` : Fichier de configuration Docker Compose pour définir les services et les volumes.
- `mdbook.dockerfile` : Dockerfile pour construire l'image Docker avec `mdbook` et PlantUML.
- `book.toml` : Fichier de configuration pour `mdbook`.
- `src/` : Répertoire contenant les fichiers source de la documentation.

### Configuration

Le fichier `book.toml` contient la configuration de `mdbook` et du préprocesseur PlantUML. Assurez-vous que la commande PlantUML est correctement définie :

```toml
[preprocessor.plantuml]
plantuml-cmd="java -jar /usr/local/bin/plantuml.jar"
use-data-uris=true
```

Se référer à la documentation de mdbook et mdbook-plantuml pour plus de détails.

### Troubleshooting

#### Plantuml

- Si vous rencontrez des problèmes avec PlantUML, assurez-vous que le fichier `plantuml.jar` est correctement téléchargé et que les permissions d'exécution sont définies :

```sh
docker-compose run --rm mdbook sh
java -jar /usr/local/bin/plantuml.jar -version
```

- Les fichiers générés par mdbook pour la webview se trouvent dans 'book/' :

```
.
├── README.md
├── book
│   ├── FontAwesome/
│   ├── css/
│   ├── fonts/
│   ├── favicon.png
│   ├── favicon.svg
│   ├── *.js
│   ├── *.html
│   └── *.css
├── book.toml
├── docker-compose.yml
├── mdbook.dockerfile
└── src
    ├── SUMMARY.md
    └── chapter_1.md
```

- Les images générées par mdbook-plantuml pour la webview se trouvent dans '.mdbook-plantuml-cache/' :

```
.
├── .mdbook-plantuml-cache
│   └── 099ffab5f5e292799ab82f248bfb3d1623fc5500.png
├── README.md
├── book/
├── book.toml
├── docker-compose.yml
├── mdbook.dockerfile
└── src
    ├── SUMMARY.md
    └── chapter_1.md
```

- En cas de suppression, les dossiers 'book/' et '.mdbook-plantuml-cache/' sont générés à la volée.

- Pour repartir de 0, supprimer les fichiers 'book.toml', et le dossier 'src/', puis exécuter 'mdbook init' depuis le conteneur

#### mdbook-mermaid

Au premier lancement cela install mdbook-mermaid et cela déploie les fichiers
```bash
mdbook-mermaid install /book
```

Pour update la version de mermaid.min.js
```bash
# mdbook-mermaid prévoit une commande pour mettre à jour mermaid.js
cd /tmp
git clone https://github.com/badboy/mdbook-mermaid.git
cd mdbook-mermaid
cargo xtask 11.10.0
mv ./src/bin/assets/* /book/
# Note : il est aussi possible de récupérer une version plus récente en trouvant mermaid.min.js sur internet
```

## Future Improvments

Automatiser l'installation des plugins mdbook.
Rendre le conteneur davantage clé en main une fois build.

## Contribution

Les contributions sont les bienvenues ! Veuillez soumettre des pull requests ou ouvrir des issues pour signaler des bugs ou proposer des améliorations.

## Licence

Ce projet est sous licence APACHE. Voir le fichier [LICENSE](LICENSE) pour plus de détails.
