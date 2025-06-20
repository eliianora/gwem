# Utilisez une image de base Python
FROM python:3.9-slim-buster

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Créer un utilisateur non-root
RUN adduser --system --group appuser

# Copier les fichiers de dépendances et installer les dépendances
# Utilisez COPY --chown pour vous assurer que les fichiers appartiennent à l'utilisateur non-root par défaut
COPY --chown=appuser:appuser requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste du code de l'application
COPY --chown=appuser:appuser . .

# Définir l'utilisateur non-root pour l'exécution
USER appuser

# Exposer le port sur lequel Gunicorn s'exécutera (8000 par défaut)
EXPOSE 8000

# Commande par défaut pour exécuter Gunicorn
# gwem_backend.wsgi:application fait référence au module wsgi de votre projet Django
CMD ["gunicorn", "gwem_backend.wsgi:application", "--bind", "0.0.0.0:8000"] 