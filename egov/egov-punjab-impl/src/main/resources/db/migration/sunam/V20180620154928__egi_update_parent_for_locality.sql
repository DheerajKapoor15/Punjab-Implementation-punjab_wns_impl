update eg_boundary set parent = (select id from eg_boundary where name='Block 1') where name='Hanjra Marg Road';
