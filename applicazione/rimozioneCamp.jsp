<html>
    <body>
        <h1>Benvenuti nella pagina di rimozione disponibilita</h1>
        <h2>Inserire username,sport,giorno,orario,paese e provincia della disponibilita da eliminare</h2>
        <h3>Attenzione se verra immmessa una informazione non valida, non cambiera niente all'interno del database</h3>
        <form action="rimozioneCamp.jsp" method="POST">
            <input type="text" id="username" name="username" placeholder="username" required>
            <input type="text" id="sport" name="sport" placeholder="sport" required>            
            <input type="text" id="giorno" name="giorno" placeholder="giorno" required>
            <input type="text" id="orario" name="orario" placeholder="orario" required>
            <input type="text" id="paese" name="paese" placeholder="paese" required>
            <input type="text" id="provincia" name="provincia" placeholder="provincia" required>
            <input type="submit" id="btn" name="btn" value="RImuovi disponibilità">
        </form>
        <%@ page import="java.io.*" %>
                <%@ page import="java.sql.*" %>
                <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
                <%@ page import="java.util.concurrent.TimeUnit" %>
                <%
                    String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
                    String user = request.getParameter("username");
                    String Sport = request.getParameter("sport");
                    String Giorno = request.getParameter("giorno");
                    String ora = request.getParameter("orario");
                    String Paese = request.getParameter("paese");
                    String prov = request.getParameter("provincia");
                    Connection connection=null;
                    String query;
                    String verifica;
                    try{
                        Class.forName(DRIVER);
                    }
                    catch (ClassNotFoundException e) {
                        out.println("Errore: Impossibile caricare il Driver Ucanaccess");
                    }
                    try{
                        connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                        verifica = "SELECT username FROM Entità WHERE username = '"+user+"';";
                        Statement st = connection.createStatement();
                        ResultSet result = st.executeQuery(verifica);
                        
                        if((user !=null) && (Sport != null) && (Giorno != null) && (ora != null) && (Paese != null) && (prov != null)){
                            if (result.next()){
                                query = "DELETE * FROM Prenotazioni WHERE username = '"+user+"'AND sport = '"+Sport+"'AND giorno = '"+Giorno+"'AND orario = '"+ora+"'AND paese = '"+Paese+"'AND provincia = '"+prov+"';";
                                Statement s = connection.createStatement();
                                s.executeUpdate(query);
                            }
                            
                        }
                    }
                    catch(Exception e){
                        out.println(e);
                    }
                    if((user !=null) && (Sport != null) && (Giorno != null) && (ora != null) && (Paese != null) && (prov != null)){
                        String url = "Entita.html";
                        response.sendRedirect(url);
                    }
                %>
    </body>
</html>
 