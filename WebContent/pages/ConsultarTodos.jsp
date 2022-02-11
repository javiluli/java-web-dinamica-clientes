<%@ page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="domain.Cliente"%>
<%@ page import="servicios.ServiciosCliente"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"	pageEncoding="ISO-8859-1"%>

<%
// siempre que venga aqui el usuario se cambiara el atributo 'num' de la sesion, evitando redirecciones erroneas
session.setAttribute("num", "3");

ServiciosCliente sCliente = new ServiciosCliente();
List<Cliente> lClientes = sCliente.recuperarTodosClientesCompletos();
%>
		
<!DOCTYPE html>
<html lang="es">
  <%@ include file="/componentes/Head.html"%>
  
	<body>
	
		<%@ include file="/componentes/menu.html"%>
		
		<div class="container">		
			<table class="table table-hover">
				<thead>
					<tr>
						<th> ID </th>
						<th> Razon social </th>
						<th> Telefono </th>
						<th> Direccion </th>
						<th> Oferta </th>
						<th> Factura del albaran </th>
						<th> IVA </th>
						<th> Tarifa </th>
						<th> Forma de pago </th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Cliente cliente : lClientes) { %>
						<tr>
							<td> <%= cliente.getCod_cli() %> </td>
							<td> <a href="OperacionesCliente?cod_cli=<%= cliente.getCod_cli() %>"> <%= cliente.getRazon_social() %> </a> </td>
							<td> <%= cliente.getTelf() != null ? cliente.getTelf() : "-" %> </td>
							<td> <%= cliente.getDireccion() %> </td>
							<td> <%= cliente.getOferta().equals("S") ? "&#10004;&#65039;" : "&#10060;" %> </td>
							<td> <%= cliente.getAlb_fact().equals("S")? "&#10004;&#65039;" : "&#10060;" %> </td>
							<td class="text-end"> <%= cliente.getIva().getTipo_iva() %>%</td>
							<td> <%= cliente.getTarifa().getDescripcion().replace("_", " ") %> </td>
							<td> <%= cliente.getFormaPago().getNumero_vtos() %> vencimiento(s) a <%= cliente.getFormaPago().getDias() %> dias </td>
						</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
		
		<!-- Bootstrap Bundle with Popper -->
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"crossorigin="anonymous"></script>
  
	</body>
</html>
