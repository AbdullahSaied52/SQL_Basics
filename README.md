# SQL Architecture & Relational Query Reference Library

Welcome to the **SQL Architecture & Relational Query Reference Library**. This repository serves as a comprehensive, production-grade SQL script repository structured explicitly as an educational lookup matrix and technical reference guide. 

It organizes raw database scripts, relational architectures, system administration statements, and multi-layered analytical aggregations into distinct, searchable **Functional Blocks**. Whether you are studying foundational querying patterns or debugging complex relational trees, this layout allows you to locate exact technical implementations instantly via a simple keyword search (`Ctrl + F`).

---

## 📖 Library Architecture & Search Directory

The core script file is organized into 20 structural domains. Use the directory terms below to navigate the file:

| Functional Block ID | Functional Domain / Topic | Key SQL Commands Featured |
| :--- | :--- | :--- |
| **BLOCK 1** | Database Administration (Restore Operations) | `RESTORE DATABASE ... FROM DISK` |
| **BLOCK 2** | Basic Data Scanning & Discovery | `SELECT *` |
| **BLOCK 3** | Column Formulas & String Concatenations | `+`, Column Aliasing (`=`) |
| **BLOCK 4** | Row Limitation & Sampling Strategies | `TOP PERCENT`, `TOP N`, `BETWEEN` |
| **BLOCK 5** | Randomized Row Evaluations | `ORDER BY NEWID()` |
| **BLOCK 6** | Data Selection De-Duplication | `DISTINCT` |
| **BLOCK 7** | Value Record Filtration | `WHERE`, `AND`, `IN`, `IS NULL` |
| **BLOCK 8** | Alphanumeric Pattern Matching | `LIKE` Wildcards (`%`, `_`, `[]`) |
| **BLOCK 9** | Single & Multi-Key Row Re-Ordering | `ORDER BY ... ASC / DESC` |
| **BLOCK 10** | Metric Aggregations & Conditional Groups | `GROUP BY`, `HAVING`, `MIN`, `MAX`, `AVG` |
| **BLOCK 11** | Relational Cross-Table Links | `INNER JOIN`, `LEFT JOIN`, nested `ON` paths |
| **BLOCK 12** | Subqueries & Composite Nesting | Correlated `EXISTS`, Inline Derived Views, Scalars |
| **BLOCK 13** | Data Type Casting & Floating Ratios | `CAST(expression AS float)` |
| **BLOCK 14** | Intersection Set Combinations | `UNION` |
| **BLOCK 15** | Inline Conditional Workflows | `CASE WHEN ... THEN ... ELSE ... END` |
| **BLOCK 16** | System Clock Metrics | `YEAR(GETDATE())` Date Math |
| **BLOCK 17** | System Flag Existential Valuations | `WHERE EXISTS (SELECT TOP 1)` Boolean Flags |
| **BLOCK 18** | Recursive Parent-Child Structures | Self-Joins (`INNER` / `LEFT` Hierarchies) |
| **BLOCK 19** | Architectural Data Views | `CREATE VIEW` Abstraction Layers |
| **BLOCK 20** | Performance Tuning & Schema Optimization | `CREATE INDEX`, `DROP INDEX` |

---

## 🛠️ Schema Contexts & Core Concept Highlights

This library tests and validates queries against multiple relational data models, providing distinct structural implementations for each:

### 1. Human Resources & Corporate Hierarchies (`EmployeesDB`)
Demonstrates how to parse organizational charts, compute annual compensation packages, and map complex reporting chains.
* **Concept Highlight (Self-Joins):** Resolving recursive parent-child links by opening the same physical table twice under distinct aliases (`Employees` vs. `managers`) to match subordinates to their direct supervisors.

### 2. Normalized Fleet Operations & Automotive Specs (`ContactsDB`)
Features deep, multi-table structural join paths, statistical asset grouping, and performance metrics tracking across vehicle makes, models, sub-models, body styles, and fuel configurations.
* **Concept Highlight (Multi-Tiered Subqueries):** Nesting aggregate functions within subqueries to extract global mathematical extrema—such as identifying the absolute highest volume of distinct model lines managed by *any* singular manufacturer without hardcoding constraints.

### 3. Transactional E-Commerce Profiles (`shop_database`)
Contains relational operations combining demographics with sales records, utilizing existential validations to identify consumer behavior profiles.
* **Concept Highlight (Existential Filters):** Using `WHERE EXISTS` instead of standard joins to create highly optimized boolean checks that terminate row scans the moment a matching relational entry is located.

---

## 🚀 How to Use This Reference Library

1. **Code Preservation:** Every query is maintained exactly as written in the original production environment, ensuring zero syntax deviation or dropped conditions.
2. **Instant Searchability:** Open the script in your preferred Integrated Development Environment (IDE) or text editor and search for a specific technique using `Ctrl + F`.
   * *Example:* To learn how to convert integer math into decimal percentages without floor truncation errors, search for: `FUNCTIONAL BLOCK 13`.
   * *Example:* To review string pattern matching rules and wildcards, search for: `FUNCTIONAL BLOCK 8`.
3. **Cross-Platform Portability:** While tailored for standard relational T-SQL architectures (MS SQL Server), the core logical components—such as inner joins, aggregate loops, standard subqueries, and case workflows—are fully compatible across major SQL engines (PostgreSQL, MySQL, Oracle).