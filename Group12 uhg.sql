drop database if exists uhg_db;
create database uhg_db;
use uhg_db;

create table departments (
    dept_id tinyint unsigned auto_increment primary key,
    dept_name varchar(12) not null unique,
    department_head varchar(20),
    office_location varchar(10)
);

create table roles (
    role_id tinyint unsigned auto_increment primary key,
    role_name varchar(10) not null unique,
    description varchar(80)
);

create table insurance_plans (
    plan_id tinyint unsigned auto_increment primary key,
    plan_name varchar(20) not null unique,
    plan_type enum('hmo','ppo','epo','medicare') not null
);

create table patients (
    patient_id int unsigned auto_increment primary key,
    first_name varchar(15) not null,
    last_name varchar(15) not null,
    dob date not null,
    blood_group char(3),
    gender enum('m','f','o'),
    contact_number varchar(15) not null
);

create table staff (
    staff_id smallint unsigned auto_increment primary key,
    staff_name varchar(30) not null,
    staff_contact varchar(15) not null,
    staff_position enum('doctor','nurse','admin','technician') not null,
    dept_id tinyint unsigned not null,
    email varchar(30) not null unique,
    foreign key (dept_id) references departments(dept_id)
);

create table staff_roles (
    staff_id smallint unsigned,
    role_id tinyint unsigned,
    primary key (staff_id, role_id),
    foreign key (staff_id) references staff(staff_id),
    foreign key (role_id) references roles(role_id)
);

create table appointments (
    appointment_id int unsigned auto_increment primary key,
    patient_id int unsigned not null,
    staff_id smallint unsigned not null,
    appointment_datetime datetime not null,
    appointment_type varchar(30),
    status enum('scheduled','completed','cancelled','no_show') default 'scheduled',
    foreign key (patient_id) references patients(patient_id),
    foreign key (staff_id) references staff(staff_id)
);

create table procedures (
    procedure_id smallint unsigned auto_increment primary key,
    procedure_name varchar(20) not null unique,
    description varchar(80),
    fee decimal(7,2) not null
);

create table diagnoses (
    diagnosis_id smallint unsigned auto_increment primary key,
    description varchar(80) not null
);

create table appointment_procedures (
    appointment_id int unsigned,
    procedure_id smallint unsigned,
    primary key (appointment_id, procedure_id),
    foreign key (appointment_id) references appointments(appointment_id),
    foreign key (procedure_id) references procedures(procedure_id)
);

create table appointment_diagnoses (
    appointment_id int unsigned,
    diagnosis_id smallint unsigned,
    primary key (appointment_id, diagnosis_id),
    foreign key (appointment_id) references appointments(appointment_id),
    foreign key (diagnosis_id) references diagnoses(diagnosis_id)
);

create table supplier (
    supplier_id smallint unsigned auto_increment primary key,
    contact_name varchar(20),
    contact_no varchar(15) not null unique,
    email varchar(30),
    city varchar(15)
);

create table inventory (
    item_id smallint unsigned auto_increment primary key,
    item_name varchar(20) not null unique,
    quantity_in_stock smallint unsigned default 0,
    unit_cost decimal(7,2),
    reorder_point smallint unsigned,
    supplier_id smallint unsigned,
    foreign key (supplier_id) references supplier(supplier_id)
);

create table enrollments (
    enrollment_id int unsigned auto_increment primary key,
    patient_id int unsigned not null,
    plan_id tinyint unsigned not null,
    member_id varchar(20) not null unique,
    start_date date not null,
    end_date date,
    foreign key (patient_id) references patients(patient_id),
    foreign key (plan_id) references insurance_plans(plan_id)
);

create table claims (
    claim_id int unsigned auto_increment primary key,
    enrollment_id int unsigned not null,
    provider_id smallint unsigned not null,
    date_of_service date not null,
    submission_date date not null,
    billed_amount decimal(7,2) not null,
    status enum('submitted','pending','denied','paid') default 'submitted',
    foreign key (enrollment_id) references enrollments(enrollment_id),
    foreign key (provider_id) references staff(staff_id)
);

create table billing (
    billing_id int unsigned auto_increment primary key,
    patient_id int unsigned not null,
    staff_id smallint unsigned not null,
    billing_mode enum('cash','card','upi','insurance') not null,
    amount decimal(7,2) not null,
    billing_date date not null,
    foreign key (patient_id) references patients(patient_id),
    foreign key (staff_id) references staff(staff_id)
);

create table audit_log (
    log_id bigint unsigned auto_increment primary key,
    staff_id smallint unsigned,
    action_type enum('insert','update','delete') not null,
    table_name varchar(30) not null,
    record_id int unsigned not null,
    action_timestamp datetime default current_timestamp,
    old_value text,
    new_value text,
    foreign key (staff_id) references staff(staff_id)
);
