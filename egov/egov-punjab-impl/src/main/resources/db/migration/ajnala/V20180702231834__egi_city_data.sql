INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname, grade) VALUES ('ajnala-uat.egovernments.org', 'Ajnala Nagara Panchayat', 'Ajnala', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '0101',  '1', 'Amritsar', null,null, NULL, 'Amritsar Region', 'NP');

insert into eg_citypreferences ( id, municipalitylogo, createdby, createddate, lastmodifiedby, lastmodifieddate, version, municipalityname, municipalitycontactno ,municipalityaddress, municipalitycontactemail, municipalitygislocation, municipalitycallcenterno, municipalityfacebooklink ,municipalitytwitterlink, googleapikey, recaptchapk, recaptchapub ) values (nextval('seq_eg_citypreferences'), null, 1, now(), 1, now(), 0, 'Ajnala Nagara Panchayat', '01858-221438', 'Ajnala Nagara Panchayat', 'eonpajnala@yahoo.com', 'https://www.google.com/maps/@31.8428,74.7630,17z' ,null, null, null, 'AIzaSyALeFZtTtnu89PwQFxknF3QotZMBwEZ7Qs', '6LfidggTAAAAANDSoCgfkNdvYm3Ugnl9HC8_68o0', '6LfidggTAAAAADwfl4uOq1CSLhCkH8OE7QFinbVs');
