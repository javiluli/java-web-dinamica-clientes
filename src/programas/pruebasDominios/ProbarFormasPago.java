package programas.pruebasDominios;

import java.sql.Connection;
import java.sql.SQLException;

import bbdd.ConexionOracle;
import daos.FormaPagoDAO;
import domain.FormaPago;
import exceptions.DAOException;
import exceptions.DomainException;

public class ProbarFormasPago {

  public static void main(String[] args) {
    ConexionOracle c = null;
    Connection con = null;
    FormaPago formaPago = null;
    FormaPagoDAO formaPagoDAO = null;

    try {

      // conexion a la bbdd
      c = new ConexionOracle();
      con = c.getConexion();

      formaPago = new FormaPago();
      formaPago.setCodigo("33333");
      formaPago.setNumero_vtos(45);
      formaPago.setDias(null);

      // abrir conexion a la bbdd e insertar el IVA
      formaPagoDAO = new FormaPagoDAO(con);
      formaPagoDAO.insertarFormaPago(formaPago);

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
