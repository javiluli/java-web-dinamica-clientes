package servicios;

import java.util.List;

import daos.ClienteDAO;
import daos.FormaPagoDAO;
import daos.IvaDAO;
import daos.TarifaDAO;
import daos.TransaccionesManager;
import domain.Cliente;
import domain.FormaPago;
import domain.Iva;
import domain.Tarifa;
import exceptions.DAOException;
import exceptions.ServiceException;

public class ServiciosCliente {

  public ServiciosCliente() {
  }

  public Cliente recuperarCliente(Cliente cliente) throws ServiceException {

    TransaccionesManager trans = null;
    ClienteDAO clienteDAO = null;

    try {

      trans = new TransaccionesManager();
      clienteDAO = trans.getClienteDAO();
      cliente = clienteDAO.recuperarCliente(cliente);

      trans.closeCommit(); // se hace commit y cierro conexion

    } catch (DAOException e) { // ESTA RUTINA SIEMPRE IGUAL, EN TODOS

      try {
        if (trans != null)
          trans.closeRollback();

      } catch (DAOException e2) {
        throw new ServiceException(e.getMessage(), e2); // Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage()); // Error logico

      } else {
        throw new ServiceException(e.getMessage(), e); // Error interno

      }
    }

    return cliente;
  }

  public Cliente recuperarClienteByID(String id) throws ServiceException {

    TransaccionesManager trans = null;
    ClienteDAO clienteDAO = null;
    Cliente cliente = null;

    try {

      trans = new TransaccionesManager();
      clienteDAO = trans.getClienteDAO();
      cliente = clienteDAO.recuperarClienteById(id);

      trans.closeCommit(); // cierro conexion

    } catch (DAOException e) { // ESTA RUTINA SIEMPRE IGUAL, EN TODOS

      try {
        if (trans != null)
          trans.closeRollback();

      } catch (DAOException e2) {
        throw new ServiceException(e.getMessage(), e2); // Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage()); // Error logico

      } else {
        throw new ServiceException(e.getMessage(), e); // Error interno

      }
    }

    return cliente;
  }

  public Cliente recuperarClienteCompleto(Cliente cliente) throws ServiceException {

    TransaccionesManager trans = null;

    try {

      trans = new TransaccionesManager();
      ClienteDAO clienteDAO = trans.getClienteDAO();
      cliente = clienteDAO.recuperarCliente(cliente);

      if (cliente != null) {
        IvaDAO ivaDAO = trans.getIvaDAO();
        Iva iva = ivaDAO.recuperarIva(cliente.getIva());

        TarifaDAO tarifaDAO = trans.getTarifaDAO();
        Tarifa tarifa = tarifaDAO.recuperarTarifa(cliente.getTarifa());

        FormaPagoDAO formaPagoDAO = trans.getFormaPagoDAO();
        FormaPago formaPago = formaPagoDAO.recuperarFormaPago(cliente.getFormaPago());

        cliente.setIva(iva);
        cliente.setTarifa(tarifa);
        cliente.setFormaPago(formaPago);
      } else {
        cliente = null;
      }

      trans.closeCommit(); // cierro conexion

    } catch (DAOException e) { // ESTA RUTINA SIEMPRE IGUAL, EN TODOS

      try {
        if (trans != null)
          trans.closeRollback();

      } catch (DAOException e2) {
        throw new ServiceException(e.getMessage(), e2); // Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage()); // Error logico

      } else {
        throw new ServiceException(e.getMessage(), e); // Error interno

      }
    }

    return cliente;
  }

  public Cliente recuperarClienteCompletoByID(String cod_cli) throws ServiceException {

    TransaccionesManager trans = null;
    Cliente cliente = null;

    try {

      trans = new TransaccionesManager();
      ClienteDAO clienteDAO = trans.getClienteDAO();
      cliente = clienteDAO.recuperarClienteById(cod_cli);

      if (cliente != null) {
        IvaDAO ivaDAO = trans.getIvaDAO();
        Iva iva = ivaDAO.recuperarIva(cliente.getIva());

        TarifaDAO tarifaDAO = trans.getTarifaDAO();
        Tarifa tarifa = tarifaDAO.recuperarTarifa(cliente.getTarifa());

        FormaPagoDAO formaPagoDAO = trans.getFormaPagoDAO();
        FormaPago formaPago = formaPagoDAO.recuperarFormaPago(cliente.getFormaPago());

        cliente.setIva(iva);
        cliente.setTarifa(tarifa);
        cliente.setFormaPago(formaPago);
      } else {
        cliente = null;
      }

      trans.closeCommit(); // cierro conexion

    } catch (DAOException e) { // ESTA RUTINA SIEMPRE IGUAL, EN TODOS

      try {
        if (trans != null)
          trans.closeRollback();

      } catch (DAOException e2) {
        throw new ServiceException(e.getMessage(), e2); // Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage()); // Error logico

      } else {
        throw new ServiceException(e.getMessage(), e); // Error interno

      }
    }

    return cliente;
  }

  public void insertarCliente(Cliente cliente) throws ServiceException {

    TransaccionesManager trans = null;
    ClienteDAO clienteDAO = null;

    try {

      trans = new TransaccionesManager();
      clienteDAO = trans.getClienteDAO();
      clienteDAO.insertarCliente(cliente);

      trans.closeCommit(); // se hace commit y cierro conexion

    } catch (DAOException e) { // ESTA RUTINA SIEMPRE IGUAL, EN TODOS

      try {
        if (trans != null)
          trans.closeRollback();

      } catch (DAOException e2) {
        throw new ServiceException(e.getMessage(), e2); // Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage()); // Error logico

      } else {
        throw new ServiceException(e.getMessage(), e); // Error interno

      }
    }
  }

  public int actualizarCliente(Cliente cliente) throws ServiceException {

    TransaccionesManager trans = null;
    ClienteDAO clienteDAO = null;
    int actualizado = 0;

    try {

      trans = new TransaccionesManager();
      clienteDAO = trans.getClienteDAO();
      actualizado = clienteDAO.modificarCliente(cliente);

      trans.closeCommit(); // se hace commit y cierro conexion

    } catch (DAOException e) { // ESTA RUTINA SIEMPRE IGUAL, EN TODOS

      try {
        if (trans != null)
          trans.closeRollback();

      } catch (DAOException e2) {
        throw new ServiceException(e.getMessage(), e2); // Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage()); // Error logico

      } else {
        throw new ServiceException(e.getMessage(), e); // Error interno

      }
    }

    return actualizado;
  }

  public int modificarClienteConcurrente(Cliente clienteActual, Cliente clienteInicial) throws ServiceException {
    TransaccionesManager trans = null;
    int modificar = 0;
    ClienteDAO clienteDAO = null;
    Cliente cliente = null;
    try {

      trans = new TransaccionesManager();
      clienteDAO = trans.getClienteDAO();
      modificar = clienteDAO.modificarClienteConcurrente(clienteActual, clienteInicial);

      if (modificar == 0) {
        throw new DAOException("El cliente ha sido modificado por otro usuario");
      }

      /*
       * otra forma con bloqueo explícito del cliente inicial en la transacción
       * ****************************************************
       * cliente=clienteDAO.recuperarClienteBloqueo(clienteInicial); if(cliente!= null
       * && cliente.toString().equals(clienteInicial.toString())){ modificar =
       * clienteDAO.modificarCliente(clienteActual); } else{ throw new
       * DAOException("El cliente ha sido modificado por otro usuario"); }
       */

      trans.closeCommit();
    } catch (DAOException e) {
      try {
        if (trans != null)
          trans.closeRollback();
      } catch (DAOException e1) {
        throw new ServiceException(e.getMessage(), e1);// Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage());// Error Lógico
      } else {
        throw new ServiceException(e.getMessage(), e);// Error interno
      }

    }
    return modificar;
  }

  public int borrarCliente(Cliente cliente) throws ServiceException {

    TransaccionesManager trans = null;
    ClienteDAO clienteDAO = null;
    int borrado = 0;

    try {

      trans = new TransaccionesManager();
      clienteDAO = trans.getClienteDAO();
      borrado = clienteDAO.borrarCliente(cliente);

      trans.closeCommit(); // se hace commit y cierro conexion

    } catch (DAOException e) { // ESTA RUTINA SIEMPRE IGUAL, EN TODOS

      try {
        if (trans != null)
          trans.closeRollback();

      } catch (DAOException e2) {
        throw new ServiceException(e.getMessage(), e2); // Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage()); // Error logico

      } else {
        throw new ServiceException(e.getMessage(), e); // Error interno

      }
    }

    return borrado;
  }

  public int borrarClienteByID(String id) throws ServiceException {

    TransaccionesManager trans = null;
    ClienteDAO clienteDAO = null;
    int borrado = 0;

    try {

      trans = new TransaccionesManager();
      clienteDAO = trans.getClienteDAO();
      borrado = clienteDAO.borrarClienteById(id);

      trans.closeCommit(); // se hace commit y cierro conexion

    } catch (DAOException e) { // ESTA RUTINA SIEMPRE IGUAL, EN TODOS

      try {
        if (trans != null)
          trans.closeRollback();

      } catch (DAOException e2) {
        throw new ServiceException(e.getMessage(), e2); // Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage()); // Error logico

      } else {
        throw new ServiceException(e.getMessage(), e); // Error interno

      }
    }

    return borrado;
  }

  public List<Cliente> recuperarTodosCliente() throws ServiceException {

    TransaccionesManager trans = null;
    ClienteDAO clienteDAO = null;
    List<Cliente> lClientes = null;

    try {

      trans = new TransaccionesManager();
      clienteDAO = trans.getClienteDAO();
      lClientes = clienteDAO.recuperarTodosCliente();
      trans.closeCommit(); // se hace commit y cierro conexion

    } catch (DAOException e) { // ESTA RUTINA SIEMPRE IGUAL, EN TODOS

      try {
        if (trans != null)
          trans.closeRollback();

      } catch (DAOException e2) {
        throw new ServiceException(e.getMessage(), e2); // Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage()); // Error logico

      } else {
        throw new ServiceException(e.getMessage(), e); // Error interno

      }
    }

    return lClientes;
  }

  public List<Cliente> recuperarTodosClienteConOferta() throws ServiceException {

    TransaccionesManager trans = null;
    ClienteDAO clienteDAO = null;
    List<Cliente> lClientes = null;

    try {

      trans = new TransaccionesManager();
      clienteDAO = trans.getClienteDAO();
      lClientes = clienteDAO.recuperarTodosClienteConOferta();
      trans.closeCommit(); // se hace commit y cierro conexion

    } catch (DAOException e) { // ESTA RUTINA SIEMPRE IGUAL, EN TODOS

      try {
        if (trans != null)
          trans.closeRollback();

      } catch (DAOException e2) {
        throw new ServiceException(e.getMessage(), e2); // Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage()); // Error logico

      } else {
        throw new ServiceException(e.getMessage(), e); // Error interno

      }
    }

    return lClientes;
  }

  public List<Cliente> recuperarTodosClienteSinOferta() throws ServiceException {

    TransaccionesManager trans = null;
    ClienteDAO clienteDAO = null;
    List<Cliente> lClientes = null;

    try {

      trans = new TransaccionesManager();
      clienteDAO = trans.getClienteDAO();
      lClientes = clienteDAO.recuperarTodosClienteSinOferta();
      trans.closeCommit(); // se hace commit y cierro conexion

    } catch (DAOException e) { // ESTA RUTINA SIEMPRE IGUAL, EN TODOS

      try {
        if (trans != null)
          trans.closeRollback();

      } catch (DAOException e2) {
        throw new ServiceException(e.getMessage(), e2); // Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage()); // Error logico

      } else {
        throw new ServiceException(e.getMessage(), e); // Error interno

      }
    }

    return lClientes;
  }

  public List<Cliente> recuperarTodosClientesCompletos() throws ServiceException {

    TransaccionesManager trans = null;
    ClienteDAO clienteDAO = null;
    List<Cliente> lClientes = null;

    try {

      trans = new TransaccionesManager();
      clienteDAO = trans.getClienteDAO();
      lClientes = clienteDAO.recuperarTodosClientesCompleto();
      trans.closeCommit(); // se hace commit y cierro conexion

    } catch (DAOException e) { // ESTA RUTINA SIEMPRE IGUAL, EN TODOS

      try {
        if (trans != null)
          trans.closeRollback();

      } catch (DAOException e2) {
        throw new ServiceException(e.getMessage(), e2); // Error interno
      }

      if (e.getCause() == null) {
        throw new ServiceException(e.getMessage()); // Error logico

      } else {
        throw new ServiceException(e.getMessage(), e); // Error interno

      }
    }

    return lClientes;
  }

}
