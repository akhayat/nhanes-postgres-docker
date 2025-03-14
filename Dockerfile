FROM deepayansarkar/nhanes-postgresql:0.11.0

RUN useradd -ms /bin/bash sa

COPY nhanes_data_pool.sql .

RUN sed -i 's/peer/trust/g' /etc/postgresql/16/main/pg_hba.conf \
    && service postgresql start \
    && psql NhanesLandingZone sa -f nhanes_data_pool.sql \
    && service postgresql stop

EXPOSE 8787
EXPOSE 2200
EXPOSE 5432
