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
    <%@ page import="java.io.*" %>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
        <h1> Benvenuto nella pagina di ricerca</h1>
        <h2>Indicare sport e giorno di cui si fa la richiesta</h2>
        <form action="ricerca.jsp" method="POST">
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
            <input type="submit" id="btn" name="btn" value="Cerca">
        </form>
        
        <%
            String Sport = request.getParameter("sport");
            String Data = request.getParameter("data");
            String ricerca;
            try{
                Class.forName(DRIVER);
            }
            catch (ClassNotFoundException e) {
                out.println("Errore: Impossibile caricare il Driver Ucanaccess");
            }
            try{
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                ricerca = "SELECT username,sport,orario,paese,via,numero,provincia,prenotato,data FROM Prenotazioni WHERE sport = '"+Sport+"' AND prenotato = 'No' AND data = '"+Data+"';";
                Statement s = connection.createStatement();
                ResultSet r = s.executeQuery(ricerca);  
                int id=0;          
                if((Sport != null) && (Data != null)){                                                    
                        out.println("<table>"); 
                        out.println("<tr>");
                            out.println("<th>Sede ospitante</th>");
                            out.println("<th>Orario disponibile</th>");
                            out.println("<th>Provincia</th>");
                            out.println("<th>Paese</th>");
                            out.println("<th>Via</th>"); 
                            out.println("<th>Numero</th>");  
                            out.println("<th>Prenota</th");    
                        out.println("</tr>"); 
                        out.println("</table>");
                        while(r.next()){
                            id=id+1;
                            out.println("<table>"); 
                                out.println("<tr>");
                                    out.println("<td>"+r.getString(1)+"</td>");
                                    out.println("<td>"+r.getString(3)+"</td>");
                                    out.println("<td>"+r.getString(7)+"</td>");
                                    out.println("<td>"+r.getString(4)+"</td>");
                                    out.println("<td>"+r.getString(5)+"</td>");
                                    out.println("<td>"+r.getString(6)+"</td>");
                                    out.print("<td><a href='prenotazione.jsp?username="+r.getString(1)+"&sport="+Sport+"&orario="+r.getString(3)+"&paese="+r.getString(4)+"&provincia="+r.getString(7)+"&data="+Data+"'>Prenota qui</a></td>");
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