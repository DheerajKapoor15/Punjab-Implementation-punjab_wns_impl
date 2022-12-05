update eg_installment_master set description =  substr(description,0,11) || 'Q1 (Apr to Jun)'  where id_module in (select id from eg_module where name in('Water Tax Management','Sewerage Tax Management')) and installment_type = 'Quarterly' and description like '%-1';

update eg_installment_master set description =  substr(description,0,11) || 'Q2 (Jul to Sept)'  where id_module in (select id from eg_module where name in('Water Tax Management','Sewerage Tax Management')) and installment_type = 'Quarterly' and description like '%-2';

update eg_installment_master set description =  substr(description,0,11) || 'Q3 (Oct to Dec)'  where id_module in (select id from eg_module where name in('Water Tax Management','Sewerage Tax Management')) and installment_type = 'Quarterly' and description like '%-3';

update eg_installment_master set description =  substr(description,0,11) || 'Q4 (Jan to Mar)'  where id_module in (select id from eg_module where name in('Water Tax Management','Sewerage Tax Management')) and installment_type = 'Quarterly' and description like '%-4';