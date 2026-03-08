# SQL Performance Optimization - Task 11

This project demonstrates how to optimize SQL query performance using indexes in MySQL. It includes a script to generate a large dataset and compares query execution times before and after indexing.

## Project Structure

- `task11.sql`: The main SQL script containing table creation, data insertion, and performance testing queries.
- `README.md`: Project documentation.

## Getting Started

### Prerequisites

- MySQL Server installed and running.
- MySQL Workbench or any SQL client.

### Steps to Run

1. **Create Database and Table**: Run the first part of `task11.sql` to create the `task11` database and the `employees` table.
2. **Generate Data**: The script includes an `INSERT` statement that uses a cross-join to generate 100,000 rows of sample data.
3. **Test Performance (Before Index)**:
   - Run the `SELECT` query on the `department` column.
   - Use `EXPLAIN` to see the execution plan (look for `type: ALL` indicating a full table scan).
4. **Apply Indexing**:
   - Create an index on the `department` column: `CREATE INDEX idx_department ON employees(department);`.
5. **Test Performance (After Index)**:
   - Re-run the same `SELECT` query.
   - Use `EXPLAIN` to see the improvement (look for `type: ref` and `key: idx_department`).
6. **Multi-Column Index**: Explore composite indexes with the `department` and `salary` columns.

## Key Concepts Demonstrated

- **Full Table Scan vs. Index Lookup**: Visualizing performance bottlenecks.
- **`EXPLAIN` Statement**: Understanding how MySQL executes queries.
- **Single vs. Composite Indexes**: Choosing the right index for complex queries.
- **Index Maintenance**: Understanding how indexes can slow down `INSERT` operations.
