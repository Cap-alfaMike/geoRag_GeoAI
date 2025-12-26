# GeoRAG Spatial Indexing: Infraestrutura para GeoAI
Este repositório apresenta a camada de persistência e indexação espacial projetada para sistemas de GeoAI (Geospatial Artificial Intelligence). Através da integração entre PostgreSQL, PostGIS e arquiteturas de GeoRAG (Geographic Retrieval-Augmented Generation), esta estrutura permite a recuperação eficiente de contextos espaciais para alimentar modelos de linguagem e pipelines de Machine Learning.

# 1. Fundamentação Teórica
## 1.1 GeoAI e Engenharia de IA
A GeoAI é uma disciplina transdisciplinar que combina métodos de Inteligência Artificial, especificamente Deep Learning e Data Mining, com a Ciência da Informação Geográfica (GIScience). Segundo Janowicz et al. (2020), a GeoAI se diferencia da IA convencional por tratar explicitamente a Primeira Lei da Geografia de Tobler, que assume que "todas as coisas estão relacionadas, mas coisas próximas estão mais relacionadas do que coisas distantes".

No âmbito da engenharia, a GeoAI exige estruturas de dados que suportem a alta dimensionalidade e a heterogeneidade espacial, permitindo que algoritmos de ML processem relações topológicas e de proximidade em tempo real (VOZENILEK, 2020).

## 1.2 GeoRAG (Geographic Retrieval-Augmented Generation)
O RAG (Retrieval-Augmented Generation) é uma técnica que mitiga as limitações de conhecimento estático em LLMs, permitindo a consulta a bases de dados externas durante o processo de inferência (LEWIS et al., 2020).

O GeoRAG especializa essa técnica ao introduzir filtros espaciais no processo de retrieval. Em vez de uma busca semântica puramente vetorial, o GeoRAG utiliza coordenadas e geometrias para extrair contextos geográficos específicos, garantindo que a "IA saiba onde os fatos estão ocorrendo".

# 2. Descrição Técnica da Infraestrutura
A stack tecnológica baseia-se no PostgreSQL estendido pelo PostGIS, seguindo as especificações da Open Geospatial Consortium (OGC).

## 2.1 Esquema Lógico e Tabela Espacial
O uso de um schema dedicado (georag) visa a modularidade e a governança de dados, essencial em ambientes de produção de IA (MLOps). A tabela principal armazena:

Geometria (SRID 4326): Armazenamento de pontos, linhas ou polígonos em coordenadas globais.

JSONB (contexto_struct): Armazenamento de metadados heterogêneos com suporte a indexação. Esta flexibilidade permite que o mesmo schema armazene desde teores de carbono em solo até métricas de densidade urbana.

## 2.2 Estratégias de Indexação de Alta Performance
Para viabilizar o GeoRAG em escala, o banco implementa dois tipos de índices fundamentais:

GIST (Generalized Search Tree): Implementado no campo geom, este índice utiliza a estrutura R-Tree (GUTMAN, 1984). Ele organiza os dados em retângulos envolventes mínimos (MBRs), permitindo que buscas de vizinhança e interseção sejam realizadas sem a necessidade de varrer toda a tabela (Sequential Scan).

B-Tree: Aplicado à coluna ruleset_version. Enquanto o GIST lida com a complexidade bidimensional, o B-Tree otimiza buscas categóricas e filtragens lógicas por versões de modelos, garantindo baixa latência em consultas híbridas.


# Referências Bibliográficas (ABNT)

GUTMAN, A. R-trees: a dynamic index structure for spatial searching. In: Proceedings of the 1984 ACM SIGMOD international conference on Management of data, p. 47-57, 1984.

JANOWICZ, K. et al. GeoAI: spatially explicit artificial intelligence techniques for geographic knowledge discovery and beyond. International Journal of Geographical Information Science, v. 34, n. 4, p. 625-636, 2020.

LEWIS, P. et al. Retrieval-augmented generation for knowledge-intensive nlp tasks. Advances in Neural Information Processing Systems, v. 33, p. 9459-9474, 2020.

POSTGIS PROJECT. PostGIS 3.5.0 Manual. [S. l.]: OSGeo, 2024. Disponível em: https://postgis.net/docs/. Acesso em: 26 dez. 2025.

VOZENILEK, V. GeoAI – a new challenge for cartography. Abstracts of the ICA, v. 2, p. 1-2, 2020.


