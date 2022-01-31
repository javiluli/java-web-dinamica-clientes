<%@ page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="domain.Cliente"%>
<%@ page import="servicios.ServiciosCliente"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="es">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" />

    <title>CRUD Java - JSP - Servlets</title>
  </head>
<body>

	<%
	List<Cliente> lClientes = new ArrayList<Cliente>();
	ServiciosCliente sCliente = new ServiciosCliente();
  lClientes = sCliente.recuperarTodosClientesCompletos();
	%>
	
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
						<td> <a href="OperacionesCliente?num=1&cod_cli=<%= cliente.getCod_cli() %>"> <%= cliente.getRazon_social() %> </a> </td>
						<td> <%= cliente.getTelf() != null ? cliente.getTelf() : "-" %> </td>
						<td> <%= cliente.getDireccion() %> </td>
						<td> <%= cliente.getOferta().equals("S") ? "Si" : "No" %> </td>
						<td> <%= cliente.getAlb_fact().equals("S")? "Si" : "No" %> </td>
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
	
</body>
</html>
