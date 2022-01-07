<html>
    <body>
        <h1>Benvenuto nella pagina di messa a disposizione</h1>
        <h2>Qui potrai mettere a disposizione i tuoi campi</h2>

                <h2>Indicare: username,sport,giorno,orario,paese,via,numero,provincia del campo di cui si da la disponibilita</h2>
                <h3>Attenzione: se verra inserito un username non valido, non ci sara nessun salvataggio della disponibilita data</h3>
                <form action="disposizione.jsp" method="POST">
                    <input type="text" id="sport" name="sport" placeholder="sport" required>            
                    <input type="text" id="giorno" name="giorno" placeholder="giorno" required>
                    <input type="text" id="orario" name="orario" placeholder="orario" required>
                    <input type="text" id="paese" name="paese" placeholder="paese" required>
                    <input type="text" id="via" name="via" placeholder="via" required>
                    <input type="numeric" id="numero" name="numero" placeholder="numero" required>
                    <input type="text" id="provincia" name="provincia" placeholder="provincia" required>
                    <input type="submit" id="btn" name="btn" value="Metti a disposizione">
                </form>
                <%@ page import="java.io.*" %>
                <%@ page import="java.sql.*" %>
                <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
                <%@ page import="java.util.concurrent.TimeUnit" %>
                <%
                    String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
                    String Sport = request.getParameter("sport");
                    String Giorno = request.getParameter("giorno");
                    String ora = request.getParameter("orario");
                    String Paese = request.getParameter("paese");
                    String Via = request.getParameter("via");
                    String num = request.getParameter("numero");
                    String prov = request.getParameter("provincia");
                    String preno = "No";
                    Connection connection=null;
                    String query;
                    String verifica;
                    String user=null;
                    try{
                        Class.forName(DRIVER);
                    }
                    catch (ClassNotFoundException e) {
                        out.println("Errore: Impossibile caricare il Driver Ucanaccess");
                    }
                    try{
                        HttpSession s = request.getSession();
                        user = (String)s.getAttribute("username");
                        connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                        verifica = "SELECT username FROM Entità WHERE username = '"+user+"';";
                        Statement st = connection.createStatement();
                        ResultSet result = st.executeQuery(verifica);
                        
                        if((user !=null) && (Sport != null) && (Giorno != null) && (ora != null) && (Paese != null) && (Via != null) && (num != null) && (prov != null)){
                            if (result.next()){
                                query = "INSERT INTO Prenotazioni(username,sport,giorno,orario,paese,via,numero,provincia,prenotato) VALUES('"+user+"','"+Sport+"','"+Giorno+"','"+ora+"','"+Paese+"','"+Via+"','"+num+"','"+prov+"','"+preno+"')"; 
                                st.executeUpdate(query);
                            }
                            
                        }
                    }
                    catch(Exception e){
                        out.println(e);
                    }
                    if((user !=null) && (Sport != null) && (Giorno != null) && (ora != null) && (Paese != null) && (Via != null) && (num != null) && (prov != null)){
                        String url = "Entita.html";
                        response.sendRedirect(url);
                    } 
                %>
    </body>
</html>
