delete from eg_city;

delete from eg_citypreferences;

insert into eg_citypreferences ( id , municipalitylogo , createdby , createddate , lastmodifiedby , lastmodifieddate , version , municipalityname , municipalitycontactno ,municipalityaddress , municipalitycontactemail , municipalitygislocation , municipalitycallcenterno , municipalityfacebooklink ,municipalitytwitterlink , googleapikey , recaptchapk , recaptchapub ) values (nextval('seq_eg_citypreferences') , null , 1 , now(), 1 , now() , 0 , 'Sunam Municipal Council' , '01676-227150' , 'Sunam Municipal Council', 'mcsunam.sgr@gmail.com' , null , '01676-227150' , null , null , null , '6LfidggTAAAAANDSoCgfkNdvYm3Ugnl9HC8_68o0' , '6LfidggTAAAAADwfl4uOq1CSLhCkH8OE7QFinbVs');

INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname,grade) VALUES ('sunam-dev.egovernments.org', 'Sunam', 'Sunam', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '2113', '21', 'Sangrur', 30.1252, 75.8137, (select id from eg_citypreferences where municipalityname = 'Sunam Municipal Council'), 'Patiala Region','MC Class I');
