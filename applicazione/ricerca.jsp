<html>
    <body>
        <h1> Benvenuto nella pagina di ricerca</h1>
        <h2>Indicare sport e giorno di cui si fa la richiesta</h2>
        <form action="ricerca.jsp" method="POST">
            <input type="text" id="sport" name="sport" placeholder="sport" required>
            <input type="text" id="giorno" name="giorno" placeholder="giorno" required>
            <input type="submit" id="btn" name="btn" value="Cerca">
        </form>
        <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        <%@ page import="java.util.*" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
        <%
            String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
            String Sport = request.getParameter("sport");
            String Giorno = request.getParameter("giorno");
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
                ricerca = "SELECT username,sport,giorno,orario,paese,via,numero,provincia,prenotato FROM Prenotazioni WHERE sport = '"+Sport+"' AND giorno = '"+Giorno+"' AND prenotato = 'No';";
                Statement s = connection.createStatement();
                ResultSet r = s.executeQuery(ricerca);            
                if((Sport != null) && (Giorno != null)){                                                
                        while(r.next()){
                            out.println("La sede ospitante e': "+r.getString(1)+". L'orario disponibile e': "+r.getString(4)+". Si trova in provincia di: "+r.getString(8)+". Il campo si trova a: "+r.getString(5)+". In via e numero: "+r.getString(6)+" "+r.getString(7));
                            out.println("<br>");
                        }
                }    
            }                     
            catch(Exception e){
                out.println(e);
            }      
        %>
        <input type="button" onclick="location.href='prenotazione.jsp'" value="Prenota"/>
    </body>
</html>