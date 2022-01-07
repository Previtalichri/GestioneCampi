<html>
    <head>
        <style>
            table {
                border-collapse:collapse;
                table-layout:fixed;
                width: 100%;
            }
            td, th {
                border:1px solid #ddd;
                padding:8px;
            }
        </style>
    </head>
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
            Connection connection=null;
            String ricerca;
            String User=null;
            try{
                Class.forName(DRIVER);
            }
            catch (ClassNotFoundException e) {
                out.println("Errore: Impossibile caricare il Driver Ucanaccess");
            }
            try{
                HttpSession s = request.getSession();
                User = (String)s.getAttribute("username");
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                ricerca = "SELECT username,sport,giorno,orario,paese,via,numero,provincia,prenotato FROM Prenotazioni WHERE username = '"+User+"';";
                Statement st = connection.createStatement();
                ResultSet r = st.executeQuery(ricerca);            
                if(User != null){                                                
                        out.println("<table>"); 
                            out.println("<tr>");
                                out.println("<th>Sede</th>");
                                out.println("<th>Sport</th>");
                                out.println("<th>Giorno</th>");
                                out.println("<th>Orario</th>");
                                out.println("<th>Provincia</th>"); 
                                out.println("<th>Paese</th>");   
                                out.println("<th>Via</th>");
                                out.println("<th>Numero</th>");   
                            out.println("</tr>"); 
                            out.println("</table>");
                            while(r.next()){
                                out.println("<table>"); 
                                    out.println("<tr>");
                                        out.println("<td>"+r.getString(1)+"</td>");
                                        out.println("<td>"+r.getString(2)+"</td>");
                                        out.println("<td>"+r.getString(3)+"</td>");
                                        out.println("<td>"+r.getString(4)+"</td>");
                                        out.println("<td>"+r.getString(8)+"</td>");
                                        out.println("<td>"+r.getString(5)+"</td>");
                                        out.println("<td>"+r.getString(6)+"</td>");
                                        out.println("<td>"+r.getString(7)+"</td>");
                                    out.println("</tr>");
                                out.println("</table>");
                            }    
                } 
            }                   
            catch(Exception e){
                out.println(e);
            } 

        %>
        <br>
        <input type="button" onclick="location.href='rimozioneCamp.jsp'" value="Metti a disposizione"/>
    </body>
</html>