<%@ page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="domain.FormaPago"%>
<%@ page import="domain.Iva"%>
<%@ page import="domain.Tarifa"%>
<%@ page import="domain.Cliente"%>
<%@ page import="servicios.ServicioFormaPago"%>
<%@ page import="servicios.ServicioIva"%>
<%@ page import="servicios.ServicioTarifa"%>
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

		<%
		
		Cliente cliente = (Cliente) session.getAttribute("cliente") ;
	    
	  // Recuperar IVAS de la BD
	  List<Iva> lIvas = new ArrayList<Iva>();
		ServicioIva sIva = new ServicioIva();
		lIvas = sIva.recuperarTodosIvas();
			
		// Recuperar Tarifas de la BD
		List<Tarifa> lTarifa = new ArrayList<Tarifa>();
		ServicioTarifa sTarifa = new ServicioTarifa();
		lTarifa = sTarifa.RecuperarTodasTarifas();
			
		// Recuperar Formas de pago de la BD
		List<FormaPago> lFormaPago = new ArrayList<FormaPago>();
		ServicioFormaPago sFormaPago = new ServicioFormaPago();
		lFormaPago = sFormaPago.recuperarTodosFormasPago();
		%>
		
		<%@ include file="/componentes/menu.html"%>
		<div class="container">
			<div class="row mx-auto">
				<div class="my-3 col-md-8 mx-auto">
					<h1>Modificar un cliente</h1>
					<%
					// Si todo es correcto mostrara un mensaje OK
				  String message = (String) request.getAttribute("msg-success");
					if (message != null) { %>
				  	<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
							<<symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
						    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
						  </symbol>
						</svg>
						
						<div class="alert alert-success d-flex align-items-center" role="alert">
						  <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
						  <div>
						  	<%= message %>
						  </div>
						</div>
				  <%
				  }
				  
					// En caso de que haya un error
					message = (String) request.getAttribute("msg-error");
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
				  
					<form class="row g-3 needs-validation" action="ModificarCliente" method="POST" novalidate>
						<!-- cod_cli -->
						<div class="col-md-6">
					  	<label for="cod_cli" class="form-label">Codigo de cliente <span class="text-danger">*</span> </label>
					    <input type="text" class="form-control" id="cod_cli" name="cod_cli" value="<%= request.getParameter("cod_cli") != null ? request.getParameter("cod_cli") : cliente.getCod_cli() %>" readonly required />
					  </div>
							
						<!-- razon_social -->	
						<div class="col-md-6">
							<label for="razon_social" class="form-label">Razon social <span class="text-danger">*</span> </label>
					    <input type="text" class="form-control" id="razon_social" name="razon_social" value="<%= request.getParameter("razon_social") != null ? request.getParameter("razon_social") : cliente.getRazon_social() %>" required />
					  </div>
							
						<!-- telf -->		
						<div class="col-md-6">
							<label for="telf" class="form-label"> Telefono </label>
					    <input type="text" class="form-control" id="telf" name="telf" value="<%= request.getParameter("telf") != null ? request.getParameter("telf") : cliente.getTelf() %>" />
					  </div>
							
						<!-- direccion -->		
						<div class="col-md-6">
							<label for="direccion" class="form-label">Direccion <span class="text-danger">*</span> </label>
					    <input type="text" class="form-control" id="direccion" name="direccion" value="<%= request.getParameter("direccion") != null ? request.getParameter("direccion") : cliente.getDireccion() %>" required />
					  </div>
							
						<!-- oferta -->		
						<div class="col-md-6">
					    <p>Aplicar oferfas al cliente <span class="text-danger">*</span></p>
					    <div class="d-flex">
					    	<div class="form-check form-check-inline">
					     		<input class="form-check-input" type="radio" name="oferta" id="ofertaS" value="S" <%= request.getParameter("oferta") != null ? (request.getParameter("oferta").equals("S") ? "checked" : "") 
					     		    																																																												 : cliente.getOferta().equals("S") ? "checked" : "" %> />
					        <label class="form-check-label" for="ofertaS">Si</label>
					      </div>
					      <div class="form-check form-check-inline">
					      	<input class="form-check-input" type="radio" name="oferta" id="ofertaN" value="N" <%= request.getParameter("oferta") != null ? (request.getParameter("oferta").equals("N") ? "checked" : "") 
					     		    																																																												 : cliente.getOferta().equals("N") ? "checked" : "" %> />
					      	<label class="form-check-label" for="ofertaN">No</label>
					      </div>
					    </div>
					  </div>
							
						<!-- alb_fact -->
						<div class="col-md-6">
				   		<p>Albaran facturado<span class="text-danger">*</span></p>
				    	<div class="d-flex">
					      <div class="form-check form-check-inline">
					      	<input class="form-check-input" type="radio" name="alb_fact" id="alb_factS" value="S" <%= request.getParameter("alb_fact") != null ? (request.getParameter("alb_fact").equals("S") ? "checked" : "") 
					     		    																																																												 			 : (cliente.getAlb_fact().equals("S") ? "checked" : "") %> />
					        <label class="form-check-label" for="alb_factS">Si</label>
					      </div>
					      <div class="form-check form-check-inline">
					      	<input class="form-check-input" type="radio" name="alb_fact" id="alb_factN" value="N" <%= request.getParameter("alb_fact") != null ? (request.getParameter("alb_fact").equals("N") ? "checked" : "") 
					     		    																																																												 			 : (cliente.getAlb_fact().equals("N") ? "checked" : "") %> />
					        <label class="form-check-label" for="alb_factN">No</label>
					      </div>
					    </div>
					  </div>
							
						<!-- Iva -->
						<div class="col-xl-4 col-lg-6">
							<p>Seleccione un IVA <span class="text-danger">*</span></p>
					    <select class="form-select" name="ivas" aria-label="Default select example" required>
					    	<option selected disabled value="">-</option>
					      <%
								for (Iva iva : lIvas) {
									if(iva.getCod_iva().equals(cliente.getIva().getCod_iva()) || iva.getCod_iva().equals(request.getParameter("ivas")) ){ 
									  out.print("<option value='" + iva.getCod_iva() + "' selected>" + iva.getTipo_iva() + "</option>");
									} else {
										out.print("<option value='" + iva.getCod_iva() + "' >" + iva.getTipo_iva() + "</option>");   
									}
								} 
								%>    
					    </select>
						</div>
							
						<!-- Tarifa -->
						<div class="col-xl-4 col-lg-6">
							<p>Seleccione una tarifa <span class="text-danger">*</span></p>
					    <select class="form-select" name="tarifas" aria-label="Default select example" required>
					    	<option selected disabled value="">-</option>
					       <%
					       for (Tarifa tarifa : lTarifa) {
					  		  if(tarifa.getCod_tarifa().equals(cliente.getTarifa().getCod_tarifa()) || tarifa.getCod_tarifa().equals(request.getParameter("tarifas")) ){
									  out.print("<option value='" + tarifa.getCod_tarifa() + "' selected>" + tarifa.getDescripcion().replace("_", " ") + "</option>");
					  			} else {
									  out.print("<option value='" + tarifa.getCod_tarifa() + "'>" + tarifa.getDescripcion().replace("_", " ") + "</option>");
					  			}
					  		} 
							%>    
				  	</select>
			    </div>
		
					<!-- Forma de pago -->
					<div class="col-xl-4 col-lg-6">
						<p>Seleccione una forma de pago <span class="text-danger">*</span></p>
			      <select class="form-select" name="formasPago" aria-label="Default select example" required>
				     	<option selected disabled value="">-</option>
				      <%
				      for (FormaPago formaPago : lFormaPago) {
								if(formaPago.getCodigo().equals(cliente.getFormaPago().getCodigo()) || formaPago.getCodigo().equals(request.getParameter("formasPago")) ){
									  out.print("<option value='" + formaPago.getCodigo() + "' selected>" + formaPago.getNumero_vtos() + " vencimiento(s) a " + formaPago.getDias() +  " dias </option>");
							  } else {
								  out.print("<option value='" + formaPago.getCodigo() + "' >" + formaPago.getNumero_vtos() + " vencimiento(s) a " + formaPago.getDias() +  " dias </option>");
			  			  }
			  			} 
							%>    
			    	</select>
			    </div>
						
					<div class="col-12">
						<button class="btn btn-primary" type="submit">Insertar cliente</button>
					</div>
				</form>
				
    	</div>
		</div>
	</div>
	
	</body>
</html>