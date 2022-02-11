package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import domain.Cliente;
import exceptions.ServiceException;
import servicios.ServiciosCliente;

/**
 * Servlet implementation class OperacionesCliente
 */
@WebServlet("/OperacionesCliente")
public class OperacionesCliente extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    ServiciosCliente sCliente = null;
    Cliente cliente = null;
    HttpSession session = request.getSession();

    // si el atributo de la sesion no existe o es null se le agrega un valor por
    // defecto
    String num = session.getAttribute("num") == null ? "3" : (String) session.getAttribute("num");
    String cod_cli = request.getParameter("cod_cli").trim();

    String nextPage = null;

    try {
      sCliente = new ServiciosCliente();
      cliente = sCliente.recuperarClienteCompletoByID(cod_cli);

      if (cliente == null) {
        request.setAttribute("msg-error", "El cliente no existe");

        if (Integer.parseInt(num) == 1) {
          nextPage = "/consultar";
        } else if (Integer.parseInt(num) == 2) {
          nextPage = "/borrar";
        } else if (Integer.parseInt(num) == 3) {
          nextPage = "/modificar";
        }

      } else {
        session.setAttribute("cliente", cliente);

        if (Integer.parseInt(num) == 1) {
          nextPage = "/pages/VerClienteConsultar.jsp";
        } else if (Integer.parseInt(num) == 2) {
          nextPage = "/pages/VerClienteBorrar.jsp";
        } else if (Integer.parseInt(num) == 3) {
          nextPage = "/pages/VerClienteModificar.jsp";
        }
      }

    } catch (ServiceException e) {
      e.printStackTrace();
      // Error interno para el usuario
      request.setAttribute("msg-error", "Error interno");
      nextPage = "/pages/ConsultarCliente.jsp";
    }

    getServletContext().getRequestDispatcher(nextPage).forward(request, response);

  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  }

}
