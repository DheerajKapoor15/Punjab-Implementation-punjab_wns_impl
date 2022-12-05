
update chartofaccounts set glcode='4502001', parentid=(select id from chartofaccounts where glcode='45020'),functionreqd=true where glcode='4502101';
