
<!DOCTYPE HTML>
<html>

  <body>
    <%@ page import="java.io.*" %>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
    <a href="ricercaGuest.jsp">Clicca qui per cercare un campo</a>
    <h1>Benvenuto nella pagina di registrazione</h1>
    <%  
        out.println("<a href='login.jsp'>Hai gia un account?</a>");
        String type=null;
        
        if(type == null){
          out.println("<form action='index.jsp' method='POST'>");
          out.println("<select id='tipo' name='tipo'>");
          out.println("<option value=null selected>Scegliere il tipo</option>");
          out.println("<option value='utente'>Utente</option>");
          out.println("<option value='gestore'>Gestore</option>");
          out.println("</select>");
          out.println("<input type='submit' id='btn' name='btn' value='Avvia registrazione'>");
          out.println("</form>");
          type = request.getParameter("tipo");
          System.out.println(type);
        }
        else if(type == "utente"){
          out.println("<form action='registrazioneUtente.jsp' method='POST'>");
          out.println("<input type='text' id='uernameUt' name='usernameUt' placeholder='username' required>");
          out.println("<input type='password' id='passwordUt' name='passwordUt' placeholder='password' required>");
          out.println("<input type='submit' id='btn' name='btn' value='registrati'>");
          out.println("</form>");
          System.out.println("ciaoaa");
        }
        else if (type == "gestore"){
          System.out.println("ciao");
          out.println("<form action='registrazioneGestore.jsp' method='POST'>");
          out.println("<input type='text' id='uernameEn' name='usernameEn' placeholder='username' requiered>");
          out.println("<input type='password' id='passwordEn' name='passwordEn' placeholder='password' required>");
          String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
          Connection connection=null;
          String sportQuery=null;
          String provQuery=null;
          ResultSet result = null;
          try{
              Class.forName(DRIVER);
          }
          catch (ClassNotFoundException e) {
              out.println("Errore: Impossibile caricare il Driver Ucanaccess");
          }
          try{
              connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
              provQuery = "SELECT Nome FROM Province;";
              Statement st = connection.createStatement();
              result = st.executeQuery(provQuery);
              out.println("<select name='provincia' id='provincia'>");
              out.println("<option value=null selected>Selezionare una provincia</option>");
              while(result.next()){                               
                    out.println("<option value='"+result.getString(1)+"'>"+result.getString(1)+"</option>");
              }
              out.println("</select>");
          }
          catch(Exception e){
              System.out.println(e);
          }
          out.println("<input type='submit' id='btn' name='btn' value='registrati'>");
          out.println("</form>");

        }  
    %>
      
  </body>
</html>