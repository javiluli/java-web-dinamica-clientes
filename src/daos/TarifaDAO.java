package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import daos.interfaces.ITarifaDAO;
import domain.Tarifa;
import exceptions.DAOException;
import recursos.DBQuery;
import recursos.Recursos;

public class TarifaDAO implements ITarifaDAO {

  private Connection con;

  public TarifaDAO(Connection con) {
    this.con = con;
  }

  @Override
  public Tarifa recuperarTarifa(Tarifa tarifa) throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    Tarifa objeto = null;

    try {
      st = con.prepareStatement(DBQuery.getSelectTarifa());
      st.setString(1, tarifa.getCod_tarifa());
      rs = st.executeQuery();
      if (rs.next()) {
        objeto = new Tarifa(rs.getString(1), rs.getString(2));
      }

    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    } finally {// cerramos cursores y ResulSet
      Recursos.closeResultSet(rs);
      Recursos.closePreparedStatement(st);
    }
    return objeto;
  }

  @Override
  public Tarifa recuperarTarifaById(String codTarifa) throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    Tarifa objeto = null;

    try {
      st = con.prepareStatement(DBQuery.getSelectTarifa());
      st.setString(1, codTarifa);
      rs = st.executeQuery();
      if (rs.next()) {
        objeto = new Tarifa(rs.getString(1), rs.getString(2));
      }

    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    } finally {// cerramos cursores y ResulSet
      Recursos.closeResultSet(rs);
      Recursos.closePreparedStatement(st);

    }
    return objeto;
  }

  @Override
  public List<Tarifa> recuperarTodosTarifa() throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    List<Tarifa> list = new ArrayList<Tarifa>();
    try {
      st = con.prepareStatement(DBQuery.getSelectAllTarifas());
      rs = st.executeQuery();
      while (rs.next()) {
        list.add(new Tarifa(rs.getString(1), rs.getString(2)));
      }
    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    } finally {// cerramos cursores y ResulSet
      Recursos.closeResultSet(rs);
      Recursos.closePreparedStatement(st);
    }
    return list;
  }

  @Override
  public void insertarTarifa(Tarifa tarifa) throws DAOException {
    PreparedStatement st = null;

    try {
      st = con.prepareStatement(DBQuery.getInsertTarifas());
      st.setString(1, tarifa.getCod_tarifa());
      st.setString(2, tarifa.getDescripcion());

      // ejecutamos el insert
      st.executeUpdate();
    } catch (SQLException e) {
      if (e.getErrorCode() == ORACLE_DUPLICATE_PK) {
        throw new DAOException("La tarifa ya existe");
      } else if (e.getErrorCode() >= 20000 && e.getErrorCode() <= 20999) {// para PL/SQL.triggers
        String cadena = e.toString().substring(e.toString().indexOf("ORA", 0) + 10);
        String cadena1 = cadena.substring(0, cadena.indexOf("ORA", 0));
        throw new DAOException(cadena1);
      } else {
        throw new DAOException(DB_ERR, e);
      }
    } finally {// cerramos cursores
      Recursos.closePreparedStatement(st);
    }

  }

  @Override
  public int modificarTarifa(Tarifa tarifa) throws DAOException {
    PreparedStatement st = null;
    int modificado = 0;

    try {
      st = con.prepareStatement(DBQuery.getUpdateTarifas());

      st.setString(1, tarifa.getDescripcion());
      st.setString(2, tarifa.getCod_tarifa());

      modificado = st.executeUpdate();
    } catch (SQLException e) {
      if (e.getErrorCode() >= 20000 && e.getErrorCode() <= 20999) {// para PL/SQL.triggers
        String cadena = e.toString().substring(e.toString().indexOf("ORA", 0) + 10);
        String cadena1 = cadena.substring(0, cadena.indexOf("ORA", 0));
        throw new DAOException(cadena1);
      } else {
        throw new DAOException(DB_ERR, e);
      }
    } finally {// cerramos cursores
      Recursos.closePreparedStatement(st);

    }
    return modificado;
  }

  @Override
  public int borrarTarifa(Tarifa tarifa) throws DAOException {
    PreparedStatement st = null;
    int borrado = 0;
    try {
      st = con.prepareStatement(DBQuery.getDeleteTarifas());
      st.setString(1, tarifa.getCod_tarifa());
      borrado = st.executeUpdate();
    } catch (SQLException e) {
      if (e.getErrorCode() == ORACLE_DELETE_FK) {
        throw new DAOException("No permitido borrar tarifa");

      } else if (e.getErrorCode() >= 20000 && e.getErrorCode() <= 20999) { // para PL/SQL.triggers
        String cadena = e.toString().substring(e.toString().indexOf("ORA", 0) + 10);
        String cadena1 = cadena.substring(0, cadena.indexOf("ORA", 0));
        throw new DAOException(cadena1);
      } else {
        throw new DAOException(DB_ERR, e);
      }
    } finally {
      Recursos.closePreparedStatement(st);
    }
    return borrado;
  }

  @Override
  public int borrarTarifaById(String tarifa) throws DAOException {
    PreparedStatement st = null;
    int borrado = 0;
    try {
      st = con.prepareStatement(DBQuery.getDeleteIva());
      st.setString(1, tarifa);
      borrado = st.executeUpdate();
    } catch (SQLException e) {
      if (e.getErrorCode() == ORACLE_DELETE_FK) {
        throw new DAOException("No permitido borrar tarifa");

      } else if (e.getErrorCode() >= 20000 && e.getErrorCode() <= 20999) {// para PL/SQL.triggers
        String cadena = e.toString().substring(e.toString().indexOf("ORA", 0) + 10);
        String cadena1 = cadena.substring(0, cadena.indexOf("ORA", 0));
        throw new DAOException(cadena1);
      } else {
        throw new DAOException(DB_ERR, e);
      }
    } finally {
      Recursos.closePreparedStatement(st);
    }
    return borrado;

  }

}
