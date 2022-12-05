alter table egwtr_stg_connection alter column meterserialno type character varying(120);
alter table egwtr_stg_connection alter column metermanufacturer type character varying(120);
alter table egwtr_stg_connection alter column latestreading type double precision;
alter table egwtr_stg_connection alter column avglastthreereading type double precision;
alter table egwtr_stg_connection add column meterstatus character varying(120);
