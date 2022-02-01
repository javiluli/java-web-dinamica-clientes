<%@ page import="domain.Cliente" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">
  <%@ include file="/componentes/Head.html"%>

	<body>

		<%
		Cliente cliente = (Cliente) session.getAttribute("cliente");
		%>
		
		<%@ include file="/componentes/menu.html"%>
		
		<div class="container">
			<div class="card " >
			  <div class="card-header">
			    Cliente <b> #<%= cliente.getCod_cli() %> </b>
			  </div>
			  <div class="card-body">
			  	<div class="row"> 
			  		<div class="col-xl-2 col-md-4">
			  			<img src="https://cdn-icons-png.flaticon.com/512/747/747376.png" class="border rounded-circle border-5 border-dark p-2" width="100" height="100">
			  		</div>
			  		<div class="col-xl-4 col-md-8">
			  			<h5 class="card-title"> <b><%= cliente.getRazon_social() %> </b> </h5>
			  			<p class="card-text"> <b> Direccion </b>: <%= cliente.getDireccion() %></p>				    	
				    	<%
				    	// si el cliente tiene un telefono asociado se mostrara como parte de la informacion
				    	if(cliente.getTelf() != null )
				    		out.print("<p> <b> Telefono </b>: <a href='#' class='link'>" + cliente.getTelf() + "</a> </p>");				    	
				    	%>
			  		</div>
			  		
				    <div class="col-xl-6 col-md-12">
			  			<h5 class="card-title"> <b> Datos adicionales </b> </h5>
			  			<p> <b> Oferta </b>: <%= cliente.getOferta().equals("S") ? "Si" : "No" %> </p>
			  			<p> <b> Factura del albaran </b>: <%= cliente.getAlb_fact().equals("S") ? "Si" : "No" %> </p>
							<p> <b> IVA </b>: <%= cliente.getIva().getTipo_iva()%> </p>
							<p> <b> Tarifa </b>: <%= cliente.getTarifa().getDescripcion() %> </p>
							<p> <b> Forma de pago </b>: <%= cliente.getFormaPago().getNumero_vtos() %> vencimiento(s) a <%= cliente.getFormaPago().getDias() %> dias </p>
			  		</div>				    
			  	</div>
			  </div>
			</div>
		</div>
		
		<!-- Bootstrap Bundle with Popper -->
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"crossorigin="anonymous"></script>
          
	</body>
</html>