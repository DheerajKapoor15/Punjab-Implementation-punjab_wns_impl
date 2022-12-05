insert into eg_citypreferences ( id , municipalitylogo , createdby , createddate , lastmodifiedby , lastmodifieddate , version , municipalityname , municipalitycontactno ,municipalityaddress , municipalitycontactemail , municipalitygislocation , municipalitycallcenterno , municipalityfacebooklink ,municipalitytwitterlink , googleapikey , recaptchapk , recaptchapub ) values (nextval('seq_eg_citypreferences') , null , 1 , '2018-06-21 11:50:23.06' , 1 , '2018-06-21 12:05:36.017' , 0 , 'Morinda Municipal Council' , '0160-2630037' , 'Morinda Municipal Council', 'mc.morinda@gmail.com','https://www.google.com/maps/@30.7893046,76.4975059,17z' ,null , null , null , 'AIzaSyALeFZtTtnu89PwQFxknF3QotZMBwEZ7Qs' , '6LfidggTAAAAANDSoCgfkNdvYm3Ugnl9HC8_68o0' , '6LfidggTAAAAADwfl4uOq1CSLhCkH8OE7QFinbVs');


INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname,grade) VALUES ('morinda-uat.egovernments.org', 'Morinda Municipal Council', 'Morinda', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '2004',  '20', 'Roopnagar', 
null,null, (select id from eg_citypreferences where municipalityname='Morinda Municipal Council'), 'Ludhiana Region','MC Class II');

