insert into eg_citypreferences ( id, municipalitylogo, createdby, createddate, lastmodifiedby, lastmodifieddate, version, municipalityname, municipalitycontactno ,municipalityaddress, municipalitycontactemail, municipalitygislocation, municipalitycallcenterno, municipalityfacebooklink ,municipalitytwitterlink, googleapikey, recaptchapk, recaptchapub ) values (nextval('seq_eg_citypreferences'), null, 1, now(), 1, now(), 0, 'Moonak Nagara Panchayat', '01676-276629', 'Moonak Nagara Panchayat', 'npmoonak@yahoo.com', 'https://www.google.com/maps/@29.8253,75.8912,17z', null, null, null, 'AIzaSyCzRLAPShKqs7rj2yctW0zTVTidlVt1t9I', '6LeeCGMUAAAAAOlhzAooYv1YO2nc2a60WIqNBvIu', '6LeeCGMUAAAAAGJbI4bQbndrX_6jys9bbiBkfDFf');

INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname, grade) VALUES ('moonak-uat.egovernments.org', 'Moonak', 'Moonak', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '2111',  '21', 'Sangrur', null,null, (select id from eg_citypreferences), 'Patiala Region', 'NP');
