USE sarlacc;
  
DROP TABLE doc_to_versions;
DROP TABLE dates;
DROP TABLE raw_documents;

CREATE TABLE doc_to_versions (
  source text,
  doc_id text,
  
  version timeuuid,
  bytes blob,
  -- add anything else
  
  PRIMARY KEY ((source, doc_id), version)
  )
WITH CLUSTERING ORDER BY (version ASC);

CREATE TABLE dates (
  date text,
  
  PRIMARY KEY (date)
  );

CREATE TABLE raw_documents (
  source text,
  date text,
  
  doc_id text,
  version timeuuid,
  
  bytes blob,
  file_type text, 
  harvester_log map<text,timestamp>, -- move into its own table at some stage

  -- Normalized
  uris text,
  title text,
  contributors text,
  providerUpdatedDateTime timestamp,

  description text,
  freeToRead boolean,
  languages set<text>,
  licenses set<text>,
  publisher text,
  subjects set<text>,
  tags set<text>,
  sponsorships text,
  properties set<text>,
  
  PRIMARY KEY ((source, date), doc_id, version)
  )
WITH CLUSTERING ORDER BY (doc_id ASC);