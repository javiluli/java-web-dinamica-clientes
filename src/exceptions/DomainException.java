package exceptions;

/**
 * Clase excepcion para la capa dominio
 * 
 * @author Angel
 * 
 */
@SuppressWarnings("serial")

public class DomainException extends RuntimeException {

	/** Excepcion con mensaje */
	//para errores logicos:" el usuario da mal los datos"
	public DomainException(String message) {
		super(message);
	}

	/** Excepcion con mensaje y causa */
	// Para errores ejenos a la logica de la programación
	public DomainException(String message, Throwable cause) {
		super(message, cause);
	}

}
