delete from eg_city;
delete from eg_citypreferences;

insert into eg_citypreferences ( id, municipalitylogo, createdby, createddate, lastmodifiedby, lastmodifieddate, version, municipalityname, municipalitycontactno ,municipalityaddress, municipalitycontactemail, municipalitygislocation, municipalitycallcenterno, municipalityfacebooklink ,municipalitytwitterlink, googleapikey, recaptchapk, recaptchapub ) values (nextval('seq_eg_citypreferences'), null, 1, now(), 1, now(), 0, 'Maloud Nagara Panchayat', '0161-2857505', 'Maloud Nagara Panchayat', 'npmaloudh@ymail.com', 'https://www.google.com/maps/@30.6345,75.9352,17z', null, null, null, 'AIzaSyCzRLAPShKqs7rj2yctW0zTVTidlVt1t9I', '6LeeCGMUAAAAAOlhzAooYv1YO2nc2a60WIqNBvIu', '6LeeCGMUAAAAAGJbI4bQbndrX_6jys9bbiBkfDFf');

INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname, grade) VALUES ('maloud.lgpunjab.gov.in', 'Maloud', 'Maloud', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '1205',  '12', 'Ludhiana', null,null, (select id from eg_citypreferences), 'Ludhiana Region', 'NP');
