## SQL Performance Tuning Using Indexes

### Tools Used

- MySQL Workbench

### What I Did

1. Created large dataset (100k rows)
2. Ran slow queries without indexes
3. Measured execution time
4. Added indexes on frequently filtered columns
5. Used EXPLAIN to compare execution plans
6. Studied cases where indexes hurt performance

### Key Learnings

- Indexes drastically reduce query execution time
- EXPLAIN helps understand how queries are executed
- Over-indexing degrades insert/update performance
