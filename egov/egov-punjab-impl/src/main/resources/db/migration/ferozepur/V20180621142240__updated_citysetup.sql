
delete from eg_city;
delete from eg_citypreferences;

insert into eg_citypreferences ( id , municipalitylogo , createdby , createddate , lastmodifiedby , lastmodifieddate , version , municipalityname , municipalitycontactno ,municipalityaddress , municipalitycontactemail , municipalitygislocation , municipalitycallcenterno , municipalityfacebooklink ,municipalitytwitterlink , googleapikey , recaptchapk , recaptchapub ) values (nextval('seq_eg_citypreferences') , null , 1 , '2018-06-19 11:50:23.06' , 1 , '2018-06-19 12:05:36.017' , 0 , 'Ferozepur Municipal Council' , '01632-246293' , 'Ferozepur Municipal Council', 'eomcfzr1632@gmail.com' , 'https://www.google.com/maps/@30.933100, 74.622500,15z' ,null , null , null , 'AIzaSyALeFZtTtnu89PwQFxknF3QotZMBwEZ7Qs' , '6LfidggTAAAAANDSoCgfkNdvYm3Ugnl9HC8_68o0' , '6LfidggTAAAAADwfl4uOq1CSLhCkH8OE7QFinbVs');

INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname,grade) VALUES ('ferozepur-uat.egovernments.org', 'Ferozepur Municipal Council', 'Ferozepur', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '701',  '7', 'Ferozepur', 
null,null,(select id from eg_citypreferences where municipalityname='Ferozepur Municipal Council'), 'Ferozepur Region','MC Class I');
