update chartofaccounts set parentid=(select id from chartofaccounts where glcode='45020') where glcode in('4502002','4502003', '4502004');
