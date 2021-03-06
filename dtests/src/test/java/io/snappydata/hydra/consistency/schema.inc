io.snappydata.hydra.testDMLOps.SnappySchemaPrms-createSchemas = "create schema app";

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-createTablesStatements =
"create table app.table1 (id int, name varchar(20),code int, code1 double, code2 bigint, code3 varchar(30), disabled boolean, dis_time timestamp, tid int)"
"create table app.table2 (id int, name varchar(20),code int, code1 double, code2 bigint, code3 varchar(30), disabled boolean, dis_time date, tid int)"
"create table app.table3 (id int, name varchar(20),code int, code1 double, code2 bigint, code3 varchar(30), waitTime long, tid int)"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-uniqueColumnName =
"id"
"id"
"id"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-tablesList =
"app.table1"
"app.table2"
"app.table3"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-dmlTables =
"app.table1"
"app.table2"
"app.table3"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-insertStmts =
"insert into table1 values(?,?,?,?,?,?,?,?,?)"
"insert into table2 values(?,?,?,?,?,?,?,?,?)"
"insert into table3 values(?,?,?,?,?,?,?,?)"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-insertTables =
"app.table1"
"app.table2"
"app.table3"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-afterInsertSelects =
"select count(*), avg(code), sum(code), cast(sum(code1) as double) as sum_code1, cast(avg(code1) as double) as avg_code1 from table1"
"select count(*), avg(code), sum(code), cast(sum(code2) as double) as sum_code2, cast(avg(code2) as double) as avg_code2 from table2"
"select count(*), avg(code), sum(code), cast(sum(code2) as double) as sum_code1, cast(avg(code2) as double) as avg_code1 from table3"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-updateStmts =
"update table1 set code = case when code=-1 then 0 else (code+1) end , code1=code1 + 1"
"update table2 set code = case when code=-1 then 0 else (code+1) end , code2=code2 + 1"
"update table3 set code = case when code=-1 then 0 else (code+1) end , code3=code3 + 1 "
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-afterUpdateSelects =
"select count(*), avg(code), sum(code), cast(sum(code1) as double) as sum_code1, cast(avg(code1) as double) as avg_code1 from table1"
"select count(*), avg(code), sum(code), cast(sum(code2) as double) as sum_code2, cast(avg(code2) as double) as avg_code2 from table2"
"select count(*), avg(code), sum(code), cast(sum(code2) as double) as sum_code1, cast(avg(code2) as double) as avg_code1 from table3"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-updateTables =
"app.table1"
"app.table2"
"app.table3"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-deleteStmts =
"delete from table1 where id <= $counter"
"delete from table2 where id <= $counter"
"delete from table3 where id <= $counter"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-afterDeleteSelects =
"select count(*), avg(code), sum(code) from table1 where id <= $counter"
"select count(*), avg(code), sum(code) from table2 where id <= $counter"
"select count(*), avg(code), sum(code) from table3 where id <= $counter"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-deleteTables =
"app.table1"
"app.table2"
"app.table3"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-putIntoStmts =
"put into table1 values (?,?,?,?,?,?,?)"
"put into table2 values (?,?,?,?,?,?,?)"
"put into table3 values (?,?,?,?,?,?,?)"
;

io.snappydata.hydra.testDMLOps.SnappySchemaPrms-afterPutIntoSelects =
"select count(*), avg(code), sum(code), cast(sum(code1) as double) as sum_code1, cast(avg(code1) as double) as avg_code1 from table1"
"select count(*), avg(code), sum(code), cast(sum(code2) as double) as sum_code2, cast(avg(code2) as double) as avg_code2 from table2"
"select count(*), avg(code), sum(code), cast(sum(code2) as double) as sum_code1, cast(avg(code2) as double) as avg_code1 from table3"
;

