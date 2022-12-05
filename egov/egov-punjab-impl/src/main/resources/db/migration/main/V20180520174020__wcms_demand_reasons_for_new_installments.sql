--Advance demand reason master
INSERT INTO eg_demand_reason_master(id, reasonmaster, category, isdebit, module,code,"order", create_date, modified_date,isdemand) VALUES (nextval('seq_eg_demand_reason_master'), 'Advance', (select id from eg_reason_category where code='PENALTY'),'N',(select id from eg_module where name = 'Water Tax Management'),'WTADVANCE', 4, now(), now(),true);


--Installments before 1st Apr 2017

Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster='Water Charges' and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, null from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly' and inst.start_date::date<'2017-04-01');

Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster='Penalty' and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, null from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly' and inst.start_date::date<'2017-04-01');

Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster='Interest' and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, null from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly' and inst.start_date::date<'2017-04-01');

--Installments after 1st Jan 2019

Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster='Water Charges' and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, null from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly' and inst.start_date::date>'2019-01-01');

Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster='Penalty' and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, null from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly' and inst.start_date::date>'2019-01-01');

Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster='Interest' and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, null from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly' and inst.start_date::date>'2019-01-01');


--Advance Demand Reasons

Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster='Advance' and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, (select id from chartofaccounts where glcode='3504106') from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly');

--Update glcodes

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1806006') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where reasonmaster='Water Charges' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1718001') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where reasonmaster='Penalty' and module=(select id from eg_module where name='Water Tax Management'));

update EG_DEMAND_REASON set GLCODEID= (select id from chartofaccounts where glcode='1718001') where ID_DEMAND_REASON_MASTER=(select id from eg_demand_reason_master where reasonmaster='Interest' and module=(select id from eg_module where name='Water Tax Management'));
