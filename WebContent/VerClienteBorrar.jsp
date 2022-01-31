<%@ page import="domain.Cliente"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="es">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" />
		<!-- Bootstrap icons -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <title>CRUD Java - JSP - Servlets</title>
  </head>
	<body>	
		<%@ include file="/componentes/menu.html"%>
		
		<%
		Cliente cliente = (Cliente) session.getAttribute("cliente");
		%>
	
		<div class="container">
			<div class="row mx-auto">
				<div class="my-3 col-md-8 mx-auto">
					<h1>Borrar un cliente</h1>
					<form class="row g-3 needs-validation" action="BorrarCliente" method="POST">
						<!-- cod_cli -->
						<div class="col-md-6">
							<label for="cod_cli" class="form-label">Codigo de cliente </label>
							<input type="text" class="form-control" id="cod_cli" name="cod_cli" value="<%= cliente.getCod_cli() %>" readonly />
						</div>
					
						<!-- razon_social -->
						<div class="col-md-6">
							<label for="razon_social" class="form-label">Razon social </label>
				      <input type="text" class="form-control" id="razon_social" value="<%= cliente.getRazon_social() %>" readonly />
				    </div>
				    
				    <!-- telf -->		
						<div class="col-md-6">
							<label for="telf" class="form-label"> Telefono </label>
				      <input type="text" class="form-control" id="telf" value="<%= cliente.getTelf() == null ? "-" : cliente.getTelf() %>" readonly />
				    </div>
				    
				    <!-- direccion -->		
						<div class="col-md-6">
							<label for="direccion" class="form-label">Direccion </label>
				      <input type="text" class="form-control" id="direccion" value="<%= cliente.getDireccion() %>" readonly />
				    </div>
				          
				    <!-- oferta -->		
						<div class="col-md-6">
				    	<p>Aplicar oferfas al cliente</p>
				      <div class="d-flex">
				      	<div class="form-check form-check-inline">
				        	<input class="form-check-input" type="radio" name="oferta" id="ofertaS" <%= cliente.getOferta().equals("S") ? "checked" : "" %> readonly />
				          <label class="form-check-label" for="ofertaS">Si</label>
				        </div>
				        <div class="form-check form-check-inline">
				        	<input class="form-check-input" type="radio" name="oferta" id="ofertaN" <%= cliente.getOferta().equals("N") ? "checked" : "" %> readonly />
				          <label class="form-check-label" for="ofertaN">No</label>
				        </div>
				      </div>
				    </div>
				    
				    <!-- alb_fact -->
						<div class="col-md-6">
				    	<p>Albaran facturado</p>
				      <div class="d-flex">
				      	<div class="form-check form-check-inline">
				        	<input class="form-check-input" type="radio" name="alb_fact" id="alb_factS" <%= cliente.getAlb_fact().equals("S") ? "checked" : "" %> readonly />
				          <label class="form-check-label" for="alb_factS">Si</label>
				        </div>
				        <div class="form-check form-check-inline">
				        	<input class="form-check-input" type="radio" name="alb_fact" id="alb_factN" <%= cliente.getAlb_fact().equals("N") ? "checked" : "" %> readonly />
				          <label class="form-check-label" for="alb_factN">No</label>
				        </div>
				      </div>
				    </div>
				    
						<!-- Iva -->
						<div class="col-xl-4 col-lg-6">
							<label for="direccion" class="form-label"> IVA </label>
				      <input type="text" class="form-control" id="direccion" value="<%= cliente.getIva().getTipo_iva() %>" readonly />
				    </div>
				    
						<!-- Tarifa -->
						<div class="col-xl-4 col-lg-6">
							<label for="direccion" class="form-label"> Tarifa </label>
				      <input type="text" class="form-control" id="direccion" value="<%= cliente.getTarifa().getDescripcion().replace("_", " ") %>" readonly />
				    </div>
				    
				    <!-- Forma de pago -->
				    <div class="col-xl-4 col-lg-12">
							<label for="direccion" class="form-label"> Forma de pago </label>
				      <input type="text" class="form-control" id="direccion" value="<%= cliente.getFormaPago().getNumero_vtos()%> vencimiento(s) a <%= cliente.getFormaPago().getDias() %> dias" readonly />
				    </div>									 
				    
				    <div class="col-12">
							<button class="btn btn-danger" type="submit">Borrar cliente</button>
				    </div>
										          
					</form>
					
				</div>
			</div>
		</div>
	</body>
</html>