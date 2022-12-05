insert into eg_citypreferences (id, municipalitylogo, createdby, createddate, lastmodifiedby, lastmodifieddate, version, municipalityname, municipalitycontactno, municipalityaddress, municipalitycontactemail, municipalitygislocation, municipalitycallcenterno, municipalityfacebooklink, municipalitytwitterlink, googleapikey, recaptchapk, recaptchapub) values (nextval('seq_eg_citypreferences'), null, 1, now(), 1, now(), 0, 'Improvement Trust Patiala', '', 'Improvement Trust Patiala', 'itpatiala35@gmail.com', 'https://www.google.com/maps/@30.3398,76.3869,17z', null, null, null, 'AIzaSyCzRLAPShKqs7rj2yctW0zTVTidlVt1t9I', '6LeeCGMUAAAAAOlhzAooYv1YO2nc2a60WIqNBvIu', '6LeeCGMUAAAAAGJbI4bQbndrX_6jys9bbiBkfDFf');

INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname, grade) VALUES ('itpatiala-uat.lgpunjab.gov.in', 'Itpatiala', 'Itpatiala', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '1911',  '19', 'Itpatiala', null,null, (select id from eg_citypreferences), 'Patiala Region', 'MC');

--Sample
--insert into eg_citypreferences ( id, municipalitylogo, createdby, createddate, lastmodifiedby, lastmodifieddate, version, municipalityname, municipalitycontactno ,municipalityaddress, municipalitycontactemail, municipalitygislocation, municipalitycallcenterno, municipalityfacebooklink ,municipalitytwitterlink, googleapikey, recaptchapk, recaptchapub ) values (nextval('seq_eg_citypreferences'), null, 1, now(), 1, now(), 0, 'Begowal Nagara Panchayat', '01822-248023', 'Begowal Nagara Panchayat', 'eonpbegowal@gmail.com', 'https://www.google.com/maps/@31.6101,75.5208,17z', null, null, null, 'AIzaSyCzRLAPShKqs7rj2yctW0zTVTidlVt1t9I', '6LeeCGMUAAAAAOlhzAooYv1YO2nc2a60WIqNBvIu', '6LeeCGMUAAAAAGJbI4bQbndrX_6jys9bbiBkfDFf');

--INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname, grade) VALUES ('begowal-uat.egovernments.org', 'Begowal', 'Begowal', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '1101',  '11', 'Kapurthala', null,null, (select id from eg_citypreferences), 'Jalandhar Region', 'NP');
