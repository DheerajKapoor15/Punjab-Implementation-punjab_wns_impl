drop table IF EXISTS generic.egws_collection;
drop sequence IF EXISTS generic.seq_egws_collection;

CREATE TABLE IF NOT EXISTS generic.egws_collection
(
  ulbname character varying(256) ,
  ulbcode character varying(25) ,
  service character varying(25),
  collectiondate date,
  totalamount double precision,
  charges double precision,
  penalty double precision,
  interest double precision,
  applicationfee double precision,
  advance double precision
);
CREATE INDEX IF NOT EXISTS idx_generic_egws_collection_ulbname ON generic.egws_collection USING btree (ulbname);
CREATE INDEX IF NOT EXISTS idx_generic_egws_collection_ulbcode ON generic.egws_collection USING btree (ulbcode);
CREATE INDEX IF NOT EXISTS idx_generic_egws_collection_service ON generic.egws_collection USING btree (service);
CREATE INDEX IF NOT EXISTS idx_generic_egws_collection_collectiondate ON generic.egws_collection USING btree (collectiondate);