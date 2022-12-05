insert into eg_citypreferences ( id , municipalitylogo , createdby , createddate , lastmodifiedby , lastmodifieddate , version , municipalityname , municipalitycontactno ,municipalityaddress , municipalitycontactemail , municipalitygislocation , municipalitycallcenterno , municipalityfacebooklink ,municipalitytwitterlink , googleapikey , recaptchapk , recaptchapub ) values (nextval('seq_eg_citypreferences') , null , 1 , '2018-06-21 11:50:23.06' , 1 , '2018-06-21 12:05:36.017' , 0 , 'Khemkaran Nagara Panchayat' , '01851-268658' , 'Khemkaran Nagara Panchayat', 'eonpkk@gmail.com','https://www.google.com/maps/@31.1466046,74.5588059,17z' ,null , null , null , 'AIzaSyALeFZtTtnu89PwQFxknF3QotZMBwEZ7Qs' , '6LfidggTAAAAANDSoCgfkNdvYm3Ugnl9HC8_68o0' , '6LfidggTAAAAADwfl4uOq1CSLhCkH8OE7QFinbVs');

INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname,grade) VALUES ('khemkaran-uat.egovernments.org', 'Khemkaran Nagara Panchayat', 'Khemkaran', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '2202',  '22', 'Tarn Taran', 
null,null, (select id from eg_citypreferences where municipalityname='Khemkaran Nagara Panchayat' ), 'Amritsar Region','NP');