package programas.pruebasDominios;

import java.sql.Connection;
import java.sql.SQLException;

import bbdd.ConexionOracle;
import daos.IvaDAO;
import domain.Iva;
import exceptions.DAOException;
import exceptions.DomainException;

public class ProbarIvas {

  public static void main(String[] args) {

    ConexionOracle c = null;
    Connection con = null;
    Iva iva = null;
    IvaDAO ivaDAO = null;

    try {
      // conexion a la bbdd
      c = new ConexionOracle();
      con = c.getConexion();

      // Objeto tipo IVA con datos (a capon)
      iva = new Iva();
      iva.setCod_iva("137");
      iva.setTipo_iva(99.99);

      // abrir conexion a la bbdd e insertar el IVA
      ivaDAO = new IvaDAO(con);
      ivaDAO.insertarIva(iva);

      System.out.println(iva);

      System.out.println("Todo OK");

    } catch (DomainException | DAOException e) { // capturamos errores de dominio
      if (e.getCause() == null) { // la exception la ha levantado el programador
        System.out.println(e.getMessage()); // Error Lógico para usuario
      } else {
        e.printStackTrace(); // para administrador
        System.out.println("Error interno"); // Error interno para usuario
      }
    } finally {
      try {
        if (con != null)
          con.close();
      } catch (SQLException e) {
        System.out.println("Error interno");
        e.printStackTrace();
      }
    }
  }
}
