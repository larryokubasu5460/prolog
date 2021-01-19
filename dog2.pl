/** veterinary knowledge: admission;vaccine benefit; vaccine analysis;treatment
			: admission; disease check; symptoms; treatment

**/
% admission
check:- sick(other), write('Dog must have been brought for vaccination or checkup'),nl.
 
%vaccine predicates
vaccines('C3', puppy ,'C3 administered to prevent parvovirus distemper and infectious hepatitis 1 to 2 months').
vaccines('C5', puppy ,'C5 administered to prevent C4 and bordetella bronchioseptica at 3 months').
vaccines('C3', puppy ,'C3 booster at 4 months').
vaccines('Cough vaccination', adult ,'Canine cough vaccination administered annually').
vaccines('C3', adult, 'C3 vaccination every 3 years to prevent parvovirus distemper and infectious hepatits').
vaccines('C5', adult ,'Recommend C5 booster annually').

%Miscelleanous advice 
advice:- ageGroup(puppy),nl, write('You can also administer Leptospira vaccine'),nl.




%diseases and symptoms
disease('athritis','Slow to get to feet, less active,').
disease('cataracts','Affected sight, also caused by other diseases').
disease('ear infection','Infection, pawing at ears alot').
disease('Kennel cough','Harsh hacking cough that finishes with gagging, excitement and pain on throat makes it worse, severe cases lead to fever, lethargy and reduced appetite').
disease('fleas and ticks','Increased vomits, wobbly or unsteady legs, change in barking, heavy panting, paralysis and sometimes leads to death').
disease('heartworm','Lethargy, fainting, abdominal swelling,weight loss').
disease('broken bones','Limping, lumps, protruding boens, whimpering or whining when touched').
disease('cancer','Lumps or unusual spots on dogs ears, eyes and skin').

%treatment
treat('arthritis','Exercise, weight control and anti-arthritic drugs').
treat('ear infection',"Ear drops with antibiotics and cleaning dog's ears").
treat('kennel cough','Rest, plenty of good food and water if severe administer antiobiotics').
treat('heartworm','Regular blood tests, Stay in a mosquito free zone').
treat('fleas and ticks','Premedication and anti-tick serums').
treat('cancer','Surgeries, chemotherapy or radiotion treatment').


%check age in months
checkAge:- age(X),X>0,X<3, write('Puppy has to be administered first vaccine C3'),!.
checkAge:- age(X),X>2,X<4, write('Puppy has to be administered vaccine C5'),!.
checkAge:- age(X),X>3,X<5, write('Give puppy booster of C3'),!.
checkAge:- age(X), X>14,X<16, write('Give dog first annual vaccination'),!.
checkAge:- age(X), X>15, write('Recommend annual C5 booster vaccination'),!.
checkAge:- age(X),X>15,D=:=3,divides(X,D),write('C3 vaccine to be given'),!.
%administer vaccine after 3 years
divides(X,D):- X is mod(X,D), X<1.


% user queries
sick(X):- write('Why has the dog been brought?,[vaccination,checkup,other]: '), read(X).
ageGroup(X):- write('Which group is the dog (less than a year puppy)?, [puppy,adult]: '), read(X).
age(X):- write('How old in months is the dog?, [1,2,3..]: '), read(X).
get_disease(X):- write('Which disease is the dog/puppy likely to be suffering from?, [heartworm,arthritis,kennel cough,ear infection, flea and tick, cancer]: '), read(X).
admitted(X):- write('Has the dog been passed for vaccination(no for checkup)?, [yes,no]'), read(X).

%inference engine
admit:- pass,vaccine_administering,diagnose,medication,other_advice,!.
admit.

%admission
pass:- check,!, fail.
pass.

%action
objective_action:- admitted(yes),ageGroup(X), write('The following vaccines are available for '), write(X),nl,
			vaccines(Vaccine,X,Benefit),write(Vaccine:Benefit),nl,fail.
objective_action.

%vaccine administering according to age
vaccine_administering:- objective_action,nl,checkAge,nl,!.
vaccine_administering.


%diagnosing dog according to symptoms
diagnose:-admitted(no),ageGroup(X),write('Since the '),write(X), write(' has been brought for disease check up below are the common diseases and symptoms to check out'),
			nl,disease(Illness,Symptom),write(Illness:Symptom),nl,fail.
diagnose.

medication:- write('Based on the symptoms you have been provided choose the likely disease'), get_disease(X),treat(X,Treatment),nl,tab(4), write(Treatment), nl,fail.
medication.


%other advice
other_advice:- advice,fail.
other_advice.