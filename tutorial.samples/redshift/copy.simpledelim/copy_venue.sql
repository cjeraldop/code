copy venue(venueid, venuename, venuecity, venuestate) 
from 's3://tutorial.samples/redshift/copy.simpledelim/venue.txt' 
credentials 'aws_access_key_id=AKIAITWREFJYIOU3ESTQ;aws_secret_access_key=UBjfL9y6r8ijBa+YhS/Uta6OII+crSO5cBfj2KWk'
region	'us-west-2'
delimiter ',';


/*
Governs automatic computation and refresh of optimizer statistics at the end of a successful COPY command. 
By default, if the STATUPDATE parameter is not used, statistics are updated automatically if the table is initially empty.

Whenever ingesting data into a nonempty table significantly changes the size of the table, 
we recommend updating statistics either by running an ANALYZE command or by using the STATUPDATE ON argument.
*/