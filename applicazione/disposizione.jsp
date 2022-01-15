<html>
    <body>
        <h1>Benvenuto nella pagina di messa a disposizione</h1>
        <h2>Qui potrai mettere a disposizione i tuoi campi</h2>

                <h2>Indicare: sport,giorno,orario,paese,via,numero,provincia del campo di cui si da la disponibilita</h2>
                <h3>Attenzione: se verra inserito un username non valido, non ci sara nessun salvataggio della disponibilita data</h3>
                <form action="disposizione.jsp" method="POST">
                    <%
                        String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
                        Connection connection=null;
                        String sportQuery=null;
                        try{
                            Class.forName(DRIVER);
                        }
                        catch (ClassNotFoundException e) {
                            out.println("Errore: Impossibile caricare il Driver Ucanaccess");
                        }
                        try{
                            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                            sportQuery = "SELECT tipo From Sport;";
                            Statement st = connection.createStatement();
                            ResultSet result = st.executeQuery(sportQuery);
                            out.println("<select name='sport' id='sport'>");
                            out.println("<option value=null selected>Selezionare un'attivita</option>");
                            while(result.next()){                               
                                    out.println("<option value='"+result.getString(1)+"'>"+result.getString(1)+"</option>");
                            }
                            out.println("</select>");                        
                        }
                        catch(Exception e){
                            System.out.println(e);
                        }
                    %>
                    <input type="text" id="data" name="data" placeholder="data es. 15/01/2022">             
                    <input type="text" id="orario" name="orario" placeholder="ora es. 15-30-18:30" required>
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
                    String Sport = request.getParameter("sport");   
                    String Data = request.getParameter("data");
                    String ora = request.getParameter("orario");
                    String Paese = request.getParameter("paese");
                    String Via = request.getParameter("via");
                    String num = request.getParameter("numero");
                    String prov = request.getParameter("provincia");
                    String preno = "No";
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
                        verifica = "SELECT username FROM Gestori WHERE username = '"+user+"';";
                        Statement stat = connection.createStatement();
                        ResultSet r = stat.executeQuery(verifica);
                        
                        if((user !=null) && (Sport != null) && (Data != null) && (ora != null) && (Paese != null) && (Via != null) && (num != null) && (prov != null)){
                            if (r.next()){
                                query = "INSERT INTO Prenotazioni(username,sport,orario,paese,via,numero,provincia,prenotato,data) VALUES('"+user+"','"+Sport+"','"+ora+"','"+Paese+"','"+Via+"','"+num+"','"+prov+"','"+preno+"','"+Data+"')"; 
                                stat.executeUpdate(query);
                            }
                            
                        }
                    }
                    catch(Exception e){
                        out.println(e);
                    }
                    if((user !=null) && (Sport != null) && (Data != null) && (ora != null) && (Paese != null) && (Via != null) && (num != null) && (prov != null)){
                        String url = "Gestore.html";
                        response.sendRedirect(url);
                    } 
                %>
    </body>
</html>
