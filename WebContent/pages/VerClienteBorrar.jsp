<%@ page import="domain.Cliente"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
Cliente cliente = (Cliente) session.getAttribute("cliente");
%>

<!DOCTYPE html>
<html lang="es">
 	<%@ include file="/componentes/Head.html"%>

	<body>	
		<%@ include file="/componentes/menu.html"%>

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
		
		<!-- Bootstrap Bundle with Popper -->
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"crossorigin="anonymous"></script>
  
	</body>
</html>