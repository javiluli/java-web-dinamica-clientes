package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exceptions.ServiceException;
import servicios.ServiciosCliente;

/**
 * Servlet implementation class BorrarCliente
 */
@WebServlet("/BorrarCliente")
public class BorrarCliente extends HttpServlet {
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

    ServiciosCliente sCliente = null;
    String cod_cli = request.getParameter("cod_cli");

    try {
      sCliente = new ServiciosCliente();
      sCliente.borrarClienteByID(cod_cli);
      request.setAttribute("mensaje", "Cliente borrado correctamente");
    } catch (ServiceException e) {
      if (e.getCause() == null) {
        // Error logico para el usuario
        request.setAttribute("mensaje", e.getMessage());

      } else {
        e.printStackTrace();

        // Error interno para el usuario
        request.setAttribute("mensaje", "Error interno");
      }
    }
    getServletContext().getRequestDispatcher("/mensajes.jsp").forward(request, response);

  }

}
