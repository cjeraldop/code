DROP TABLE IF EXISTS escapes;

CREATE TABLE IF NOT EXISTS escapes
(
  backslash   VARCHAR(25),
  newline     VARCHAR(35),
  tab         VARCHAR(35),
  missing_data      VARCHAR(35)  ---NULL
);

COPY escapes
FROM 's3://tutorial.samples/redshift/copy.simplejson/char.json' WITH credentials 'aws_access_key_id=AKIAITWREFJYIOU3ESTQ;aws_secret_access_key=UBjfL9y6r8ijBa+YhS/Uta6OII+crSO5cBfj2KWk' format
AS
JSON 'auto';

SELECT * FROM escapes;
SELECT * FROM escapes WHERE missing_data is null;

/*
COPY maps the data elements in the JSON source data to the columns in the target table by matching object keys, or names, 
in the source name/value pairs to the names of columns in the target table. The matching is case-sensitive. 
Column names in Amazon Redshift tables are always lowercase, so when you use the ‘auto’ option, matching JSON field names must also be lowercase. 
If the JSON field name keys are not all lowercase, you can use a JSONPaths file to explicitly map column names to JSON field name keys.
*/


