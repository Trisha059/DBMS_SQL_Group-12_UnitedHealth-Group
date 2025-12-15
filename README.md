# DBMS_SQL_Group-12_UnitedHealth-Group
UnitedHealth Group operates across healthcare delivery, insurance services, and enterprise support functions. Managing patients, staff, insurance coverage, claims, billing, inventory, and compliance requires a well-structured and reliable data system.
This project focuses on designing a relational healthcare database using MySQL that reflects the core operations of a healthcare and insurance organization similar to UnitedHealth Group.
The database design emphasizes accurate data storage, clear relationships, auditability, and future scalability, while remaining practical for academic evaluation.

Project Objectives:
The main objectives of this project are to-
•⁠  ⁠Manage patient demographic and contact information efficiently
•⁠  ⁠Maintain staff records along with department and role structures
•⁠  ⁠Process insurance claims and monitor their status
•⁠  ⁠Record patient billing transactions
•⁠  ⁠Manage suppliers and medical inventory
•⁠  ⁠Maintain audit logs for compliance and traceability
To ensure data reliability and consistency, the database enforces primary keys, foreign keys, unique constraints, ENUMs, and validation rules, preventing invalid or inconsistent records from being stored.

System Design Overview
The database, named *uhg_db* follows a normalized relational design and is organized around key operational areas:
•⁠  ⁠Patients– Core patient information used across billing, enrollment, and claims
•⁠  ⁠Staff & Departments – Organizational hierarchy with role-based assignments
•⁠  ⁠Insurance & Enrollments– Policy definitions and coverage tracking
•⁠  Claims & Billing– Insurance claim processing and financial records
•⁠  ⁠Inventory & Suppliers– Medical stock and supplier management
•⁠  ⁠Audit Logs– Tracking critical data changes for accountability
Each table has a clearly defined responsibility, reducing redundancy and improving data clarity.

## Patient Management
The *patients* table stores essential patient details such as name, date of birth, gender, blood group, and contact information. Each patient is assigned a unique ⁠ patient_id ⁠, which acts as a reference point across billing, enrollments, and claims.
Validation rules ensure controlled values (for example, gender), and the design allows patient data to be stored once and reused across multiple operational processes.

## Staff, Departments, and Roles
The staff table maintains employee information including contact details, position, and email (enforced as unique). Departments are stored separately in the departments table and linked to staff using foreign keys, ensuring a clean organizational structure without data repetition.
Role-based access and responsibilities are handled using:
•⁠  ⁠roles table
•⁠  ⁠staff_roles junction table
This many-to-many relationship allows staff members to hold multiple roles if required, making the design flexible and realistic.

## Billing System
The billing table records financial transactions related to patients, including billing mode, amount, date, and staff involvement. Each billing record is linked to a valid patient using a foreign key, ensuring financial data remains consistent with patient records.
This structure supports billing analysis and revenue tracking.

## Insurance, Enrollments, and Claims

### Insurance Plans
The insurance_plans table defines available plans, categorized using controlled plan types such as HMO, PPO, EPO, and Medicare.
### Enrollments
The enrollments table links patients to insurance plans and stores member IDs along with coverage start and end dates. This allows historical tracking of plan changes over time.
### Claims
The claims table manages insurance claims raised against enrollments. It records service dates, submission dates, billed amounts, and claim status (submitted, pending, denied, or paid). Linking claims to enrollments ensures that only insured patients can generate claims.

## Medical Coding Support
To make the system more realistic, separate tables have been created for:
•⁠  ⁠procedures– Procedure codes, descriptions, and fees
•⁠  ⁠diagnoses– Diagnosis descriptions
These tables provide a foundation for extending the system to standardized medical coding practices in the future.

## Inventory and Supplier Management
The inventory table tracks medical equipment and supplies, including stock levels, unit cost, reorder points, and supplier references. Supplier information is stored separately in the *supplier* table, maintaining normalization and data integrity.
This design supports inventory monitoring and reorder planning.

## Audit Logs and Compliance
The audit_log table records critical data changes made by staff members. It captures the action type, affected table, record ID, timestamp, and before/after values. This feature supports accountability and compliance, which are essential in healthcare environments.

## Key Capabilities of the System
The database schema supports:
•⁠  ⁠Fast access to patient and staff records
•⁠  ⁠Efficient claim status tracking
•⁠  ⁠Clear department-wise staff mapping
•⁠  ⁠Billing and revenue reporting
•⁠  ⁠Inventory monitoring and reorder alerts
•⁠  ⁠Complete audit trails for compliance

## Conclusion
This project presents a structured healthcare database system aligned with UnitedHealth Group–style operations.
