delete from eg_city;

delete from eg_citypreferences;

insert into eg_citypreferences ( id , municipalitylogo , createdby , createddate , lastmodifiedby , lastmodifieddate , version , municipalityname , municipalitycontactno ,municipalityaddress , municipalitycontactemail , municipalitygislocation , municipalitycallcenterno , municipalityfacebooklink ,municipalitytwitterlink , googleapikey , recaptchapk , recaptchapub ) values (nextval('seq_eg_citypreferences') , null , 1 , now(), 1 , now() , 0 , 'Longowal Municipal Council' , '01672-283537' , 'Longowal Municipal Council', 'mclongowal@yahoo.com' , null , '01672-283537' , null , null , null , '6LfidggTAAAAANDSoCgfkNdvYm3Ugnl9HC8_68o0' , '6LfidggTAAAAADwfl4uOq1CSLhCkH8OE7QFinbVs');

INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname,grade) VALUES ('longowal-dev.egovernments.org', 'Longowal', 'Longowal', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '2109', '21', 'Sangrur', 30.2001, 75.6755, (select id from eg_citypreferences where municipalityname = 'Longowal Municipal Council'), 'Patiala Region','MC Class III');
