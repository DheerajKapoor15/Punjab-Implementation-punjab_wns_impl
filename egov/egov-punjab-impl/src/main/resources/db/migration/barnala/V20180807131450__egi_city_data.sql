insert into eg_citypreferences ( id, municipalitylogo, createdby, createddate, lastmodifiedby, lastmodifieddate, version, municipalityname, municipalitycontactno ,municipalityaddress, municipalitycontactemail, municipalitygislocation, municipalitycallcenterno, municipalityfacebooklink ,municipalitytwitterlink, googleapikey, recaptchapk, recaptchapub ) values (nextval('seq_eg_citypreferences'), null, 1, now(), 1, now(), 0, 'Barnala Municipal Council', '01679-231901', 'Barnala Municipal Council', 'ddlgp.barnala@yahoo.com', 'https://www.google.com/maps/@30.3819,75.5468,17z', null, null, null, 'AIzaSyCzRLAPShKqs7rj2yctW0zTVTidlVt1t9I', '6LeeCGMUAAAAAOlhzAooYv1YO2nc2a60WIqNBvIu', '6LeeCGMUAAAAAGJbI4bQbndrX_6jys9bbiBkfDFf');

INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname, grade) VALUES ('barnala-uat.egovernments.org', 'Barnala', 'Barnala', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '201',  '2', 'Barnala', null,null, (select id from eg_citypreferences), 'Patiala Region', 'MC Class I');

