<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.annotation.WebServlet"%>
<%@ page import="javax.servlet.http.HttpServlet"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">
  <%@ include file="/componentes/Head.html"%>
  
	<body>

		<%		
		if(request.getParameter("num") != null) {
			session.setAttribute("num", request.getParameter("num"));   
		} 
		%>
		
		<%@ include file="/componentes/menu.html"%>
		
		<div class="container">
			<div class="row mx-auto">
				<div class="my-3 col-md-8 mx-auto">
					<%	
					if (Integer.parseInt((String) session.getAttribute("num")) == 1) {
						out.print("<h1>Consultar cliente</h1>");
					} else if (Integer.parseInt((String) session.getAttribute("num")) == 2) {
					  out.print("<h1>Borrar cliente</h1>");
					} else if (Integer.parseInt((String) session.getAttribute("num")) == 3) {
						out.print("<h1>Modificar cliente</h1>");
					}
		  
					// En caso de que haya un error
					String message = (String) request.getAttribute("msg-error");
					
				  if (message != null) { %>
					  <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">	  
						  <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
						    <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
						  </symbol>
						</svg>
						
						<div class="alert alert-danger d-flex align-items-center" role="alert">
						  <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
						  <div>
						    <%= message %>
						  </div>
						</div>
				  <%
				  }
				  %>
					
					<form class="row g-3" action="OperacionesCliente" method="GET">
						<div class="col-auto">
					    <label for="cod_cli" class="visually-hidden">Codigo del cliente</label>
					    <input type="text" class="form-control" id="cod_cli" name="cod_cli">
					  </div>
					  <div class="col-auto">
					    <button type="submit" class="btn btn-primary mb-3">Buscar cliente</button>
					  </div>
					</form>
				</div>
			</div>
		</div>
		
 		<!-- Bootstrap Bundle with Popper -->
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"crossorigin="anonymous"></script>
  
	</body>
</html>