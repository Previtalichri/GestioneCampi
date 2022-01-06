<html>
    <body>
        <h1>Benvenuto nella pagina di visualizzazione delle varie disponibilità</h1>
        <h2>Indicare l'username</h2>
        <form action="elencoCamp.jsp" method="POST">
            <input type="text" id="username" name="username" placeholder="username" required> <!-- questo sarà preso dalle sessioni-->
            <input type="submit" id="btn" name="btn" value="Visualizza">
        </form>
        <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        <%@ page import="java.util.*" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
        <%
            String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
            String User = request.getParameter("username");
            Connection connection=null;
            String ricerca;
            try{
                Class.forName(DRIVER);
            }
            catch (ClassNotFoundException e) {
                out.println("Errore: Impossibile caricare il Driver Ucanaccess");
            }
            try{
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                ricerca = "SELECT username,sport,giorno,orario,paese,via,numero,provincia,prenotato FROM Prenotazioni WHERE username = '"+User+"';";
                Statement s = connection.createStatement();
                ResultSet r = s.executeQuery(ricerca);            
                if(User != null){                                                
                        while(r.next()){
                            out.println("Per la sede indicata: "+r.getString(1)+". Sport: "+r.getString(2)+". Giorno: "+r.getString(3)+". L'orario dato disponibile e': "+r.getString(4)+". Si trova in provincia di: "+r.getString(8)+". Il campo si trova a: "+r.getString(5)+". In via e numero: "+r.getString(6)+" "+r.getString(7));
                            out.println("<br>");
                        }
                }    
            }                     
            catch(Exception e){
                out.println(e);
            }      
        %>
        <input type="button" onclick="location.href='rimozioneCamp.jsp'" value="Metti a disposizione"/>
    </body>
</html>