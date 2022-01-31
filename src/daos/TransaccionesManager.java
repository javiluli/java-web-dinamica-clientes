package daos;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Savepoint;

import bbdd.ConexionOracle;
import exceptions.DAOException;

public class TransaccionesManager {

  private Connection con;

  private static final String DB_ERR     = "Error de la base de datos";
  private static final String DB_CON_ERR = "Error al conectar con la base de datos";

  // para obtener la conexion del pool de conexiones, ver WEB.xml
  /*
   * public TransaccionesManager() throws DAOException { try { Context ctx = new
   * InitialContext(); DataSource ds = (DataSource)
   * ctx.lookup("java:comp/env/PoolDeConexiones"); con = ds.getConnection();
   * con.setAutoCommit(false); } catch (SQLException e) { throw new
   * DAOException(DB_ERR, e); } catch (NamingException e) { throw new
   * DAOException(DB_CON_ERR, e); } }
   */
  // la conexion la establezco con la clase ConexionOracle
  public TransaccionesManager() throws DAOException {

    // con = new ConexionOracle("jdbc:oracle:thin:@alfon-bb574d6f5:1521:oracle",
    // "adrian", "adrian").getConexion();
    con = new ConexionOracle().getConexion();

    try {
      con.setAutoCommit(false);
    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    }
  }

  public void closeCommit() throws DAOException {
    try {
      if (con != null) {
        con.commit();
        con.close();
      }
    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    }
  }

  public void commit() throws DAOException {
    try {
      if (con != null) {
        con.commit();
      }
    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    }
  }

  public void closeRollback() throws DAOException {
    try {
      if (con != null) {
        con.rollback();
        con.close();
      }
    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    }
  }

  public void rollback() throws DAOException {
    try {
      if (con != null) {
        con.rollback();
      }
    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    }
  }

  public void close() throws DAOException {
    try {
      if (con != null) {
        con.close();
      }

    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    }

  }

  public Savepoint savepoint() throws DAOException {
    Savepoint s = null;
    try {
      if (con != null) {
        s = con.setSavepoint();
      }
    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    }
    return s;
  }

  public void deshacerHastaSavepoint(Savepoint s) throws DAOException {
    try {
      if (con != null) {
        con.rollback(s);
      }
    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    }
  }

  public Connection getConexion() {
    return con;
  }

  public ClienteDAO getClienteDAO() {
    return new ClienteDAO(con);
  }

  public IvaDAO getIvaDAO() {
    return new IvaDAO(con);
  }

  public FormaPagoDAO getFormaPagoDAO() {
    return new FormaPagoDAO(con);
  }

  public TarifaDAO getTarifaDAO() {
    return new TarifaDAO(con);
  }

}
