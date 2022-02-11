package componentes;

public class Alerts {

  String message;
  
  public static String sucess(String message) {
    return "  <div class='alert alert-success' role='alert'>" 
        +       message 
        + "   </div>";
  }

  public static String error(String message) {
    return "  <div class='alert alert-danger' role='alert'>" 
        +       message 
        + "   </div>";
  }

}
