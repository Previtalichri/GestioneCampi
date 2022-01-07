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
                        out.println("<table>"); 
                        out.println("<tr>");
                            out.println("<th>Sede ospitante</th>");
                            out.println("<th>Orario disponibile</th>");
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
        <input type="button" id="btn" name="btn" onclick="location.href='prenotazione.jsp'" value="Prenota"/>

    </body>
</html>