package programas.pruebasDominios;

import java.sql.Connection;
import java.sql.SQLException;

import bbdd.ConexionOracle;
import daos.TarifaDAO;
import domain.Tarifa;
import exceptions.DAOException;
import exceptions.DomainException;

public class ProbarTarifas {

  public static void main(String[] args) {

    ConexionOracle c = null;
    Connection con = null;
    Tarifa tarifa = null;
    TarifaDAO tarifaDAO = null;

    try {
      // conexion a la bbdd
      c = new ConexionOracle();
      con = c.getConexion();

      // Objeto tipo IVA con datos (a capon)
      tarifa = new Tarifa();
      tarifa.setCod_tarifa("5");
      tarifa.setDescripcion("Esto no es una descripcion");

      // abrir conexion a la bbdd e insertar el IVA
      tarifaDAO = new TarifaDAO(con);
      int modificado = tarifaDAO.borrarTarifaById("1");

      System.out.println(modificado);
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
