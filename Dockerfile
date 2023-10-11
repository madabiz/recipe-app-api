# Scarica da docker hub l'immagine di python per ambiente linux
FROM python:3.9-alpine3.13 

# Label informativa
LABEL mantainer="Madalin"

# Quando docker printa cose sul terminal arrivano in diretta senza delay
ENV PYTHONUNBUFFERED 1

# Copia il file requirements da locale e lo inserisce su una cartella temporanea del container docker
COPY ./requirements.txt /tmp/requirements.txt
# Copia la cartella locale app sul container docker
COPY ./app /app
# Cartella da dove vengon lanciati tutti i comandi docker 
WORKDIR /app

# L'immagine docker apre una porta verso il pc locale
EXPOSE 8000

# Installa venv, aggiorna pip e le dipendenze e rimuove la cartella
# tmp dove ci sono i requiremenets per alleggerire l'immagine di docker
# Crea un utente django-user, la best practice è di non usare root, perché se entrano nel server avrebbero privilegi da root
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# Scrive una variabile d'ambiente all'interno dell'imagine docker
# In questo modo tutti i comandi vengono lanciati da dentro la venv
ENV path="/py/bin:$PATH"

# Seleziona l'utente
USER django-user
