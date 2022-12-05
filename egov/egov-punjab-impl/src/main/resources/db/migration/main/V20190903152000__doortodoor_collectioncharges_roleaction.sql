insert into EG_ROLEACTION values ((select ID from eg_role where name='Collection Agency'),(select ID from EG_ACTION where name='CollectionChargesAjax'));
