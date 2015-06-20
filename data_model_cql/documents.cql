USE sarlacc;
  
DROP TABLE doc_to_versions;
DROP TABLE dates; -- ignored for the moment;
DROP TABLE raw_documents;
DROP TABLE doc_to_properties; -- ignore for the moment;

CREATE TABLE doc_to_versions (
  source text,
  doc_id text,
  
  version timeuuid,
  bytes blob,
  -- add anything else
  
  PRIMARY KEY ((source, doc_id), version)
  )
WITH CLUSTERING ORDER BY (version ASC);

CREATE TABLE doc_to_properties (
  source text,
  doc_id text,
  
  timepoint timestamp,
  prop_list map<text, text>,
  
  PRIMARY KEY ((source, doc_id), timepoint)
  )
WITH CLUSTERING ORDER BY (timepoint ASC);

CREATE TABLE dates (
  date text,
  
  PRIMARY KEY (date)
  );

CREATE TABLE raw_documents (
  source text,
  date text, // 'DD-MM-YYYY'
  
  doc_id text,
  version timeuuid, // internal to COS
  
  bytes blob,
  file_type text, 
  harvester_log map<text,timestamp>, -- move into its own table at some stage

  -- Normalized
  uris text,
  title text,
  
  --TODO: Contributors cannot be indexed. Later stage: Move _Contributor_ as a full fledged attribute.
  --nContributors is i \in [0..n] and each key in map is prefixed with "i_" string. This is a hack to flatten the list, see the TODO.
  nContributors int,
  contributors map<text,text>, -- 
  
  providerUpdatedDateTime timestamp,

  description text,
  freeToRead boolean,
  languages set<text>,
  licenses set<text>,
  publisher map<text,text>,
  subjects set<text>,
  tags set<text>,
  sponsorships set<text>,
  
  PRIMARY KEY ((source, date), doc_id, version)
  )
WITH CLUSTERING ORDER BY (doc_id ASC);