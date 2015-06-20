-- Single local machine
CREATE KEYSPACE "sarlacc" WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };