package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import daos.interfaces.IIvaDAO;
import domain.Iva;
import exceptions.DAOException;
import recursos.DBQuery;
import recursos.Recursos;

public class IvaDAO implements IIvaDAO {

  private Connection con;

  public IvaDAO(Connection con) {
    this.con = con;
  }

  public Iva recuperarIva(Iva iva) throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    Iva objeto = null;

    try {
      st = con.prepareStatement(DBQuery.getSelectIva());
      st.setString(1, iva.getCod_iva());
      rs = st.executeQuery();
      if (rs.next()) {
        objeto = new Iva(rs.getString(1), rs.getDouble(2));
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
  public Iva recuperarIvaById(String codIva) throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    Iva objeto = null;

    try {
      st = con.prepareStatement(DBQuery.getSelectIva());
      st.setString(1, codIva);
      rs = st.executeQuery();
      if (rs.next()) {
        objeto = new Iva(rs.getString(1), rs.getDouble(2));
      }

    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    } finally {// cerramos cursores y ResulSet
      Recursos.closeResultSet(rs);
      Recursos.closePreparedStatement(st);

    }
    return objeto;
  }

  public List<Iva> recuperarTodosIva() throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    List<Iva> list = new ArrayList<Iva>();
    try {
      st = con.prepareStatement(DBQuery.getSelectAllIvas());
      rs = st.executeQuery();
      while (rs.next()) {
        list.add(new Iva(rs.getString(1), rs.getDouble(2)));
      }
    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    } finally {// cerramos cursores y ResulSet
      Recursos.closeResultSet(rs);
      Recursos.closePreparedStatement(st);
    }
    return list;
  }

  public void insertarIva(Iva iva) throws DAOException {
    PreparedStatement st = null;

    try {
      st = con.prepareStatement(DBQuery.getInsertIva());
      st.setString(1, iva.getCod_iva());
      st.setDouble(2, iva.getTipo_iva());

      // ejecutamos el insert
      st.executeUpdate();
    } catch (SQLException e) {
      if (e.getErrorCode() == ORACLE_DUPLICATE_PK) {
        throw new DAOException("El IVA ya existe");
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

  public int modificarIva(Iva iva) throws DAOException {
    PreparedStatement st = null;
    int modificado = 0;

    try {
      st = con.prepareStatement(DBQuery.getUpdateIva());
      st.setDouble(1, iva.getTipo_iva());
      st.setString(2, iva.getCod_iva());

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
  public int borrarIva(Iva iva) throws DAOException {
    PreparedStatement st = null;
    int borrado = 0;
    try {
      st = con.prepareStatement(DBQuery.getDeleteIva());
      st.setString(1, iva.getCod_iva());
      borrado = st.executeUpdate();
    } catch (SQLException e) {
      if (e.getErrorCode() == ORACLE_DELETE_FK) {
        throw new DAOException("No permitido borrar Iva");

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
  public int borrarIvaById(String iva) throws DAOException {
    PreparedStatement st = null;
    int borrado = 0;
    try {
      st = con.prepareStatement(DBQuery.getDeleteIva());
      st.setString(1, iva);
      borrado = st.executeUpdate();
    } catch (SQLException e) {
      if (e.getErrorCode() == ORACLE_DELETE_FK) {
        throw new DAOException("No permitido borrar Iva");

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
