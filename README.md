# README

* Technical test for Cheerz

Because the combination of 3 uppercase letter is not too much, the approach is to use database to store pseudo (aka : availlable pseudo).
User creation will refere to pseudo table to calculate availlable pseudo.
This approach enable to add new pseudos when all pseudio are used (but need to update regulare expression validation to authorize other characters)

If we have to add too large number of pseudo on the future, we'll have to change on the create user service to use another approch of calculation 
(dichotomic search...)

The approach was test driven on the api endpoint

* Evolutions

All additional features to add user creation, user update, ...

* Missing, not done todo : 

- cleanuop code with linter (Rubocop)
- add unit tests in details (models, ...)

