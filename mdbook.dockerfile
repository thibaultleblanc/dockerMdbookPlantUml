FROM rust:1.89.0-bookworm

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    openjdk-17-jre \
    graphviz \
    wget \
    && apt-get clean

# Installer PlantUML
RUN wget https://sourceforge.net/projects/plantuml/files/plantuml.jar/download -O /usr/local/bin/plantuml.jar

# Donner les permissions d'exécution à plantuml.jar
RUN chmod +x /usr/local/bin/plantuml.jar

# Installer mdBook et le préprocesseur PlantUML
RUN cargo install mdbook
RUN cargo install mdbook-plantuml --no-default-features --features plantuml-server
RUN cargo install mdbook-mermaid


# Définir le répertoire de travail
WORKDIR /book

# Commande par défaut
CMD ["mdbook", "serve", "-n", "0.0.0.0"]
