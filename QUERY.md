# Vehicle Rental System db - Query Results & Explanations

This document provides sample outputs and detailed explanations for all SQL queries in the Vehicle Rental System project.

---

## 📊 Sample Database Content

Before showing query results, here's an overview of our sample data:

### Users Table (Sample Data)

| user_id | name         | email            | role     |
| ------- | ------------ | ---------------- | -------- |
| 1       | Khalid Hasan | khalid@email.com | Customer |
| 2       | Sahm         | sham@email.com   | Customer |
| 3       | Arman Khan   | arman@email.com  | Customer |
| 4       | Admin User   | admin@rental.com | Admin    |

### Vehicles Table (Sample Data)

| vehicle_id | vehicle_name    | vehicle_type | model | registration_number | rental_price_per_day | availability_status |
| ---------- | --------------- | ------------ | ----- | ------------------- | -------------------- | ------------------- |
| 1          | Toyota Camry    | car          | 2023  | ABC-1234            | 50.00                | rented              |
| 2          | Honda Civic     | car          | 2022  | XYZ-5678            | 45.00                | available           |
| 3          | Yamaha R15      | bike         | 2023  | BIKE-001            | 25.00                | available           |
| 4          | Ford F-150      | truck        | 2021  | TRUCK-999           | 80.00                | maintenance         |
| 5          | Tesla Model 3   | car          | 2024  | TESLA-123           | 100.00               | available           |
| 6          | Harley Davidson | bike         | 2022  | HD-2022             | 60.00                | available           |

### Bookings Table (Sample Data)

| booking_id | user_id | vehicle_id | start_date | end_date   | booking_status | total_cost |
| ---------- | ------- | ---------- | ---------- | ---------- | -------------- | ---------- |
| 1          | 1       | 1          | 2026-01-01 | 2026-01-05 | confirmed      | 200.00     |
| 2          | 2       | 1          | 2026-01-10 | 2026-01-15 | completed      | 250.00     |
| 3          | 1       | 3          | 2026-01-02 | 2026-01-04 | completed      | 50.00      |
| 4          | 3       | 1          | 2026-01-20 | 2026-01-25 | pending        | 250.00     |
| 5          | 2       | 5          | 2026-01-15 | 2026-01-18 | confirmed      | 300.00     |

---

## Query 1: JOIN - Retrieve Booking Information

### 📝 Query Objective

Retrieve complete booking information along with customer name and vehicle name by joining three tables.

### 🔧 SQL Query

```sql
SELECT
    b.booking_id,
    u.name AS customer_name,
    u.email AS customer_email,
    v.vehicle_name,
    v.vehicle_type,
    v.registration_number,
    b.start_date,
    b.end_date,
    b.booking_status,
    b.total_cost
FROM Bookings b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Vehicles v ON b.vehicle_id = v.vehicle_id;
```

### 📊 Sample Output

| booking_id | customer_name | customer_email    | vehicle_name  | vehicle_type | registration_number | start_date | end_date   | booking_status | total_cost |
| ---------- | ------------- | ----------------- | ------------- | ------------ | ------------------- | ---------- | ---------- | -------------- | ---------- |
| 1          | khalid hasan  | khalid@email.com  | Toyota Camry  | car          | ABC-1234            | 2026-01-01 | 2026-01-05 | confirmed      | 200.00     |
| 2          | sham          | sham@email.com    | Toyota Camry  | car          | ABC-1234            | 2026-01-10 | 2026-01-15 | completed      | 250.00     |
| 3          | khalid hasan  | khalid @email.com | Yamaha R15    | bike         | BIKE-001            | 2026-01-02 | 2026-01-04 | completed      | 50.00      |
| 4          | Arman         | Arman@email.com   | Toyota Camry  | car          | ABC-1234            | 2026-01-20 | 2026-01-25 | pending        | 250.00     |
| 5          | sham          | sham@email.com    | Tesla Model 3 | car          | TESLA-123           | 2026-01-15 | 2026-01-18 | confirmed      | 300.00     |

### 💡 Explanation

- **INNER JOIN** combines three tables: Bookings, Users, and Vehicles
- Shows all bookings with corresponding customer and vehicle information
- Only displays records where all three tables have matching data
- Result: 5 rows showing complete booking details with customer names and vehicle names

### 🎯 Concepts Used

- INNER JOIN
- Multiple table joins
- Column aliasing (AS)
- Foreign key relationships

---

## Query 2: EXISTS - Find Vehicles Never Booked

### 📝 Query Objective

Identify all vehicles that have never been booked (no records in Bookings table).

### 🔧 SQL Query

```sql
SELECT
    v.vehicle_id,
    v.vehicle_name,
    v.vehicle_type,
    v.model,
    v.registration_number,
    v.rental_price_per_day,
    v.availability_status
FROM Vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM Bookings b
    WHERE b.vehicle_id = v.vehicle_id
);
```

### 📊 Sample Output

| vehicle_id | vehicle_name    | vehicle_type | model | registration_number | rental_price_per_day | availability_status |
| ---------- | --------------- | ------------ | ----- | ------------------- | -------------------- | ------------------- |
| 2          | Honda Civic     | car          | 2022  | XYZ-5678            | 45.00                | available           |
| 4          | Ford F-150      | truck        | 2021  | TRUCK-999           | 80.00                | maintenance         |
| 6          | Harley Davidson | bike         | 2022  | HD-2022             | 60.00                | available           |

### 💡 Explanation

- **NOT EXISTS** checks if a vehicle has NO bookings in the Bookings table
- Subquery returns 1 if a booking exists for that vehicle
- If subquery returns nothing (no bookings), the vehicle is included in results
- Result: 3 vehicles that have never been booked
- These vehicles might need marketing attention or price adjustment

### 🎯 Concepts Used

- NOT EXISTS
- Correlated subquery
- Subquery execution for each row

### 📈 Business Insight

This query helps identify:

- Underutilized inventory
- Vehicles that may need price reduction
- New vehicles not yet marketed
- Vehicles that might need better positioning

---

## Query 3: WHERE - Available Vehicles by Type

### 📝 Query Objective

Retrieve all available vehicles filtered by a specific type (e.g., cars).

### 🔧 SQL Query

```sql
SELECT
    v.vehicle_id,
    v.vehicle_name,
    v.vehicle_type,
    v.model,
    v.registration_number,
    v.rental_price_per_day,
    v.availability_status
FROM Vehicles v
WHERE v.vehicle_type = 'car'
  AND v.availability_status = 'available';
```

### 📊 Sample Output (Cars)

| vehicle_id | vehicle_name  | vehicle_type | model | registration_number | rental_price_per_day | availability_status |
| ---------- | ------------- | ------------ | ----- | ------------------- | -------------------- | ------------------- |
| 2          | Honda Civic   | car          | 2022  | XYZ-5678            | 45.00                | available           |
| 5          | Tesla Model 3 | car          | 2024  | TESLA-123           | 100.00               | available           |

### 📊 Sample Output (Bikes)

```sql
WHERE v.vehicle_type = 'bike' AND v.availability_status = 'available';
```

| vehicle_id | vehicle_name    | vehicle_type | model | registration_number | rental_price_per_day | availability_status |
| ---------- | --------------- | ------------ | ----- | ------------------- | -------------------- | ------------------- |
| 3          | Yamaha R15      | bike         | 2023  | BIKE-001            | 25.00                | available           |
| 6          | Harley Davidson | bike         | 2022  | HD-2022             | 60.00                | available           |

### 📊 Sample Output (Trucks)

```sql
WHERE v.vehicle_type = 'truck' AND v.availability_status = 'available';
```

| vehicle_id                                         | vehicle_name | vehicle_type | model | registration_number | rental_price_per_day | availability_status |
| -------------------------------------------------- | ------------ | ------------ | ----- | ------------------- | -------------------- | ------------------- |
| (No results - the only truck is under maintenance) |

### 💡 Explanation

- **WHERE** clause filters records based on two conditions:
  1. Vehicle type matches the specified type (car/bike/truck)
  2. Availability status is 'available'
- **AND** operator ensures both conditions must be true
- Result for cars: 2 vehicles available for rent
- Result for bikes: 2 vehicles available for rent
- Result for trucks: 0 vehicles (Ford F-150 is under maintenance)

### 🎯 Concepts Used

- SELECT statement
- WHERE clause
- AND logical operator
- String comparison
- Multiple condition filtering

### 📈 Business Use Case

This query is used when:

- Customer searches for available vehicles by category
- Website displays rental options filtered by type
- Mobile app shows available inventory
- Call center checks vehicle availability

---

## Query 4: GROUP BY and HAVING - Popular Vehicles

### 📝 Query Objective

Find vehicles that have been booked more than 2 times (identify popular vehicles).

### 🔧 SQL Query

```sql
SELECT
    v.vehicle_id,
    v.vehicle_name,
    v.vehicle_type,
    v.model,
    v.registration_number,
    COUNT(b.booking_id) AS total_bookings
FROM Vehicles v
INNER JOIN Bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.vehicle_name, v.vehicle_type, v.model, v.registration_number
HAVING COUNT(b.booking_id) > 2
ORDER BY total_bookings DESC;
```

### 📊 Sample Output

| vehicle_id | vehicle_name | vehicle_type | model | registration_number | total_bookings |
| ---------- | ------------ | ------------ | ----- | ------------------- | -------------- |
| 1          | Toyota Camry | car          | 2023  | ABC-1234            | 3              |

### 💡 Explanation

- **INNER JOIN** connects Vehicles and Bookings tables
- **GROUP BY** groups all bookings by vehicle
- **COUNT(b.booking_id)** counts how many bookings each vehicle has
- **HAVING** filters groups to show only vehicles with more than 2 bookings
- **ORDER BY** sorts results by booking count (most popular first)
- Result: Only Toyota Camry has more than 2 bookings (it has 3)

### 📊 All Vehicles with Booking Counts (Extended View)

If we remove the HAVING clause to see all vehicles:

| vehicle_id | vehicle_name    | vehicle_type | total_bookings |
| ---------- | --------------- | ------------ | -------------- |
| 1          | Toyota Camry    | car          | 3              |
| 3          | Yamaha R15      | bike         | 1              |
| 5          | Tesla Model 3   | car          | 1              |
| 2          | Honda Civic     | car          | 0              |
| 4          | Ford F-150      | truck        | 0              |
| 6          | Harley Davidson | bike         | 0              |

### 🎯 Concepts Used

- INNER JOIN
- GROUP BY clause
- HAVING clause (filters after grouping)
- COUNT() aggregate function
- ORDER BY with aggregate column

### 📊 Difference: WHERE vs HAVING

**WHERE** - Filters individual rows BEFORE grouping:

```sql
WHERE booking_status = 'confirmed'  -- Filters rows first
GROUP BY vehicle_id
```

**HAVING** - Filters grouped results AFTER grouping:

```sql
GROUP BY vehicle_id
HAVING COUNT(booking_id) > 2  -- Filters groups after counting
```

### 📈 Business Insights

This query helps identify:

- **Most popular vehicles** - Toyota Camry is the most demanded
- **High-demand inventory** - Consider purchasing more similar vehicles
- **Pricing opportunities** - Popular vehicles might support price increases
- **Fleet expansion** - Focus on popular vehicle types
- **Marketing success** - Which vehicles resonate with customers

### 💼 Strategic Decisions Based on Results

1. **Toyota Camry (3 bookings):**

   - High demand - consider raising price
   - Purchase additional similar models
   - Ensure excellent maintenance for customer satisfaction

2. **Single booking vehicles:**

   - Yamaha R15, Tesla Model 3 - monitor performance
   - May need marketing boost or price adjustment

3. **Never booked vehicles:**
   - Honda Civic, Ford F-150, Harley Davidson
   - Review pricing strategy
   - Increase marketing efforts
   - Consider different vehicle types

---

## 🔄 Query Comparison Summary

| Query   | Main Technique    | Purpose                                 | Filters                   | Result Count  |
| ------- | ----------------- | --------------------------------------- | ------------------------- | ------------- |
| Query 1 | INNER JOIN        | Combine booking, user, and vehicle data | None                      | 5 rows        |
| Query 2 | NOT EXISTS        | Find vehicles never booked              | Vehicles without bookings | 3 rows        |
| Query 3 | WHERE             | Find available vehicles by type         | Type + availability       | 2 rows (cars) |
| Query 4 | GROUP BY + HAVING | Find popular vehicles                   | Bookings > 2              | 1 row         |

---

## 🎓 Key Learning Points

### 1. JOIN Operations

- Combines data from multiple tables
- INNER JOIN returns only matching records
- Essential for relational database queries

### 2. Subqueries with EXISTS

- Checks for existence of related records
- More efficient than JOIN for existence checks
- NOT EXISTS finds records without relationships

### 3. Filtering with WHERE

- Filters individual rows
- Applied before any grouping
- Can use multiple conditions with AND/OR

### 4. Aggregation with GROUP BY

- Combines rows into summary groups
- Used with aggregate functions (COUNT, SUM, AVG)
- HAVING filters after grouping (WHERE filters before)

---

## 📝 Additional Query Examples

### Example 1: Total Revenue by Vehicle

```sql
SELECT
    v.vehicle_name,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_cost) AS total_revenue
FROM Vehicles v
INNER JOIN Bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_name
ORDER BY total_revenue DESC;
```

**Output:**
| vehicle_name | total_bookings | total_revenue |
|--------------|----------------|---------------|
| Toyota Camry | 3 | 700.00 |
| Tesla Model 3 | 1 | 300.00 |
| Yamaha R15 | 1 | 50.00 |

### Example 2: Customer Booking Statistics

```sql
SELECT
    u.name,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_cost) AS total_spent
FROM Users u
LEFT JOIN Bookings b ON u.user_id = b.user_id
GROUP BY u.name
ORDER BY total_bookings DESC;
```

**Output:**
| name | total_bookings | total_spent |
|------|----------------|-------------|
| khalid hasan | 2 | 250.00 |
| sham | 2 | 550.00 |
| Arman | 1 | 250.00 |
| Admin User | 0 | 0.00 |

---

## 🧪 Testing Your Queries

### Step 1: Verify Table Structure

```sql
DESCRIBE Users;
DESCRIBE Vehicles;
DESCRIBE Bookings;
```

### Step 2: Check Sample Data

```sql
SELECT COUNT(*) FROM Users;
SELECT COUNT(*) FROM Vehicles;
SELECT COUNT(*) FROM Bookings;
```

### Step 3: Test Each Query

Run each query individually and verify:

- Correct number of rows returned
- Expected columns present
- Data makes logical sense
- No SQL errors

### Step 4: Validate Relationships

```sql
-- Check if all bookings have valid users
SELECT b.booking_id
FROM Bookings b
LEFT JOIN Users u ON b.user_id = u.user_id
WHERE u.user_id IS NULL;

-- Check if all bookings have valid vehicles
SELECT b.booking_id
FROM Bookings b
LEFT JOIN Vehicles v ON b.vehicle_id = v.vehicle_id
WHERE v.vehicle_id IS NULL;
```

---

## 📚 Conclusion

These queries demonstrate:

- ✅ Complex JOIN operations across multiple tables
- ✅ Subquery techniques with EXISTS
- ✅ Effective filtering with WHERE clause
- ✅ Data aggregation with GROUP BY and HAVING
- ✅ Real-world business analytics capabilities

Each query serves a specific business purpose and can be modified to handle different scenarios in a vehicle rental system.

---
