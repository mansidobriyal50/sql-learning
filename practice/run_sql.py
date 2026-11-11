import sys
import duckdb

con = duckdb.connect("data/practice.duckdb")
text = open(sys.argv[1]).read()
for stmt in text.split(";"):
    if stmt.strip():
        print(">>", stmt.strip())
        result = con.sql(stmt)
        if result is not None:
            result.show()