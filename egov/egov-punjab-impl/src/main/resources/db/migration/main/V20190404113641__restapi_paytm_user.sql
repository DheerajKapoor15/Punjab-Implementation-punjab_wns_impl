insert into eg_user(id, locale, username, password, createddate, lastmodifieddate, createdby, lastmodifiedby, active, name, type, pwdexpirydate) values(nextval('seq_eg_user'), 'en_IN', 'paytm', '$2a$10$KCcznXjWbdUJdNGPFEOkS.1DO9NYLD3QJOtTGPke9KsWZp/OrwgiK', now(), now(), 1, 1, true, 'PAYTM', 'BUSINESS', '2099-01-01 00:00:00');