INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname, grade) VALUES ('bassipathana-uat.egovernments.org', 'Bassi Pathana Municipal Council', 'Bassi Pathana', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '0502',  '5', 'Fatehgarh Sahib', null,null, NULL, 'Ludhiana Region', 'MC Class III');

insert into eg_citypreferences ( id, municipalitylogo, createdby, createddate, lastmodifiedby, lastmodifieddate, version, municipalityname, municipalitycontactno ,municipalityaddress, municipalitycontactemail, municipalitygislocation, municipalitycallcenterno, municipalityfacebooklink ,municipalitytwitterlink, googleapikey, recaptchapk, recaptchapub ) values (nextval('seq_eg_citypreferences'), null, 1, now(), 1, now(), 0, 'Bassi Pathana Municipal Council', '01763-250032', 'Bassi Pathana Municipal Council', 'eomc.bassipathana@gmail.com', 'https://www.google.com/maps/@30.6861,76.4042,17z', null, null, null, 'AIzaSyCzRLAPShKqs7rj2yctW0zTVTidlVt1t9I', '6LeeCGMUAAAAAOlhzAooYv1YO2nc2a60WIqNBvIu', '6LeeCGMUAAAAAGJbI4bQbndrX_6jys9bbiBkfDFf');
