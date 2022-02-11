package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import domain.Cliente;
import domain.FormaPago;
import domain.Iva;
import domain.Tarifa;
import exceptions.DomainException;
import exceptions.ServiceException;
import servicios.ServiciosCliente;

/**
 * Servlet implementation class ModificarCliente
 */
@WebServlet("/ModificarCliente")
public class ModificarCliente extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doPost(request, response);
  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    Iva iva = null;
    Tarifa tarifa = null;
    FormaPago formaPago = null;
    Cliente cliente = null;
    ServiciosCliente sCliente = null;
    HttpSession session = request.getSession();

    try {
      cliente = new Cliente();
      cliente.setCod_cli(request.getParameter("cod_cli"));
      cliente.setRazon_social(request.getParameter("razon_social"));
      cliente.setTelf(request.getParameter("telf"));
      cliente.setDireccion(request.getParameter("direccion"));
      cliente.setOferta(request.getParameter("oferta"));
      cliente.setAlb_fact(request.getParameter("alb_fact"));

      iva = new Iva();
      iva.setCod_iva(request.getParameter("ivas"));
      cliente.setIva(iva);

      tarifa = new Tarifa();
      tarifa.setCod_tarifa(request.getParameter("tarifas"));
      cliente.setTarifa(tarifa);

      formaPago = new FormaPago();
      formaPago.setCodigo(request.getParameter("formasPago"));
      cliente.setFormaPago(formaPago);

      sCliente = new ServiciosCliente();
      sCliente.modificarClienteConcurrente(cliente, (Cliente) session.getAttribute("cliente"));

      request.setAttribute("msg-success", "Cliente modificado correctamente");

    } catch (ServiceException | DomainException e) {
      if (e.getCause() == null) {
        // Error logico para el usuario
        request.setAttribute("msg-error", e.getMessage());
      } else {
        e.printStackTrace();
        // Error interno para el usuario
        request.setAttribute("msg-error", "Error interno");
      }
    }

    getServletContext().getRequestDispatcher("/pages/VerClienteModificar.jsp").forward(request, response);

  }

}
