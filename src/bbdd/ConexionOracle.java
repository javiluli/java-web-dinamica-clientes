package bbdd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import exceptions.DAOException;

public class ConexionOracle {

  private Connection conexion = null;

  public ConexionOracle() throws DAOException {
    try {
      // nombre del controlador JDBC
      Class.forName("oracle.jdbc.driver.OracleDriver");

      // SQL developer TABLA Clientes
      conexion = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "javi", "1111");

    } catch (ClassNotFoundException e) {
      throw new DAOException("No se han encontrado los controladores", e);
    } catch (SQLException e) {
      throw new DAOException("No se ha podido conectar a la BBDD", e);
    }
  }

  public ConexionOracle(String url, String usuario, String passwd) throws DAOException {
    try {
      // nombre del controlador JDBC
      Class.forName("oracle.jdbc.driver.OracleDriver");
      // PARAMETROS => donde esta la BBDD | usuario | contraseña
      conexion = DriverManager.getConnection(url, usuario, passwd);
    } catch (ClassNotFoundException e) {
      throw new DAOException("No se han encontrado los controladores", e);
    } catch (SQLException e) {
      throw new DAOException("No se ha podido conectar a la BBDD", e);
    }
  }

  public Connection getConexion() {
    return conexion;
  }

}