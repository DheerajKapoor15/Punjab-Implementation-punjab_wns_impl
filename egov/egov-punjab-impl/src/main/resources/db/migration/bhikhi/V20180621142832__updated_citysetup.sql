delete from eg_city;
delete from eg_citypreferences;

insert into eg_citypreferences ( id , municipalitylogo , createdby , createddate , lastmodifiedby , lastmodifieddate , version , municipalityname , municipalitycontactno ,municipalityaddress , municipalitycontactemail , municipalitygislocation , municipalitycallcenterno , municipalityfacebooklink ,municipalitytwitterlink , googleapikey , recaptchapk , recaptchapub ) values (nextval('seq_eg_citypreferences') , null , 1 , '2018-06-19 11:50:23.06' , 1 , '2018-06-19 12:05:36.017' , 0 , 'Bhikhi Nagara Panchayat' , '01652-275834' , 'Bhikhi Nagara Panchayat', 'eobhikhi@gmail.com' , 'https://www.google.com/maps/@30.0582,75.532106,17z' ,null , null , null , 'AIzaSyALeFZtTtnu89PwQFxknF3QotZMBwEZ7Qs' , '6LfidggTAAAAANDSoCgfkNdvYm3Ugnl9HC8_68o0' , '6LfidggTAAAAADwfl4uOq1CSLhCkH8OE7QFinbVs');

INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname,grade) VALUES ('bhikhi-uat.egovernments.org', 'Bhikhi Nagara Panchayat', 'Bhikhi', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '1302',  '13', 'Mansa', 
null,null, (select id from eg_citypreferences where municipalityname='Bhikhi Nagara Panchayat'), 'Bathinda Region','NP');
