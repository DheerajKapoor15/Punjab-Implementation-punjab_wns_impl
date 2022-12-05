update chartofaccounts set purposeid=(select id from egf_accountcode_purpose where name='Cash In Transit') where glcode='4318002';
