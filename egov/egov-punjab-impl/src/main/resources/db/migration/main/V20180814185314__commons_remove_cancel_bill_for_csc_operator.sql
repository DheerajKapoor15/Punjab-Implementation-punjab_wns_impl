

delete from eg_roleaction where actionid in (select id from eg_action where name in ('CancelWaterBill', 'AjaxActiveReceiptExists', 'AjaxConnectionsWithActiveReceipt', 'CancelSewerageBill')) and roleid = (select id from eg_role where name = 'CSC Operator');

delete from eg_roleaction where actionid in (select id from eg_action where name in ('CancelSewerageBill', 'STMSAjaxActiveReceiptExists', 'STMSAjaxConnectionsWithActiveReceipt')) and roleid = (select id from eg_role where name = 'Sewerage Tax Administrator');




