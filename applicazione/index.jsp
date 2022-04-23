
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
    <form action='index.jsp' method='POST'>
      <select id='tipo' name='tipo'>
        <option value='utente'>Utente</option>
        <option value='gestore'>Gestore</option>
      </select>
      <input type='submit' id='btn' name='btn' value='Avvia registrazione'>
    </form><br>
    <%  
        out.println("<a href='login.jsp'>Hai gia un account?</a>");
        String type=null;
        type = request.getParameter("tipo");
        System.out.println(type);
        if (type != null){
          switch(type){
          case "utente":
            out.println("<form action='registrazioneUtente.jsp' method='POST'>");
            out.println("<input type='text' id='uernameUt' name='usernameUt' placeholder='username' required>");
            out.println("<input type='password' id='passwordUt' name='passwordUt' placeholder='password' required>");
            out.println("<input type='submit' id='btn' name='btn' value='registrati'>");
            out.println("</form>");
            break;

          case "gestore":
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
            break; 
            default: break;
        }

        }
        
          

          
    %>
      
  </body>
</html>