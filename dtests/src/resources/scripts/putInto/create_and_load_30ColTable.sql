DROP TABLE IF EXISTS testL;
create table testL (id string NOT NULL, data1 string, data2 decimal, APPLICATION_ID string NOT NULL, ORDERGROUPID string,
 PAYMENTADDRESS1 string, PAYMENTADDRESS2 string, PAYMENTCOUNTRY string, PAYMENTSTATUS string, PAYMENTRESULT string,
 PAYMENTZIP string, PAYMENTSETUP string, PROVIDER_RESPONSE_DETAILS string, PAYMENTAMOUNT string, PAYMENTCHANNEL string,
 PAYMENTCITY string, PAYMENTSTATECODE string,PAYMENTSETDOWN string,  PAYMENTREFNUMBER string, PAYMENTST string,
 PAYMENTAUTHCODE string,  PAYMENTID string, PAYMENTMERCHID string, PAYMENTHOSTRESPONSECODE string,PAYMENTNAME string,
 PAYMENTOUTLETID string, PAYMENTTRANSTYPE string,  PAYMENTDATE string, CLIENT_ID string, CUSTOMERID string)
using column options (partition_by 'id,APPLICATION_ID',COLUMN_MAX_DELTA_ROWS '1000',overflow 'true',key_columns 'id,APPLICATION_ID', BUCKETS '96');

DROP TABLE IF EXISTS testL1;
create table testL1 (id string NOT NULL, data string, data2 decimal, APPLICATION_ID string NOT NULL, ORDERGROUPID string,
 PAYMENTADDRESS1 string, PAYMENTADDRESS2 string, PAYMENTCOUNTRY string, PAYMENTSTATUS string, PAYMENTRESULT string,
 PAYMENTZIP string, PAYMENTSETUP string, PROVIDER_RESPONSE_DETAILS string, PAYMENTAMOUNT string, PAYMENTCHANNEL string,
 PAYMENTCITY string, PAYMENTSTATECODE string,PAYMENTSETDOWN string,  PAYMENTREFNUMBER string, PAYMENTST string,
 PAYMENTAUTHCODE string,  PAYMENTID string, PAYMENTMERCHID string, PAYMENTHOSTRESPONSECODE string,PAYMENTNAME string,
 PAYMENTOUTLETID string, PAYMENTTRANSTYPE string,  PAYMENTDATE string, CLIENT_ID string, CUSTOMERID string)
using column options (partition_by 'id,APPLICATION_ID',COLUMN_MAX_DELTA_ROWS '1000',overflow 'true',key_columns 'id,APPLICATION_ID', BUCKETS '96');

DROP TABLE IF EXISTS testL2;
create table testL2 (id string NOT NULL, data string, data2 decimal, APPLICATION_ID string NOT NULL, ORDERGROUPID string,
 PAYMENTADDRESS1 string, PAYMENTADDRESS2 string, PAYMENTCOUNTRY string, PAYMENTSTATUS string, PAYMENTRESULT string,
 PAYMENTZIP string, PAYMENTSETUP string, PROVIDER_RESPONSE_DETAILS string, PAYMENTAMOUNT string, PAYMENTCHANNEL string,
 PAYMENTCITY string, PAYMENTSTATECODE string,PAYMENTSETDOWN string,  PAYMENTREFNUMBER string, PAYMENTST string,
 PAYMENTAUTHCODE string,  PAYMENTID string, PAYMENTMERCHID string, PAYMENTHOSTRESPONSECODE string,PAYMENTNAME string,
 PAYMENTOUTLETID string, PAYMENTTRANSTYPE string,  PAYMENTDATE string, CLIENT_ID string, CUSTOMERID string)
using column options (partition_by 'id,APPLICATION_ID',COLUMN_MAX_DELTA_ROWS '1000',overflow 'true',key_columns 'id,APPLICATION_ID', BUCKETS '96');

DROP TABLE IF EXISTS testL3;
create table testL3 (id string NOT NULL, data string, data2 decimal, APPLICATION_ID string NOT NULL, ORDERGROUPID string,
 PAYMENTADDRESS1 string, PAYMENTADDRESS2 string, PAYMENTCOUNTRY string, PAYMENTSTATUS string, PAYMENTRESULT string,
 PAYMENTZIP string, PAYMENTSETUP string, PROVIDER_RESPONSE_DETAILS string, PAYMENTAMOUNT string, PAYMENTCHANNEL string,
 PAYMENTCITY string, PAYMENTSTATECODE string,PAYMENTSETDOWN string,  PAYMENTREFNUMBER string, PAYMENTST string,
 PAYMENTAUTHCODE string,  PAYMENTID string, PAYMENTMERCHID string, PAYMENTHOSTRESPONSECODE string,PAYMENTNAME string,
 PAYMENTOUTLETID string, PAYMENTTRANSTYPE string,  PAYMENTDATE string, CLIENT_ID string, CUSTOMERID string)
using column options (partition_by 'id,APPLICATION_ID',COLUMN_MAX_DELTA_ROWS '1000',overflow 'true',key_columns 'id,APPLICATION_ID', BUCKETS '96');

DROP TABLE IF EXISTS testL4;
create table testL4 (id string NOT NULL, data string, data2 decimal, APPLICATION_ID string NOT NULL, ORDERGROUPID string,
 PAYMENTADDRESS1 string, PAYMENTADDRESS2 string, PAYMENTCOUNTRY string, PAYMENTSTATUS string, PAYMENTRESULT string,
 PAYMENTZIP string, PAYMENTSETUP string, PROVIDER_RESPONSE_DETAILS string, PAYMENTAMOUNT string, PAYMENTCHANNEL string,
 PAYMENTCITY string, PAYMENTSTATECODE string,PAYMENTSETDOWN string,  PAYMENTREFNUMBER string, PAYMENTST string,
 PAYMENTAUTHCODE string,  PAYMENTID string, PAYMENTMERCHID string, PAYMENTHOSTRESPONSECODE string,PAYMENTNAME string,
 PAYMENTOUTLETID string, PAYMENTTRANSTYPE string,  PAYMENTDATE string, CLIENT_ID string, CUSTOMERID string)
using column options (partition_by 'id,APPLICATION_ID',COLUMN_MAX_DELTA_ROWS '1000',overflow 'true',key_columns 'id,APPLICATION_ID', BUCKETS '96');

DROP TABLE IF EXISTS testL5;
create table testL5 (id string NOT NULL, data string, data2 decimal, APPLICATION_ID string NOT NULL, ORDERGROUPID string,
 PAYMENTADDRESS1 string, PAYMENTADDRESS2 string, PAYMENTCOUNTRY string, PAYMENTSTATUS string, PAYMENTRESULT string,
 PAYMENTZIP string, PAYMENTSETUP string, PROVIDER_RESPONSE_DETAILS string, PAYMENTAMOUNT string, PAYMENTCHANNEL string,
 PAYMENTCITY string, PAYMENTSTATECODE string,PAYMENTSETDOWN string,  PAYMENTREFNUMBER string, PAYMENTST string,
 PAYMENTAUTHCODE string,  PAYMENTID string, PAYMENTMERCHID string, PAYMENTHOSTRESPONSECODE string,PAYMENTNAME string,
 PAYMENTOUTLETID string, PAYMENTTRANSTYPE string,  PAYMENTDATE string, CLIENT_ID string, CUSTOMERID string)
using column options (partition_by 'id,APPLICATION_ID',COLUMN_MAX_DELTA_ROWS '1000',overflow 'true',key_columns 'id,APPLICATION_ID', BUCKETS '96');

DROP TABLE IF EXISTS testL6;
create table testL6 (id string NOT NULL, data string, data2 decimal, APPLICATION_ID string NOT NULL, ORDERGROUPID string,
 PAYMENTADDRESS1 string, PAYMENTADDRESS2 string, PAYMENTCOUNTRY string, PAYMENTSTATUS string, PAYMENTRESULT string,
 PAYMENTZIP string, PAYMENTSETUP string, PROVIDER_RESPONSE_DETAILS string, PAYMENTAMOUNT string, PAYMENTCHANNEL string,
 PAYMENTCITY string, PAYMENTSTATECODE string,PAYMENTSETDOWN string,  PAYMENTREFNUMBER string, PAYMENTST string,
 PAYMENTAUTHCODE string,  PAYMENTID string, PAYMENTMERCHID string, PAYMENTHOSTRESPONSECODE string,PAYMENTNAME string,
 PAYMENTOUTLETID string, PAYMENTTRANSTYPE string,  PAYMENTDATE string, CLIENT_ID string, CUSTOMERID string)
using column options (partition_by 'id,APPLICATION_ID',COLUMN_MAX_DELTA_ROWS '1000',overflow 'true',key_columns 'id,APPLICATION_ID', BUCKETS '96');

DROP TABLE IF EXISTS testL7;
create table testL7 (id string NOT NULL, data string, data2 decimal, APPLICATION_ID string NOT NULL, ORDERGROUPID string,
 PAYMENTADDRESS1 string, PAYMENTADDRESS2 string, PAYMENTCOUNTRY string, PAYMENTSTATUS string, PAYMENTRESULT string,
 PAYMENTZIP string, PAYMENTSETUP string, PROVIDER_RESPONSE_DETAILS string, PAYMENTAMOUNT string, PAYMENTCHANNEL string,
 PAYMENTCITY string, PAYMENTSTATECODE string,PAYMENTSETDOWN string,  PAYMENTREFNUMBER string, PAYMENTST string,
 PAYMENTAUTHCODE string,  PAYMENTID string, PAYMENTMERCHID string, PAYMENTHOSTRESPONSECODE string,PAYMENTNAME string,
 PAYMENTOUTLETID string, PAYMENTTRANSTYPE string,  PAYMENTDATE string, CLIENT_ID string, CUSTOMERID string)
using column options (partition_by 'id,APPLICATION_ID',COLUMN_MAX_DELTA_ROWS '1000',overflow 'true',key_columns 'id,APPLICATION_ID', BUCKETS '96');

DROP TABLE IF EXISTS testL8;
create table testL8 (id string NOT NULL, data string, data2 decimal, APPLICATION_ID string NOT NULL, ORDERGROUPID string,
 PAYMENTADDRESS1 string, PAYMENTADDRESS2 string, PAYMENTCOUNTRY string, PAYMENTSTATUS string, PAYMENTRESULT string,
 PAYMENTZIP string, PAYMENTSETUP string, PROVIDER_RESPONSE_DETAILS string, PAYMENTAMOUNT string, PAYMENTCHANNEL string,
 PAYMENTCITY string, PAYMENTSTATECODE string,PAYMENTSETDOWN string,  PAYMENTREFNUMBER string, PAYMENTST string,
 PAYMENTAUTHCODE string,  PAYMENTID string, PAYMENTMERCHID string, PAYMENTHOSTRESPONSECODE string,PAYMENTNAME string,
 PAYMENTOUTLETID string, PAYMENTTRANSTYPE string,  PAYMENTDATE string, CLIENT_ID string, CUSTOMERID string)
using column options (partition_by 'id,APPLICATION_ID',COLUMN_MAX_DELTA_ROWS '1000',overflow 'true',key_columns 'id,APPLICATION_ID', BUCKETS '96');

DROP TABLE IF EXISTS testL9;
create table testL9 (id string NOT NULL, data string, data2 decimal, APPLICATION_ID string NOT NULL, ORDERGROUPID string,
 PAYMENTADDRESS1 string, PAYMENTADDRESS2 string, PAYMENTCOUNTRY string, PAYMENTSTATUS string, PAYMENTRESULT string,
 PAYMENTZIP string, PAYMENTSETUP string, PROVIDER_RESPONSE_DETAILS string, PAYMENTAMOUNT string, PAYMENTCHANNEL string,
 PAYMENTCITY string, PAYMENTSTATECODE string,PAYMENTSETDOWN string,  PAYMENTREFNUMBER string, PAYMENTST string,
 PAYMENTAUTHCODE string,  PAYMENTID string, PAYMENTMERCHID string, PAYMENTHOSTRESPONSECODE string,PAYMENTNAME string,
 PAYMENTOUTLETID string, PAYMENTTRANSTYPE string,  PAYMENTDATE string, CLIENT_ID string, CUSTOMERID string)
using column options (partition_by 'id,APPLICATION_ID',COLUMN_MAX_DELTA_ROWS '1000',overflow 'true',key_columns 'id,APPLICATION_ID', BUCKETS '96');

DROP TABLE IF EXISTS testL10;
create table testL10 (id string NOT NULL, data string, data2 decimal, APPLICATION_ID string NOT NULL, ORDERGROUPID string,
 PAYMENTADDRESS1 string, PAYMENTADDRESS2 string, PAYMENTCOUNTRY string, PAYMENTSTATUS string, PAYMENTRESULT string,
 PAYMENTZIP string, PAYMENTSETUP string, PROVIDER_RESPONSE_DETAILS string, PAYMENTAMOUNT string, PAYMENTCHANNEL string,
 PAYMENTCITY string, PAYMENTSTATECODE string,PAYMENTSETDOWN string,  PAYMENTREFNUMBER string, PAYMENTST string,
 PAYMENTAUTHCODE string,  PAYMENTID string, PAYMENTMERCHID string, PAYMENTHOSTRESPONSECODE string,PAYMENTNAME string,
 PAYMENTOUTLETID string, PAYMENTTRANSTYPE string,  PAYMENTDATE string, CLIENT_ID string, CUSTOMERID string)
using column options (partition_by 'id,APPLICATION_ID',COLUMN_MAX_DELTA_ROWS '1000',overflow 'true',key_columns 'id,APPLICATION_ID', BUCKETS '96');
