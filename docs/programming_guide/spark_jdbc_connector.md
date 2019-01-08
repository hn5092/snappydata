# Access SnappyData Tables from any Spark (2.1+) cluster

Spark applications can be run embedded inside the SnappyData cluster by submitting Jobs using **Snappy-Job.sh** or it can be run using the native [Smart Connector](../howto/spark_installation_using_smart_connector.md). However, from SnappyData 1.0.2 release the connector can only be used from a Spark 2.1 compatible cluster.
If you are using a Spark version or distribution that is based on a version higher than 2.1 then, you can use the **SnappyData JDBC Extension Connector** as described below. 

## Connecting Spark to SnappyData using Spark JDBC

Spark SQL supports reading and writing to databases using a built-in **JDBC data source**. Applications can configure and use JDBC like any other Spark data source queries return data frames and can easily be processed in Spark SQL or joined with other data sources. The JDBC data source is also easy to use from Java or Python.
All you need is a JDBC driver from the database vendor. Likewise, applications can use the Spark [data frame writer](link to Spark data frame writer) to insert, append, or replace a dataset in the database.

!!!Note
The usage model for the Spark JDBC data source is described [here](https://spark.apache.org/docs/2.1.1/sql-programming-guide.html#jdbc-to-other-databases) and we strongly recommend going through this section, if you are not familiar with how Spark works with data sources.

### Pushing Down Entire Query to the Database
When Spark queries are executed against external data sources, the current Spark model is only able to pushdown filters and projections in the query down to the database. If you are running an expensive aggregation on a large data set then the entire data set will be fetched into spark partitions and the query is executed inside your spark cluster. 
However, when you use a JDBC data source, you can pass entire queries or portions of the query entirely to the database such as shown in the following sample:

```
val pushdownQuery = "(select x, sum(y), max(z) from largeTable group by x order by x) t1";
spark.read.jdbc(jdbcUrl, pushDownQuery, connectionProperties);
```

### Deficiencies in the Spark JDBC connector
Unfortunately, there are issues with this approach which we address in the SnappyData JDBC Extension Connector. 

*	**Performance**</br>When an entire query is pushed down, Spark runs two queries:
	*	First it runs the query that is supplied to fetch the result set meta data so that it knows the structure of the data frame that is returned to the application.
	*	Secondly it runs the actual query.  
The Snappydata connector internally figures out the structure of the result set without having to run multiple queries.

*	**Lack of connection pooling**</br> With no built-in support for pooling connections, each time a query is executed against a JDBC database, each partition in Spark has to potentially setup a new connection which can be expensive. SnappyData internally uses a efficient pooled implementation with sensible defaults.

*	**Data manipulation**</br> While the Spark DataFrameWriter API can be used to append/insert a full dataset (data frame) to the database, it is not simple to run adhoc updates on the database including mass updates. The SnappyData connector extension makes this much simpler. 
*	**Usability**</br> With the SnappyData connector, it is easier to deal with all the connection properties. You do not have to pollute your application with sensitive properties sprinkled in your app code. 


### Connecting to Snappydata using the JDBC extension connector
Following is a sample of Spark JDBC extension setup and usage:
Include the snappydata-jdbc package in the Spark job with spark-submit or spark-shell: $SPARK_HOME/bin/spark-shell --packages SnappyDataInc:snappydata-jdbc:1.0.2.1-s_2.11 
Set the session properties. The SnappyData connection properties (to enable auto-configuration of JDBC URL) and credentials can be provided in Spark configuration itself, or set later in SparkSession to avoid passing them in all the method calls. These properties can also be provided in spark-defaults.conf along with all the other Spark properties. Following is a sample code of configuring the properties in SparkConf: $SPARK_HOME/bin/spark-shell --packages SnappyDataInc:snappydata-jdbc:1.0.2.1-s_2.11 --conf spark.snappydata.connection=localhost:1527 --conf spark.snappydata.user=<user> --conf spark.snappydata.password=<password> 
     // do note that, you can also set any of these properties in your app code.  Overloads of the above methods accepting user+password and host+port is also provided in case those properties are not set in the session or needs to be overridden. You can optionally pass additional connection properties similarly as in the DataFrameReader.jdbc method. 
Import the required implicits in the job/shell code as follows: import io.snappydata.sql.implicits._ 
## Running queries 
Your application must import the SnappyData SQL implicits when using Scala. 

import io.snappydata.sql.implicits._

Once the required session properties are set (connection and user/password like above), then one can just fire the required queries/DMLs without any other configuration.

Scala query example:

val spark = <create/access your spark session instance here >;
val dataset = spark.snappyQuery("select x, sum(y), max(z) from largeTable group by x order by x") // query pushed down to SnappyData data cluster

Java Query example:

import org.apache.spark.sql.*;

JdbcExecute exec = new JdbcExecute(< your SparkSession instance>);
DataFrame df = exec.snappyQuery("select x, sum(y), max(z) from largeTable group by x order by x") // query pushed down to SnappyData data cluster

Note: Overloads of the above methods accepting user+password and host+port have also been provided in case those properties are not set in the session or need to be overridden. User can optionally pass additional connection properties like in DataFrameReader.jdbc method.
(IMPORTANT: NEED A LINK TO THE API DOCS ... SUMEDH/NEERAJ ? )

## Updating/writing data in SnappyData tables
Your application can use the Spark [DataFrameWriter](link) API to either insert or append data. 


And, for convenience, the connector provides a implicit in scala for the DataFrameWriter to simplify writing to SnappyData - there is no need to explicitly set connection properties. 

import io.snappydata.sql.implicits._

Once the required session properties are set (connection and user/password like above), then one can just fire the required queries/DMLs without any other configuration.

Inserting a Dataset from the job can also use the “snappy” extension to avoid passing in URL and credentials explicitly:

df.write.snappy(“testTable1”)  // You can use all the Spark writer APIs when using the snappy implicit. 
Or using explicit wrapper in Java: new JdbcWriter(spark.write).snappy(“testTable”)


#### Using SQL DML to execute adhoc SQL 

You can also use the 'snappyExecute' method (see below) to run arbitrary SQL DML statements directly on the database. No need to acquire/manage explicit JDBC connections  or set properties. 


// execute DDL
spark.snappyExecute("create table testTable1 (id long, data string) using column")
// DML
spark.snappyExecute("insert into testTable1 values (1, ‘data1’)")
// bulk insert from external table in embedded mode
spark.snappyExecute("insert into testTable1 select * from externalTable1")


When using Java, the wrapper has to be created explicitly like below:

import org.apache.spark.sql.*;

JdbcExecute exec = new JdbcExecute(spark);
exec.snappyExecute(“create table testTable1 (id long, data string) using column”);
exec.snappyExecute("insert into testTable1 values (1, ‘data1’)");
...



### Comparison with current Spark APIs
 There is no equivalent of “snappyExecute” and one has to explicitly use JDBC API. For “snappyQuery”, if one were to use Spark’s jdbc connector directly then the equivalent code would look like below (assuming snappyExecute equivalent was done beforehand using JDBC API or otherwise):

val jdbcUrl = "jdbc:snappydata:pool://localhost:1527"
val connProps = new java.util.Properties()
connProps.setProperty("driver", "io.snappydata.jdbc.ClientPoolDriver")
connProps.setProperty("user", userName)
connProps.setProperty("password", password)

val df = spark.read.jdbc(jdbcUrl, “(select count(*) from testTable1) q”, connProps)

Besides being more verbose, this suffers from the problem of double query execution (first query to fetch query result metadata, followed by the actual query). 


## API Reference
The following extensions are used to implement the Spark JDBC Connector:
SparkSession.snappyQuery()  This method creates a wrapper over SparkSession and is similar to SparkSession.sql() API. The only difference between the both is that the entire query is pushed down to the SnappyData cluster. Hence, a query cannot have any temporary or external tables/views that are not visible in the SnappyData cluster. 
SparkSession.snappyExecute()  Similarly with this method, the SQL (assuming it to be a DML) is pushed to SnappyData, using the JDBC API, and returns the update count. 
snappy An implicit for DataFrameWriter named snappy simplifies the bulk writes. Therefore a write operation such as session.write.jdbc() becomes session.write.snappy() with the difference that JDBC URL, driver, and connection properties are auto-configured using session properties if possible. 

# Using SnappyData for any Spark Distribution

The **snappydata-jdbc Spark **package adds extensions to Spark’s inbuilt JDBC data source provider to work better with SnappyData. This allows SnappyData to be treated as a regular JDBC data source with all versions of Spark which are greater or equal to 2.1, while also providing speed to direct SnappyData embedded cluster for many types of queries.

The Spark JDBC connector gives the following advantages:

*	Transparent push down of queries to the SnappyData cluster such as Spark’s JDBC connection.
*	Avoids the double execution problem with the Spark's JDBC connection.
*	Provides better usability and the ability to execute DML statements using SparkSession, which is missing in Spark’s JDBC connector.
*	Compatibility with all versions of Spark which are greater or equal to version 2.1.
*	Good performance of shorter queries using the new [ClientDriver with an in-built pool implementation](/howto/connect_using_jdbc_driver.md#jdbcpooldriverconnect).

## Extensions of Spark JDBC Connector

SnappyData provides the extensions for Spark JDBC Connector in the form of Scala implicits that are wrapped into a SparkSession. For other languages such as Java and Python, you must create the wrapper explicitly.

The following extensions are used to implement the Spark JDBC Connector:

*	**SparkSession.snappyQuery()** </br>This method creates a wrapper over SparkSession and is similar to **SparkSession.sql()** API. The only difference between the both is that the entire query is pushed down to the SnappyData cluster. Hence, a query cannot have any temporary or external tables/views that are not visible in the SnappyData cluster.

*	**SparkSession.snappyExecute()** </br>Similarly with this method, the SQL (assuming it to be a DML) is pushed to SnappyData, using the JDBC API, and returns the update count.

*	**snappy**</br>An implicit for DataFrameWriter named **snappy** simplifies the bulk writes. Therefore a write operation such as **session.write.jdbc()** becomes **session.write.snappy()** with the difference that JDBC URL, driver, and connection properties are auto-configured using session properties if possible.

Refer the instructions [here](../howto/using_snappydata_for_any_spark_dist.md) to set up the Spark JDBC connector and to start using SnappyData with any Spark distribution.

## Spark JDBC Extension Versus Current Spark APIs

In the following points, a comparison is provided for scenarios where you use Spark JDBC Connector without the SnappyData extensions: 

*	You must use JDBC API, since there is nothing equivalent to **snappyExecute**.

*	when you use Spark’s JDBC connector directly instead of **snappyQuery**, then the equivalent code (assuming snappyExecute equivalent was done beforehand using JDBC API or otherwise) is as follows:

        val jdbcUrl = "jdbc:snappydata:pool://localhost:1527"
    	val connProps = new java.util.Properties()
    	connProps.setProperty("driver", "io.snappydata.jdbc.ClientPoolDriver")
   	 	connProps.setProperty("user", userName)
    	connProps.setProperty("password", password)

   		 val df = spark.read.jdbc(jdbcUrl, “(select count(*) from testTable1) q”, connProps)

	This code has verbosity and also presents the problem of double query execution (one with LIMIT 1 for schema, and one without) thereby increasing the execution time for many types of queries.
 
*	Inserting a Dataset from the job can also use the **snappy** extension to avoid passing in URL and credentials explicitly:

        df.write.snappy(“testTable1”)
        Or using explicit wrapper in Java: new JdbcWriter(spark.write).snappy(“testTable”)

	Using the Spark’s JDBC connector for the same is as follows:

		df.write.jdbc(jdbcUrl, “testTable1”, connProps)

	However, both of these are much slower as compared to SnappyData embedded job or smart connector. If the DataFrame to be written is medium or large sized, then it is better to ingest directly in an embedded mode.
In case writing an embedded job is not an option, the incoming DataFrame can be dumped to an external table in a location accessible to both Spark and SnappyData clusters. After this, it can be ingested in an embedded mode using **snappyExecute**. </br>The most efficient inbuilt format in Spark is Parquet, so for large DataFrames a much better option is as follows:

        df.write.parquet(“<path>”)
        spark.snappyExecute(“create external table stagingTable1 using parquet options (path ‘<path>’)”)
        spark.snappyExecute(“insert into testTable1 select * from stagingTable1”)
        spark.snappyExecute(“drop table stagingTable1”)
        // delete staging <path> if required e.g using hadoop API
        // FileSystem.get(sc.hadoopConfiguration).delete(new Path(“<path>”), true)

*	Similarly, you can address the lack of **putInto** or **deleteFrom** APIs in Spark. For this, you must dump the incoming DataFrames into a temporary staging area. Then create external tables in an embedded cluster to point to those DataFrames. After this, invoke the ** PUT INTO / DELETE FROM** SQL in the embedded cluster by using **snappyExecute** in the Spark cluster. The **PUT INTO** flow is similar to the **insert** example that is shown above.
       
       df.write.parquet(“<path>”)
            spark.snappyExecute(“create external table stagingTable1 using parquet options (path ‘<path>’)”)
            spark.snappyExecute(“put into testTable1 select * from stagingTable1”)
            spark.snappyExecute(“drop table stagingTable1”)
            // delete staging <path> if required e.g using hadoop API
            // FileSystem.get(sc.hadoopConfiguration).delete(new Path(“<path>”), true)

	**DELETE FROM **is also identical except that you must rename the key columns to match those in the target table before doing the operation. </br>Alternatively you can alias the key column names, if different, when selecting from the temporary staging table (in third step below).

            df.selectExpr(“keyColumn1 as …”).write.parquet(“<path>”)
            spark.snappyExecute(“create external table stagingTable1 using parquet options (path ‘<path>’)”)
            spark.snappyExecute(“delete from testTable1 select * from stagingTable1”)
            spark.snappyExecute(“drop table stagingTable1”)
            // delete staging <path> if required

