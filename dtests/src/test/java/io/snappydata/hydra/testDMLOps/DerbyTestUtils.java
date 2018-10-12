package io.snappydata.hydra.testDMLOps;

import java.sql.Connection;
import java.sql.SQLException;

import com.gemstone.gemfire.LogWriter;
import hydra.HydraRuntimeException;
import hydra.HydraThreadLocal;
import hydra.Log;
import hydra.MasterController;
import hydra.Prms;
import hydra.ProcessMgr;
import hydra.TestConfig;
import sql.ClientDiscDBManager;
import sql.SQLHelper;
import util.TestException;
import util.TestHelper;

public class DerbyTestUtils {
  protected static Connection discConn=null;
  public static boolean hasDerbyServer = false;
  public static HydraThreadLocal derbyConnection = new HydraThreadLocal();
  public static HydraThreadLocal resetDerbyConnection = new HydraThreadLocal();
  //whether needs to reset the derby connection

  protected static DerbyTestUtils testInstance;
  public static SnappyDMLOpsUtil snappyDMLObj;

  protected static LogWriter log = null;

  public static void HydraTask_initialize() {
    try {
      Log.getLogWriter();
    } catch (HydraRuntimeException e) {
      String logName = "derbyLog_" + ProcessMgr.getProcessId();
      log = Log.createLogWriter( logName, "info" );
    }
    if (testInstance == null)
      testInstance = new DerbyTestUtils();
    hasDerbyServer = TestConfig.tab().booleanAt(Prms.manageDerbyServer, false);
    snappyDMLObj = new SnappyDMLOpsUtil();
  }

  /*
  Methods For derby setup - create and start derby instance, schema and tables in derby. Stop
  derby instance.
  */
  public static synchronized void HydraTask_createDerbyDB() {
    testInstance.createDerbyDB();
  }

  protected void createDerbyDB() {
    if (hasDerbyServer && discConn == null) {
      while (true) {
        try {
          discConn = ClientDiscDBManager.getConnection();
          break;
        } catch (SQLException se) {
          Log.getLogWriter().info("Not able to connect to Derby server yet, Derby server may not be ready.");
          SQLHelper.printSQLException(se);
          int sleepMS = 10000;
          MasterController.sleepForMs(sleepMS); //sleep 10 sec to wait for Derby server to be ready.
        }
      }
    }
  }

  public static void HydraTask_createDerbySchemas() {
    testInstance.createDerbySchema();
  }

  protected void createDerbySchema() {
    if (!hasDerbyServer) {
      Log.getLogWriter().info("manageDerbyServer is not set to true.");
      return;
    }
    Connection conn = getDerbyConnection();
    Log.getLogWriter().info("creating schemas on disc.");
    snappyDMLObj.createSchemas(conn,true);
    Log.getLogWriter().info("done creating schemas on disc.");
    closeDiscConnection(conn,true);
  }

  /**
   * To create tables in derby
   */

  public static synchronized void HydraTask_createDerbyTables(){
    testInstance.createDerbyTables();
  }

  protected void createDerbyTables() {
    if (!hasDerbyServer) {
      return;
    }
    Connection conn = getDerbyConnection();
    Log.getLogWriter().info("Creating tables in derby db.");
    snappyDMLObj.createTables(conn,true);
    //loadDerbyTables(conn);
    Log.getLogWriter().info("Done creating tables in derby db.");
    closeDiscConnection(conn,true);
  }


  public Connection getDerbyConnection() {
    try {
      Log.getLogWriter();
    } catch (HydraRuntimeException e) {
      String logName = "derbyLog_" + ProcessMgr.getProcessId();
      log = Log.createLogWriter( logName, "info" );
    }
    Connection conn = null;
    try {
      conn = (Connection)derbyConnection.get();
    } catch (NullPointerException npe) { //in case of sub threads
      conn = null;
    }
    try {
      if (conn == null || (Boolean)resetDerbyConnection.get() || conn.isClosed()) {
        Log.getLogWriter().info("derbyConnection is not set yet");
        try {
          conn = ClientDiscDBManager.getConnection();
        } catch (SQLException e) {
          SQLHelper.printSQLException(e);
          throw new TestException("Not able to get Derby Connection:\n " + TestHelper.getStackTrace(e));
        } catch(Exception e){
          Log.getLogWriter().info("Not able to get Derby Connection:\n " + TestHelper.getStackTrace(e));
        }
        derbyConnection.set(conn);
        resetDerbyConnection.set(false);
      }
    } catch (NullPointerException npe) {
      // /in case of sub threads
    } catch (Exception e) {
      throw new TestException("Exception while getting derby connection " + " : " + e.getMessage());
    }
    return conn;
  }

  public void closeDiscConnection(Connection conn, boolean end) {
    try {
      Log.getLogWriter();
    } catch (HydraRuntimeException e) {
      String logName = "derbyLog_" + ProcessMgr.getProcessId();
      log = Log.createLogWriter( logName, "info" );
    }
    //close the connection at end of the test
    if (end) {
      try {
        conn.commit();
        conn.close();
        Log.getLogWriter().info("closing the connection");
      } catch (SQLException e) {
        SQLHelper.printSQLException(e);
        throw new TestException ("Not able to release the connection " + TestHelper.getStackTrace(e));
      }
    }
  }

  public static void HydraTask_shutDownDerbyDB() {
    testInstance.shutDownDiscDB();
  }

  protected void shutDownDiscDB() {
    if (hasDerbyServer) {
      ClientDiscDBManager.shutDownDB();
    }
  }

}
