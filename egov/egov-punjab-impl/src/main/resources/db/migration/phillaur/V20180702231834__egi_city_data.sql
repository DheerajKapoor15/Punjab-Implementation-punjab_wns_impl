INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname, grade) VALUES ('phillaur-uat.egovernments.org', 'Phillaur Municipal Council', 'Phillaur', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '1011',  '10', 'Jalandhar', null,null, NULL, 'Jalandhar Region', 'MC Class II');

insert into eg_citypreferences ( id, municipalitylogo, createdby, createddate, lastmodifiedby, lastmodifieddate, version, municipalityname, municipalitycontactno ,municipalityaddress, municipalitycontactemail, municipalitygislocation, municipalitycallcenterno, municipalityfacebooklink ,municipalitytwitterlink, googleapikey, recaptchapk, recaptchapub ) values (nextval('seq_eg_citypreferences'), null, 1, now(), 1, now(), 0, 'Phillaur Municipal Council', '01826-222542', 'Phillaur Municipal Council', null, 'https://www.google.com/maps/@31.0131,75.7895,17z', null, null, null, 'AIzaSyALeFZtTtnu89PwQFxknF3QotZMBwEZ7Qs', '6LfidggTAAAAANDSoCgfkNdvYm3Ugnl9HC8_68o0', '6LfidggTAAAAADwfl4uOq1CSLhCkH8OE7QFinbVs');
