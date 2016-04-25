DROP TABLE IF EXISTS escapes;

CREATE TABLE IF NOT EXISTS escapes
(
  backslash      VARCHAR(25),
  newline        VARCHAR(35),
  tab            VARCHAR(35),
  missing_data   VARCHAR(35) ---NULL
);

COPY escapes
FROM 's3://tutorial.samples/redshift/copy.jsonpath/char.json' WITH credentials 'aws_access_key_id=AKIAITWREFJYIOU3ESTQ;aws_secret_access_key=UBjfL9y6r8ijBa+YhS/Uta6OII+crSO5cBfj2KWk' format
AS
JSON 's3://tutorial.samples/redshift/copy.jsonpath/char.jp.jsonpaths' MAXERROR 10;

SELECT *
FROM escapes;

SELECT *
FROM escapes
WHERE missing_data IS NULL;

SELECT DISTINCT tbl,
       TRIM(name) AS table_name,
       query,
       starttime,
       TRIM(filename) AS input,
       line_number,
       colname,
       err_code,
       TRIM(err_reason) AS reason
FROM stl_load_errors sl,
     stv_tbl_perm sp
WHERE sl.tbl = sp.id
AND   sp.name = 'escapes';

/*
JSONPaths file

If you are loading from JSON-formatted or Avro source data, by default COPY maps the first-level data elements in the source data to the columns in the target table by matching each name, or object key, in a name/value pair to the name of a column in the target table.

If your column names and object keys don't match, or to map to deeper levels in the data hierarchy, you can use a JSONPaths file to explicitly map JSON or Avro data elements to columns. The JSONPaths file maps JSON data elements to columns by matching the column order in the target table or column list.

The JSONPaths file must contain only a single JSON object (not an array). 
The JSON object is a name/value pair. The object key, which is the name in the name/value pair, must be "jsonpaths". 
The value in the name/value pair is an array of JSONPath expressions. Each JSONPath expression references a 
single element in the JSON data hierarchy or Avro schema, similarly to how an XPath expression refers to elements in an XML document. 
For more information, see JSONPath Expressions.

Note
If you are loading from Amazon S3 and the file specified by jsonpaths_file has the same prefix as the path 
specified by copy_from_s3_objectpath for the data files, COPY reads the JSONPaths file as a data file and returns errors. 
For example, if your data files use the 
object path s3://mybucket/my_data.json 
and your JSONPaths file is s3://mybucket/my_data.jsonpaths, 
COPY attempts to load my_data.jsonpaths as a data file.

Note
If the key name is any string other than "jsonpaths", the COPY command does not return an error, but it ignores jsonpaths_file and uses the 'auto' argument instead.

*/

