-- 1. Ativar PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;

-- 2️. Criar schema lógico
CREATE SCHEMA IF NOT EXISTS georag;

-- 3️. Tabela espacial
CREATE TABLE IF NOT EXISTS georag.georag_spatial_index (
    id BIGSERIAL PRIMARY KEY,
    geohash TEXT,
    ruleset_version TEXT,
    geom geometry(Geometry, 4326),
    contexto_struct JSONB,
    created_at TIMESTAMP DEFAULT now()
);

-- 4️. Índice espacial REAL
CREATE INDEX IF NOT EXISTS idx_georag_geom
    ON georag.georag_spatial_index
    USING GIST (geom);

-- 5️. Índice lógico (rápido)
CREATE INDEX IF NOT EXISTS idx_georag_ruleset
    ON georag.georag_spatial_index (ruleset_version);
