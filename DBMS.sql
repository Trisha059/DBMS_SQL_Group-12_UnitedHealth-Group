create database if not exists uhg_db;
use uhg_db;
create table if not exists patients (
    patient_id int unsigned auto_increment primary key,
    patient_first_name varchar(20) not null,
    patient_last_name varchar (20) not null,
    patient_DOB date not null,
    patient_blood_group char(3), -- Examples would be A+, AB, B-
    patient_gender char(1),
    patient_contact_number varchar (15) not null
);
insert into patients (patient_first_name, patient_last_name, patient_DOB, patient_blood_group, patient_gender,patient_contact_number)
values ('Rohit', 'Shetty', '2002-11-14', 'B+', 'M','8452033811');
create table if not exists staff(
staff_id int unsigned auto_increment primary key,
staff_name varchar (30) not null,
staff_contact varchar (15) not null,
staff_position varchar (15) not null,
department varchar (15) not null, 
email varchar (30) not null unique
);
insert into staff (staff_id, staff_name, staff_contact, staff_position, department, email)
values ('123456', 'Naveen', '34232432', 'Doctor', 'Homeopathy', 'naveen@gmail.com');
create table if not exists billing(
billing_id int unsigned auto_increment primary key,
patient_id int unsigned not null,
billing_mode varchar (10) not null, 
amount decimal (10,2) not null,
billing_date date not null,
billing_staff varchar(20) not null,
constraint fk_billing_patients
foreign key (patient_id) references patients(patient_id)
);
create table if not exists supplier(
supplier_id int unsigned auto_increment primary key,
contact_no varchar(20) not null unique,
equipment_id varchar (20) not null,
email varchar (20) unique not null,
contact_name varchar(20) not null,
city varchar(10)
);
create table insurance_plans(
plan_id int unsigned auto_increment primary key,
plan_name varchar(20) not null unique,
plan_type ENUM('HMO','PPO','EPO','Medicare') not null
);
create table if not exists departments(
dept_id int unsigned primary key,
dept_name varchar (20) not null unique, 
dept_employee_count varchar(10) not null,	
department_head varchar(20),
office_location varchar(10)
);
alter table staff
drop column department;
use uhg_db;
alter table staff
add constraint fk_staff_department
foreign key (department_id) references departments(department_id);
create table if not exists enrollments (
enrollment_id int unsigned auto_increment,
patient_id int unsigned not null,
plan_id int unsigned not null,
member_id varchar(20) not null unique, -- The unique ID on the insurance card
start_date date not null,
end_date date,
primary key(enrollment_id),
foreign key (patient_id) references patients(patient_id),
foreign key (plan_id) references insurance_plans(plan_id)
);
create table if not exists claims (
claim_id int unsigned auto_increment primary key,
enrollment_id int unsigned not null, 
provider_id int unsigned,           
date_of_service date not null,
submission_date date not null,
billed_amount decimal(10, 2) not null,
status enum('submitted', 'pending', 'denied', 'paid') not null default 'submitted',
foreign key (enrollment_id) references enrollments(enrollment_id)
);
create table if not exists procedures (
procedure_code_id int unsigned auto_increment primary key,
procedure_name varchar(10) not null unique,  
description varchar(100) not null,
fee decimal(10, 2) 
);
create table if not exists diagnoses (
diagnosis_code_id int unsigned auto_increment primary key,
description varchar(100) not null
);
create table if not exists audit_log (
log_id bigint unsigned auto_increment primary key,
staff_id int unsigned, -- Who made the change
action_type varchar(50) not null, -- E.g., 'UPDATE', 'INSERT', 'DELETE'
table_name varchar(50) not null,
record_id int unsigned not null, -- ID of the record changed
action_timestamp datetime default current_timestamp,
old_value text,
new_value text,
foreign key (staff_id) references staff(staff_id)
);
use uhg_db;
create table if not exists roles (
role_id int unsigned auto_increment primary key,
role_name varchar(20) not null unique, 
description varchar(100)
);
create table if not exists staff_roles (
staff_id int unsigned not null,
role_id int unsigned not null,
primary key (staff_id, role_id),
foreign key (staff_id) references staff(staff_id),
foreign key (role_id) references roles(role_id)
);
create table if not exists inventory (
item_id int unsigned auto_increment primary key,
item_name varchar(20) not null unique,
item_type varchar(10), 
quantity_in_stock int unsigned not null default 0,
unit_cost decimal(10, 2),
reorder_point int unsigned, 
supplier_id int unsigned, 
foreign key (supplier_id) references supplier(supplier_id)
);
alter table staff
add constraint
foreign key (department_id)
references departments(dept_id);
alter table patients
add constraint chk_patient_gender
check (patient_gender IN ('M','F','O'));
alter table staff 
drop column department;
delete from staff
where email = 'naveen@gmail.com';
insert into staff (staff_name, staff_contact, staff_position, email)
values ('Naveen Kumar', '34232432', 'Doctor', 'naveen@gmail.com');
alter table staff
add column department_id int unsigned not null default 1;
alter table staff
add constraint fk_staff_department
foreign key (department_id) references departments(dept_id);
alter table staff
drop column department;
alter table staff
add column department_id int unsigned;
describe staff;

