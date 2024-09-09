use Hospital_private;
/* Afisarea tipurilor de date ale propietatiilor a tabelului*/
describe medicine_tests;
describe medicine;

/* descriptia testelor cu fiecare doctor si pacientii lor*/

select doctors.name, patients.patient_name,tests.description from hospital_private.doctors
join  hospital_private.tests on doctors.id = tests.doctor_id
join hospital_private.patients on tests.patient_id = patients.id;

/* Am adaugat in tabelul de medicamente o noua  propietate*/
alter table medicine add  nr_vanzare integer;

/*Inseram medicamentele in baza de date*/
insert into medicine(id,name,company,cost,description,nr_vanzare)
values  (50,'Coldrex','Farmacia Catena','12,3','Paracetamol',20),
        (51, 'Aspirin', 'Bayer', '8,5', 'Analgesic', 50),
        (52, 'Nurofen', 'Reckitt Benckiser', '15,2', 'Ibuprofen', 35),
        (53, 'Panadol', 'GlaxoSmithKline', '10,0', 'Paracetamol', 40),
        (54, 'Algocalmin', 'Zentiva', '9,8', 'Metamizole', 25),
        (55, 'Ibuprofen', 'Teva', '7,4', 'Ibuprofen', 60),
        (56, 'Parasinus', 'Biofarm', '11,0', 'Paracetamol', 18),
        (57, 'Ketonal', 'Lek', '13,5', 'Ketoprofen', 22);

/*Selectam media valoriilor a nr de pacient in functie de  email-ul a doctoriilor*/
Select AVG(nr_patients)
from doctors
where email  like 'a%'  ;

/*selectam datele la doua tabele de odata*/

Select patient_name from patients
UNION
select name from doctors;

/*extrage numele si telefonul mobile pacietiilor care au doctorii cu nr de pacienti mai mare de 30*/

select patient_name,mobile from patients
where patients.id in (select (patient_id)from tests where doctor_id <= 30 );

/*toti doctorii care au acelasi ID cu pacientii care numerele de telefon sunt peste medie.*/

select *from doctors
where id in (
    select id
    from patients
    where mobile > (select AVG(mobile) from patients)
);


/*Am apasat key din tabel si nu stiu ce sa intamplat*/
insert into medicine_tests(id,medicine_id,test_id)
value (60,50,50),
    (61,56,46),
    (62,57,43),
    (64,52,48),
    (65,51,46),
    (67,54,45)
;
/*Numele testelor care foloses medicamentele cu id-uri <= 54( Ar trebui sa apara 4)*/
select tests.name from tests
join medicine_tests on tests.id = medicine_tests.test_id
join medicine on medicine_tests.medicine_id = medicine.id
where medicine_id <=54;

