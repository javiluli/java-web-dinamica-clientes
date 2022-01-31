package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import daos.interfaces.IFormaPagoDAO;
import domain.FormaPago;
import exceptions.DAOException;
import recursos.DBQuery;
import recursos.Recursos;

public class FormaPagoDAO implements IFormaPagoDAO {

  private Connection con;

  public FormaPagoDAO(Connection con) {
    this.con = con;
  }

  @Override
  public FormaPago recuperarFormaPago(FormaPago formaPago) throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    FormaPago objeto = null;

    try {
      st = con.prepareStatement(DBQuery.getSelectFormaPago());
      st.setString(1, formaPago.getCodigo());
      rs = st.executeQuery();

      if (rs.next()) {
        Integer pdias = null;
        if (rs.getObject("dias") == null) {
          pdias = null;
        } else {
          pdias = rs.getInt("dias");
        }

        objeto = new FormaPago(rs.getString(1), rs.getInt(2), pdias);
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
  public FormaPago recuperarFormaPagoById(String codFormaPago) throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    FormaPago objeto = null;

    try {
      st = con.prepareStatement(DBQuery.getSelectFormaPago());
      st.setString(1, codFormaPago);
      rs = st.executeQuery();

      if (rs.next()) {
        Integer pdias = null;
        if (rs.getObject("dias") == null) {
          pdias = null;
        } else {
          pdias = rs.getInt("dias");
        }

        objeto = new FormaPago(rs.getString(1), rs.getInt(2), pdias);
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
  public List<FormaPago> recuperarTodosFormaPago() throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    List<FormaPago> list = new ArrayList<FormaPago>();

    try {
      st = con.prepareStatement(DBQuery.getSelectAllFormasPago());
      rs = st.executeQuery();
      while (rs.next()) {
        Integer pdias = null;
        if (rs.getObject("dias") == null) {
          pdias = null;
        } else {
          pdias = rs.getInt("dias");
        }
        list.add(new FormaPago(rs.getString(1), rs.getInt(2), pdias));
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
  public void insertarFormaPago(FormaPago formaPago) throws DAOException {
    PreparedStatement st = null;

    try {
      st = con.prepareStatement(DBQuery.getInsertFormaPago());
      st.setString(1, formaPago.getCodigo());
      st.setInt(2, formaPago.getNumero_vtos());

      // conversion para insertar un null
      if (formaPago.getDias() != null) {
        st.setInt(3, formaPago.getDias());
      } else {
        st.setNull(3, Types.INTEGER);
      }

      // ejecutamos el insert
      st.executeUpdate();
    } catch (SQLException e) {
      if (e.getErrorCode() == ORACLE_DUPLICATE_PK) {
        throw new DAOException("La forma de pago ya existe");
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
  public int modificarFormaPago(FormaPago formaPago) throws DAOException {
    PreparedStatement st = null;
    int modificado = 0;

    try {
      st = con.prepareStatement(DBQuery.getUpdateFormaPago());

      st.setInt(1, formaPago.getNumero_vtos());
      // conversion para insertar un null
      if (formaPago.getDias() != null) {
        st.setInt(2, formaPago.getDias());
      } else {
        st.setNull(2, Types.INTEGER);
      }

      st.setString(3, formaPago.getCodigo());

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

}
