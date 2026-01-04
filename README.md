# Vehicle Rental System - Database Design & SQL Queries

## 📋 Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Database Design](#database-design)
- [ERD (Entity Relationship Diagram)](#erd-entity-relationship-diagram)
- [SQL Queries](#sql-queries)
- [Setup Instructions](#setup-instructions)
- [Theory Questions](#theory-questions)
- [Technologies Used](#technologies-used)

---

## 🎯 Overview

This project demonstrates a comprehensive **Vehicle Rental System** database design and implementation. It includes:

- Complete ERD with proper relationships
- SQL schema implementation
- Complex SQL queries (JOIN, EXISTS, WHERE, GROUP BY)
- Real-world business logic handling

### Objectives Achieved

✅ Designed ERD with 1-to-1, 1-to-Many, and Many-to-1 relationships  
✅ Implemented primary keys and foreign keys  
✅ Written SQL queries using JOIN, EXISTS, WHERE, GROUP BY, and HAVING  
✅ Handled real-world vehicle rental scenarios

---

## 📁 Project Structure

```
vehicle-rental-system-db-db/
│
├── sql/
│   ├── schema.sql           # Database table creation script
│   ├── data.sql             # Sample data insertion script
│   └── queries.sql          # All SQL queries (Query 1-4)
│
├── README.md                # Project documentation
└── QUERY.md                 # Sample query results and explanations

---

## 💾 Database Design

### Business Logic Handled

The database supports the following real-world scenarios:

#### Users Management
- Store user roles (Admin/Customer)
- Track name, email, password, phone number
- Enforce unique email addresses (no duplicate accounts)

#### Vehicle Management
- Store vehicle details (name, type, model)
- Unique registration numbers
- Track rental price per day
- Monitor availability status (available/rented/maintenance)

#### Booking Management
- Link bookings to users and vehicles
- Track rental start and end dates
- Manage booking status (pending/confirmed/completed/cancelled)
- Calculate total booking cost

---

## 🗂️ ERD (Entity Relationship Diagram)

### Tables Overview

#### 1. **Users Table**
| Column | Type | Constraints |
|--------|------|-------------|
| user_id | INT | PRIMARY KEY, AUTO_INCREMENT |
| name | VARCHAR(100) | NOT NULL |
| email | VARCHAR(100) | UNIQUE, NOT NULL |
| password | VARCHAR(255) | NOT NULL |
| phone | VARCHAR(15) | NOT NULL |
| role | ENUM('Admin', 'Customer') | NOT NULL |

#### 2. **Vehicles Table**
| Column | Type | Constraints |
|--------|------|-------------|
| vehicle_id | INT | PRIMARY KEY, AUTO_INCREMENT |
| vehicle_name | VARCHAR(100) | NOT NULL |
| vehicle_type | ENUM('car', 'bike', 'truck') | NOT NULL |
| model | VARCHAR(50) | NOT NULL |
| registration_number | VARCHAR(20) | UNIQUE, NOT NULL |
| rental_price_per_day | DECIMAL(10,2) | NOT NULL |
| availability_status | ENUM('available', 'rented', 'maintenance') | NOT NULL |

#### 3. **Bookings Table**
| Column | Type | Constraints |
|--------|------|-------------|
| booking_id | INT | PRIMARY KEY, AUTO_INCREMENT |
| user_id | INT | FOREIGN KEY → Users(user_id) |
| vehicle_id | INT | FOREIGN KEY → Vehicles(vehicle_id) |
| start_date | DATE | NOT NULL |
| end_date | DATE | NOT NULL |
| booking_status | ENUM('pending', 'confirmed', 'completed', 'cancelled') | NOT NULL |
| total_cost | DECIMAL(10,2) | NOT NULL |

### Relationships

```

Users (1) ──────→ (Many) Bookings
↓
(Many to 1)
↓
Vehicles (1) ←────── (Many) Bookings

````

**Relationship Details:**
- **One-to-Many**: One User can make many Bookings
- **Many-to-One**: Many Bookings belong to one Vehicle
- **One-to-One (Logical)**: Each Booking connects exactly one User and one Vehicle at a specific time

### ERD Submission
📎 **ERD Link:** [https://lucid.app/lucidchart/334e7393-138e-44b1-8f78-f1b2e1166476/edit?invitationId=inv_b24ee0a3-4dbf-4dca-b4c3-429ff4f217b4]

---

## 🔍 SQL Queries

### Query 1: JOIN - Retrieve Booking Information
**Objective:** Get booking details with customer name and vehicle name

```sql
SELECT
    b.booking_id,
    u.name AS customer_name,
    v.vehicle_name,
    b.start_date,
    b.end_date,
    b.booking_status,
    b.total_cost
FROM Bookings b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Vehicles v ON b.vehicle_id = v.vehicle_id;
````

**Concepts Used:** INNER JOIN

---

### Query 2: EXISTS - Find Unbooked Vehicles

**Objective:** Find all vehicles that have never been booked

```sql
SELECT
    vehicle_id,
    vehicle_name,
    vehicle_type,
    registration_number,
    rental_price_per_day
FROM Vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM Bookings b
    WHERE b.vehicle_id = v.vehicle_id
);
```

**Concepts Used:** NOT EXISTS, Subquery

---

### Query 3: WHERE - Available Vehicles by Type

**Objective:** Retrieve all available vehicles of a specific type (e.g., cars)

```sql
SELECT
    vehicle_id,
    vehicle_name,
    vehicle_type,
    model,
    registration_number,
    rental_price_per_day
FROM Vehicles
WHERE vehicle_type = 'car'
  AND availability_status = 'available';
```

**Concepts Used:** SELECT, WHERE

---

### Query 4: GROUP BY and HAVING - Popular Vehicles

**Objective:** Find vehicles with more than 2 bookings

```sql
SELECT
    v.vehicle_id,
    v.vehicle_name,
    v.vehicle_type,
    COUNT(b.booking_id) AS total_bookings
FROM Vehicles v
INNER JOIN Bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.vehicle_name, v.vehicle_type
HAVING COUNT(b.booking_id) > 2
ORDER BY total_bookings DESC;
```

**Concepts Used:** GROUP BY, HAVING, COUNT, INNER JOIN

---

## 🚀 Setup Instructions

### Prerequisites

- MySQL 8.0 or higher
- MySQL Workbench (optional)
- Basic understanding of SQL

### Installation Steps

1. **Clone or Download the Project**

   ```bash
   git clone https://github.com/MerchantKhalid/vehicle-rental-system-DB
   cd vehicle-rental-system-db
   ```

2. **Create Database**

   ```sql
   CREATE DATABASE vehicle_rental_system;
   USE vehicle_rental_system;
   ```

3. **Run Schema Script**

   ```bash
   mysql -u your_username -p vehicle_rental_system < schema.sql
   ```

4. **Insert Sample Data**

   ```bash
   mysql -u your_username -p vehicle_rental_system < sample_data.sql
   ```

5. **Execute Queries**
   ```bash
   mysql -u your_username -p vehicle_rental_system < queries.sql
   ```

### Verify Installation

```sql
-- Check tables
SHOW TABLES;

-- Check sample data
SELECT COUNT(*) FROM Users;
SELECT COUNT(*) FROM Vehicles;
SELECT COUNT(*) FROM Bookings;
```

---

## 📚 Theory Questions

### Question 1: Foreign Key Importance

**What is a foreign key and why is it important?**

A foreign key is a column in one table that refers to the primary key in another table. It's important because:

- **Maintains Data Integrity:** Ensures referential integrity between tables
- **Prevents Orphaned Records:** Can't delete a parent record if child records exist
- **Enforces Relationships:** Physically implements the logical relationships in the ERD
- **Example:** In our system, `user_id` in Bookings table is a foreign key that ensures every booking belongs to a valid user

---

### Question 2: WHERE vs HAVING

**What is the difference between WHERE and HAVING clauses?**

| Aspect                 | WHERE           | HAVING             |
| ---------------------- | --------------- | ------------------ |
| **Used With**          | Individual rows | Grouped rows       |
| **Timing**             | Before GROUP BY | After GROUP BY     |
| **Filters**            | Row-level data  | Aggregated results |
| **Can Use Aggregates** | No              | Yes                |

**Example:**

```sql
-- WHERE: Filters before grouping
SELECT vehicle_type, COUNT(*)
FROM Vehicles
WHERE availability_status = 'available'
GROUP BY vehicle_type;

-- HAVING: Filters after grouping
SELECT vehicle_type, COUNT(*) AS total
FROM Vehicles
GROUP BY vehicle_type
HAVING COUNT(*) > 5;
```

---

### Question 3: Primary Key Characteristics

**What is a primary key and its characteristics?**

A primary key is a unique identifier for each record in a table.

**Characteristics:**

- ✅ **Uniqueness:** No two rows can have the same primary key value
- ✅ **Not Null:** Primary key cannot contain NULL values
- ✅ **Immutable:** Should not change over time
- ✅ **Single per Table:** Only one primary key per table (can be composite)
- ✅ **Indexed:** Automatically creates an index for fast lookups

**Example:** `user_id` in Users table uniquely identifies each user

---

### Question 4: INNER JOIN vs LEFT JOIN

**What is the difference between INNER JOIN and LEFT JOIN?**

| Aspect             | INNER JOIN                          | LEFT JOIN                                      |
| ------------------ | ----------------------------------- | ---------------------------------------------- |
| **Returns**        | Only matching rows from both tables | All rows from left table + matching from right |
| **Unmatched Rows** | Excluded                            | Included (with NULL for right table)           |
| **Use Case**       | When you need only related data     | When you need all records from one table       |

**Visual Example:**

```
Table A: Users        Table B: Bookings
user_id  name         booking_id  user_id
1        Alice        101         1
2        Bob          102         1
3        Charlie

INNER JOIN: Returns 2 rows (Alice has bookings)
LEFT JOIN: Returns 3 rows (Charlie included with NULL bookings)
```

---

## 🛠️ Technologies Used

- **Database:** MySQL 8.0
- **ERD Tool:** Lucidchart
- **Documentation:** Markdown
- **Version Control:** Git

---

## 📝 Notes

- All queries have been tested with sample data
- ERD follows standard notation (Crow's Foot)
- Foreign key constraints are enforced
- Sample data includes multiple scenarios for testing
- See `QUERY.md` for detailed query results

---

## 👨‍💻 Author

**[MOHAMMAD KHALID HASAN]**  
**Assignment:** Vehicle Rental System - Database Design  
**Date:** January 2026

---

## 📄 License

This project is created for educational purposes as part of a database design assignment.

---

## 🤝 Acknowledgments

- Course instructor for assignment guidelines
- Lucidchart for ERD design tools
- MySQL documentation for SQL reference

---

**📌 Important Links:**

- [ERD Shareable Link](https://lucid.app/lucidchart/334e7393-138e-44b1-8f78-f1b2e1166476/edit?invitationId=inv_b24ee0a3-4dbf-4dca-b4c3-429ff4f217b4)
- [Query Results](./QUERY.md)
- [Database Schema](./schema.sql)
- [Sample Queries](./queries.sql)

---
