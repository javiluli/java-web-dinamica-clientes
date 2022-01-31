package daos;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import daos.interfaces.IClienteDAO;
import domain.Cliente;
import domain.FormaPago;
import domain.Iva;
import domain.Tarifa;
import exceptions.DAOException;
import recursos.DBQuery;
import recursos.Recursos;

public class ClienteDAO implements IClienteDAO {

  private Connection con;

  public ClienteDAO(Connection con) {
    this.con = con;
  }

  @Override
  public Cliente recuperarCliente(Cliente cliente) throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    Cliente objeto = null;

    try {
      st = con.prepareStatement(DBQuery.getSelectCliente());
      st.setString(1, cliente.getCod_cli());

      rs = st.executeQuery();
      if (rs.next()) {
        objeto = new Cliente(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
            rs.getString(6), new Iva(rs.getString("cod_iva")), new Tarifa(rs.getString("cod_tarifa")),
            new FormaPago(rs.getString("codigo")));
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
  public Cliente recuperarClienteById(String codigo) throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    Cliente objeto = null;

    try {
      st = con.prepareStatement(DBQuery.getSelectCliente());
      st.setString(1, codigo);

      rs = st.executeQuery();
      if (rs.next()) {
        objeto = new Cliente(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
            rs.getString(6), new Iva(rs.getString("cod_iva")), new Tarifa(rs.getString("cod_tarifa")),
            new FormaPago(rs.getString("codigo")));
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
  public List<Cliente> recuperarTodosCliente() throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    List<Cliente> list = new ArrayList<Cliente>();

    try {
      st = con.prepareStatement(DBQuery.getSelectAllClientes());
      rs = st.executeQuery();
      while (rs.next()) {
        list.add(new Cliente(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
            rs.getString(6), new Iva(rs.getString("cod_iva")), new Tarifa(rs.getString("cod_tarifa")),
            new FormaPago(rs.getString("codigo"))));
      }
    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    } finally {// cerramos cursores y ResulSet
      Recursos.closeResultSet(rs);
      Recursos.closePreparedStatement(st);
    }
    return list;
  }

  public List<Cliente> recuperarTodosClientesCompleto() throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    Iva iva = null;
    Tarifa tarifa = null;
    FormaPago formaPago = null;
    List<Cliente> list = new ArrayList<Cliente>();

    try {
      st = con.prepareStatement(DBQuery.getSelectAllClienteCompleto());
      rs = st.executeQuery();
      while (rs.next()) {
        iva = new Iva();
        iva.setCod_iva(rs.getString("cod_iva"));
        iva.setTipo_iva(rs.getDouble("tipo_iva"));

        tarifa = new Tarifa();
        tarifa.setCod_tarifa(rs.getString("cod_tarifa"));
        tarifa.setDescripcion(rs.getString("descripcion"));

        formaPago = new FormaPago();
        formaPago.setCodigo(rs.getString("COD_FORMAPAGO"));
        formaPago.setNumero_vtos(rs.getInt("NUM_VOTOS"));
        formaPago.setDias(rs.getInt("DIAS"));

        list.add(new Cliente(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
            rs.getString(6), iva, tarifa, formaPago));
      }
    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    } finally {// cerramos cursores y ResulSet
      Recursos.closeResultSet(rs);
      Recursos.closePreparedStatement(st);
    }
    return list;
  }

  public List<Cliente> recuperarTodosClienteConOferta() throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    List<Cliente> list = new ArrayList<Cliente>();

    try {
      st = con.prepareStatement(DBQuery.getSelectAllClientesConOferta());
      rs = st.executeQuery();
      while (rs.next()) {
        list.add(new Cliente(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
            rs.getString(6), new Iva(rs.getString("cod_iva")), new Tarifa(rs.getString("cod_tarifa")),
            new FormaPago(rs.getString("codigo"))));
      }
    } catch (SQLException e) {
      throw new DAOException(DB_ERR, e);
    } finally {// cerramos cursores y ResulSet
      Recursos.closeResultSet(rs);
      Recursos.closePreparedStatement(st);
    }
    return list;
  }

  public List<Cliente> recuperarTodosClienteSinOferta() throws DAOException {
    PreparedStatement st = null;
    ResultSet rs = null;
    List<Cliente> list = new ArrayList<Cliente>();

    try {
      st = con.prepareStatement(DBQuery.getSelectAllClientesSinOferta());
      rs = st.executeQuery();
      while (rs.next()) {
        list.add(new Cliente(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
            rs.getString(6), new Iva(rs.getString("cod_iva")), new Tarifa(rs.getString("cod_tarifa")),
            new FormaPago(rs.getString("codigo"))));
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
  public void insertarCliente(Cliente cliente) throws DAOException {
    PreparedStatement st = null;
    PreparedStatement sti = null;

    try {
      st = con.prepareStatement(DBQuery.getInsertCliente());
      st.setString(1, cliente.getCod_cli());
      st.setString(2, cliente.getRazon_social());
      st.setString(3, cliente.getTelf());
      st.setString(4, cliente.getDireccion());
      st.setString(5, cliente.getOferta());
      st.setString(6, cliente.getAlb_fact());
      st.setString(7, cliente.getIva().getCod_iva());
      st.setString(8, cliente.getTarifa().getCod_tarifa());
      st.setString(9, cliente.getFormaPago().getCodigo());

      // Obtener un IVA
      IvaDAO ivaDAO = new IvaDAO(con);
      Iva codIva = ivaDAO.recuperarIvaById(cliente.getIva().getCod_iva());
      if (codIva == null) {
        throw new DAOException("El IVA no existe");
      }

      // Obtener una tarifa
      TarifaDAO tarifaDAO = new TarifaDAO(con);
      Tarifa codTarifa = tarifaDAO.recuperarTarifaById(cliente.getTarifa().getCod_tarifa());
      if (codTarifa == null) {
        throw new DAOException("La tarifa no existe");
      }

      // Obtener una FormaPago
      FormaPagoDAO formaPagoDAO = new FormaPagoDAO(con);
      FormaPago codFormaPago = formaPagoDAO.recuperarFormaPagoById(cliente.getFormaPago().getCodigo());
      if (codFormaPago == null) {
        throw new DAOException("La Forma de pago no existe");
      }

      st.executeQuery();

    } catch (SQLException e) {
      if (e.getErrorCode() == ORACLE_DUPLICATE_PK) {
        throw new DAOException("El Cliente ya existe");
      } else if (e.getErrorCode() == ORACLE_FALLO_FK) {
        throw new DAOException("Operacion no disponible temporalmente, vuelva a intentarlo"); // no se que mensaje poner
      } else if (e.getErrorCode() >= 20000 && e.getErrorCode() <= 20999) {// para PL/SQL.triggers
        String cadena = e.toString().substring(e.toString().indexOf("ORA", 0) + 10);
        String cadena1 = cadena.substring(0, cadena.indexOf("ORA", 0));
        throw new DAOException(cadena1);
      } else {
        throw new DAOException(DB_ERR, e);
      }
    } finally {// cerramos cursores y ResulSet
      Recursos.closePreparedStatement(st);
    }
  }

  public void insertarClienteProcedure(String cod_cli, String razon_social, String telf, String direccion,
      String oferta, String alb_fact, String cod_iva, String cod_tarifa, String forma_pago) throws DAOException {

    CallableStatement cst = null;
    final String CONSULTA = "CALL insertar_cliente(?,?,?,?,?,?,?,?,?)";

    try {
      cst = con.prepareCall(CONSULTA);
      cst.setString(1, cod_cli);
      cst.setString(2, razon_social);
      cst.setString(3, telf);
      cst.setString(4, direccion);
      cst.setString(5, oferta);
      cst.setString(6, alb_fact);
      cst.setString(7, cod_iva);
      cst.setString(8, cod_tarifa);
      cst.setString(9, forma_pago);

      cst.execute();

      System.out.println("Todo OK");
      cst.close();

    } catch (SQLException e) {
      if (e.getErrorCode() >= 20000 && e.getErrorCode() <= 20999) {// para PL/SQL.triggers
        String cadena = e.toString().substring(e.toString().indexOf("ORA", 0) + 10);
        String cadena1 = cadena.substring(0, cadena.indexOf("ORA", 0));
        throw new DAOException(cadena1);
      } else {
        throw new DAOException(DB_ERR, e);
      }
    } finally {// cerramos cursores y ResulSet

    }
  }

  @Override
  public int modificarCliente(Cliente cliente) throws DAOException {
    PreparedStatement st = null;
    int modificado = 0;

    try {
      st = con.prepareStatement(DBQuery.getUpdateCliente());

      st.setString(1, cliente.getRazon_social());
      st.setString(2, cliente.getTelf());
      st.setString(3, cliente.getDireccion());
      st.setString(4, cliente.getOferta());
      st.setString(5, cliente.getAlb_fact());
      st.setString(6, cliente.getIva().getCod_iva());
      st.setString(7, cliente.getTarifa().getCod_tarifa());
      st.setString(8, cliente.getFormaPago().getCodigo());
      st.setString(9, cliente.getCod_cli());

      // Obtener un IVA
      IvaDAO ivaDAO = new IvaDAO(con);
      Iva codIva = ivaDAO.recuperarIvaById(cliente.getIva().getCod_iva());
      if (codIva == null) {
        throw new DAOException("El IVA no existe");
      }

      // Obtener una tarifa
      TarifaDAO tarifaDAO = new TarifaDAO(con);
      Tarifa codTarifa = tarifaDAO.recuperarTarifaById(cliente.getTarifa().getCod_tarifa());
      if (codTarifa == null) {
        throw new DAOException("La tarifa no existe");
      }

      // Obtener una FormaPago
      FormaPagoDAO formaPagoDAO = new FormaPagoDAO(con);
      FormaPago codFormaPago = formaPagoDAO.recuperarFormaPagoById(cliente.getFormaPago().getCodigo());
      if (codFormaPago == null) {
        throw new DAOException("La Forma de pago no existe");
      }

      modificado = st.executeUpdate();
    } catch (SQLException e) {
      if (e.getErrorCode() == ORACLE_FALLO_FK) {
        throw new DAOException("Operacion no disponible temporalmente, vuelva a intentarlo");
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
    return modificado;
  }

  public int modificarClienteConcurrente(Cliente clienteActual, Cliente clienteInicial) throws DAOException {
    PreparedStatement st = null;
    PreparedStatement sti = null;
    ResultSet rs = null;
    int modificado = 0;
    try {
      st = con.prepareStatement(DBQuery.getModificarClienteConcurrente());
      st.setString(1, clienteActual.getRazon_social());
      st.setString(2, clienteActual.getTelf());
      st.setString(3, clienteActual.getDireccion());
      st.setString(4, clienteActual.getOferta());
      st.setString(5, clienteActual.getAlb_fact());
      st.setString(6, clienteActual.getIva().getCod_iva());
      st.setString(7, clienteActual.getTarifa().getCod_tarifa());
      st.setString(8, clienteActual.getFormaPago().getCodigo());

      // para los where -- ojo con campos que pueden ser nulos
      st.setString(9, clienteInicial.getCod_cli());
      st.setString(10, clienteInicial.getRazon_social());
      if (clienteInicial.getTelf() == null)
        st.setString(11, "null");
      else
        st.setString(11, clienteInicial.getTelf());
      st.setString(12, clienteInicial.getDireccion());
      st.setString(13, clienteInicial.getOferta());
      st.setString(14, clienteInicial.getAlb_fact());
      st.setString(15, clienteInicial.getIva().getCod_iva());
      st.setString(16, clienteInicial.getTarifa().getCod_tarifa());
      st.setString(17, clienteInicial.getFormaPago().getCodigo());

      // rutina de verificacion de mas de una FK

      // para el iva
      try {
        sti = con.prepareStatement(DBQuery.getSelectIva());
        sti.setString(1, clienteActual.getIva().getCod_iva());
        rs = sti.executeQuery();
        if (!rs.next())
          throw new DAOException("El IVA del cliente no existe");
      } finally {
        Recursos.closeResultSet(rs);
      }

      // para la tarifa
      try {
        sti = con.prepareStatement(DBQuery.getSelectTarifa());
        sti.setString(1, clienteActual.getTarifa().getCod_tarifa());
        rs = sti.executeQuery();
        if (!rs.next())
          throw new DAOException("La Tarifa del cliente no existe");
      } finally {
        Recursos.closeResultSet(rs);
      }

      // para la forma de Pago
      try {
        sti = con.prepareStatement(DBQuery.getSelectFormaPago());
        sti.setString(1, clienteActual.getFormaPago().getCodigo());
        rs = sti.executeQuery();
        if (!rs.next())
          throw new DAOException("La forma de pago del cliente no existe");
      } finally {
        Recursos.closeResultSet(rs);
      }

      // ejecutamos el insert.
      modificado = st.executeUpdate();
    } catch (SQLException e) {
      if (e.getErrorCode() == ORACLE_FALLO_FK) {
        throw new DAOException("Operacion no disponible temporalmente,repita proceso");
      } else if (e.getErrorCode() >= 20000 && e.getErrorCode() <= 20999) {
        String cadena = e.toString().substring(e.toString().indexOf("ORA", 0) + 10);
        String cadena1 = cadena.substring(0, cadena.indexOf("ORA", 0));
        throw new DAOException(cadena1);
      } else {
        throw new DAOException(DB_ERR, e);
      }
    } finally {
      Recursos.closePreparedStatement(st);
      Recursos.closePreparedStatement(sti);
    }
    return modificado;

  }

  @Override
  public int borrarCliente(Cliente cliente) throws DAOException {
    PreparedStatement st = null;
    int borrado = 0;
    try {
      st = con.prepareStatement(DBQuery.getDeleteCliente());
      st.setString(1, cliente.getCod_cli());
      borrado = st.executeUpdate();
    } catch (SQLException e) {
      if (e.getErrorCode() == ORACLE_DELETE_FK) {
        throw new DAOException("No permitido borrar Cliente");

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
  public int borrarClienteById(String cliente) throws DAOException {
    PreparedStatement st = null;
    int borrado = 0;
    try {
      st = con.prepareStatement(DBQuery.getDeleteCliente());
      st.setString(1, cliente);
      borrado = st.executeUpdate();
    } catch (SQLException e) {
      if (e.getErrorCode() == ORACLE_DELETE_FK) {
        throw new DAOException("No permitido borrar el cliente");

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
