--Category Type

Insert into egwtr_category (id,code,name,description,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_category'),'GENERAL','General',null,'true',now(),now(),1,1,0);


--Water Source Type

Insert into egwtr_water_source (id,code,watersourcetype,description,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_water_source'),'GROUNDWATER','Ground Water','Ground Water','true',now(),now(),1,1,0);

--Usage Type

-----------------START--------------------
Insert into egwtr_usage_type (id,code,name,description,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_usage_type'),'DOMESTIC','Domestic',null,'true',now(),now(),1,1,0);
Insert into egwtr_usage_type (id,code,name,description,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_usage_type'),'COMMERCIAL','Commercial',null,'true',now(),now(),1,1,0);
Insert into egwtr_usage_type (id,code,name,description,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_usage_type'),'APARTMENT','Apartment',null,'true',now(),now(),1,1,0);
Insert into egwtr_usage_type (id,code,name,description,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_usage_type'),'HOTEL','Hotel',null,'true',now(),now(),1,1,0);
Insert into egwtr_usage_type (id,code,name,description,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_usage_type'),'LODGES','Lodges',null,'true',now(),now(),1,1,0);
Insert into egwtr_usage_type (id,code,name,description,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_usage_type'),'INDUSTRIAL','Industrial',null,'true',now(),now(),1,1,0);
Insert into egwtr_usage_type (id,code,name,description,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_usage_type'),'RESIDENTIAL','Residential',null,'true',now(),now(),1,1,0);
------------------END---------------------

--Pipesize Master

-----------------START--------------------
Insert into egwtr_pipesize (id,code,sizeininch,sizeinmilimeter,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_pipesize'),'1/4 Inch',0.25,6.35,'true',now(),now(),1,1,0);
Insert into egwtr_pipesize (id,code,sizeininch,sizeinmilimeter,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_pipesize'),'1/2 Inch',0.5,12.7,'true',now(),now(),1,1,0);
Insert into egwtr_pipesize (id,code,sizeininch,sizeinmilimeter,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_pipesize'),'3/4 Inch',0.75,19.05,'true',now(),now(),1,1,0);
Insert into egwtr_pipesize (id,code,sizeininch,sizeinmilimeter,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_pipesize'),'1 Inch',1.0,25.4,'true',now(),now(),1,1,0);
------------------END---------------------

--Property Type
-----------------START--------------------
Insert into egwtr_property_type (id,code,name,connectioneligibility,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_type'),'RESIDENTIAL','Residential','Y','true',now(),now(),1,1,0);
Insert into egwtr_property_type (id,code,name,connectioneligibility,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_type'),'NON-RESIDENTIAL','Non-Residential','Y','true',now(),now(),1,1,0);
------------------END---------------------

--Property type pipesize mapping

-----------------START--------------------
Insert into egwtr_property_pipe_size (id,pipesize,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_pipesize'),(select id from egwtr_pipesize where code='1/4 Inch'),(select id from egwtr_property_type where code='RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_pipe_size (id,pipesize,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_pipesize'),(select id from egwtr_pipesize where code='1/2 Inch'),(select id from egwtr_property_type where code='RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_pipe_size (id,pipesize,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_pipesize'),(select id from egwtr_pipesize where code='3/4 Inch'),(select id from egwtr_property_type where code='RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_pipe_size (id,pipesize,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_pipesize'),(select id from egwtr_pipesize where code='1 Inch'),(select id from egwtr_property_type where code='RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_pipe_size (id,pipesize,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_pipesize'),(select id from egwtr_pipesize where code='1/4 Inch'),(select id from egwtr_property_type where code='NON-RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_pipe_size (id,pipesize,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_pipesize'),(select id from egwtr_pipesize where code='1/2 Inch'),(select id from egwtr_property_type where code='NON-RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_pipe_size (id,pipesize,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_pipesize'),(select id from egwtr_pipesize where code='3/4 Inch'),(select id from egwtr_property_type where code='NON-RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_pipe_size (id,pipesize,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_pipesize'),(select id from egwtr_pipesize where code='1 Inch'),(select id from egwtr_property_type where code='NON-RESIDENTIAL'),'true',now(),now(),1,1,0);
------------------END---------------------

--Property type category mapping

-----------------START--------------------
Insert into egwtr_property_category (id,categorytype,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_category'),(select id from egwtr_category where code='GENERAL'),(select id from egwtr_property_type where code='RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_category (id,categorytype,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_category'),(select id from egwtr_category where code='GENERAL'),(select id from egwtr_property_type where code='NON-RESIDENTIAL'),'true',now(),now(),1,1,0);
------------------END---------------------

--Property type usage mapping

-----------------START--------------------
Insert into egwtr_property_usage (id,usagetype,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_usage'),(select id from egwtr_usage_type where code='DOMESTIC'),(select id from egwtr_property_type where code='RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_usage (id,usagetype,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_usage'),(select id from egwtr_usage_type where code='COMMERCIAL'),(select id from egwtr_property_type where code='RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_usage (id,usagetype,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_usage'),(select id from egwtr_usage_type where code='APARTMENT'),(select id from egwtr_property_type where code='NON-RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_usage (id,usagetype,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_usage'),(select id from egwtr_usage_type where code='HOTEL'),(select id from egwtr_property_type where code='NON-RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_usage (id,usagetype,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_usage'),(select id from egwtr_usage_type where code='LODGES'),(select id from egwtr_property_type where code='NON-RESIDENTIAL'),'true',now(),now(),1,1,0);
Insert into egwtr_property_usage (id,usagetype,propertytype,active,createddate,lastmodifieddate,createdby,lastmodifiedby,version) values (nextval('seq_egwtr_property_usage'),(select id from egwtr_usage_type where code='INDUSTRIAL'),(select id from egwtr_property_type where code='NON-RESIDENTIAL'),'true',now(),now(),1,1,0);
------------------END---------------------