delete from fiscalperiod where name ='201617';
delete from financialyear where financialyear ='2016-17';

delete from fiscalperiod where name ='201718';
delete from financialyear where financialyear ='2017-18';

INSERT INTO financialyear (id, financialyear, startingdate, endingdate, isactive, createddate, lastmodifieddate,lastmodifiedby,createdby,version, isactiveforposting, isclosed, transferclosingbalance) 
values( nextval('seq_financialyear'), '2017-18', '01-Apr-2017', '31-Mar-2018', true, current_date, current_date, 1,1,0, false, false, false);


INSERT INTO fiscalperiod (id,name, startingdate, endingdate,isactiveforposting, isactive, createddate, lastmodifieddate,lastmodifiedby,createdby,version, financialyearid) 
values( nextval('seq_fiscalperiod'),'201718', '01-Apr-2017', '31-Mar-2018',false, true, current_date, current_date,1,1,0, (select id from financialyear where financialyear='2017-18'));


INSERT INTO financialyear (id, financialyear, startingdate, endingdate, isactive, createddate, lastmodifieddate,lastmodifiedby,createdby,version, isactiveforposting, isclosed, transferclosingbalance) 
values( nextval('seq_financialyear'), '2016-17', '01-Apr-2016', '31-Mar-2017', true, current_date, current_date, 1,1,0, false, false, false);


INSERT INTO fiscalperiod (id,name, startingdate, endingdate,isactiveforposting, isactive, createddate, lastmodifieddate,lastmodifiedby,createdby,version, financialyearid) 
values( nextval('seq_fiscalperiod'),'201617', '01-Apr-2016', '31-Mar-2017',false, true, current_date, current_date,1,1,0, (select id from financialyear where financialyear='2016-17'));

