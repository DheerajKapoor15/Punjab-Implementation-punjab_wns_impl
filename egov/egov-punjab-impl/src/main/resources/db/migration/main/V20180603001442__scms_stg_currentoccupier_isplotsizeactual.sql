alter table egswtax_stg_connection add currentoccupier character varying(100);
alter table egswtax_stg_connection add isplotsizeactual character varying(10);
alter table egswtax_stg_connection_dcb alter column billingcycle type character varying(50);
