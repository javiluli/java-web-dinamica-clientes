<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="es">
	<%@ include file="/componentes/Head.html"%>
	
	<body>

		<%@ include file="/componentes/menu.html"%>

		<h1><%= request.getAttribute("mensaje") %></h1>
	
		<!-- Bootstrap Bundle with Popper -->
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"crossorigin="anonymous"></script>
	
	</body>
</html>