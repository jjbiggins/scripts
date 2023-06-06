-- Role: ghost
-- DROP ROLE IF EXISTS ghost;

CREATE ROLE ghost WITH
  LOGIN
  SUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  REPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:0bempx9F6nDWcy7yViYk9A==$y3i6QH6xDbwgLZBJ+GmBTAB3KOqVQLhXiu3R5sU4I7c=:1kGCHppvIFcn2xxfXgN12PUI2LyWA6nlS8CrdejAqZo=';

GRANT pg_execute_server_program, pg_monitor, pg_read_all_data, pg_read_all_settings, pg_read_all_stats, pg_read_server_files, pg_write_all_data, pg_write_server_files TO ghost WITH ADMIN OPTION;