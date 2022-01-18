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
        <h1>Benvenuto nella pagina di visualizzazione delle varie prenotazioni</h1>
        <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        <%@ page import="java.util.*" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
        <%
            String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
            Connection connection=null;
            String ricerca;
            try{
                Class.forName(DRIVER);
            }
            catch (ClassNotFoundException e) {
                out.println("Errore: Impossibile caricare il Driver Ucanaccess");
            }
            try{
                HttpSession s = request.getSession();
                String User = (String)s.getAttribute("username"); 
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                ricerca = "SELECT username,sport,orario,paese,via,numero,provincia,prenotato,data FROM Prenotazioni WHERE prenotato = '"+User+"';";
                Statement st = connection.createStatement();
                ResultSet r = st.executeQuery(ricerca);        
                if(User != null){                                                
                        out.println("<table>"); 
                            out.println("<tr>");
                                out.println("<th>Sede ospitante</th>");
                                out.println("<th>Sport</th>");
                                out.println("<th>Orario</th>");
                                out.println("<th>Provincia</th>"); 
                                out.println("<th>Paese</th>");   
                                out.println("<th>Via</th>");
                                out.println("<th>Numero</th>"); 
                                out.println("<th>Data</th>"); 
                                out.println("<th>Rimuovi prenotazione</th>"); 
                            out.println("</tr>"); 
                            out.println("</table>");
                            while(r.next()){
                                out.println("<table>"); 
                                    out.println("<tr>");
                                        out.println("<td>"+r.getString(1)+"</td>");
                                        out.println("<td>"+r.getString(2)+"</td>");
                                        out.println("<td>"+r.getString(3)+"</td>");
                                        out.println("<td>"+r.getString(7)+"</td>");
                                        out.println("<td>"+r.getString(4)+"</td>");
                                        out.println("<td>"+r.getString(5)+"</td>");
                                        out.println("<td>"+r.getString(6)+"</td>");
                                        out.println("<td>"+r.getString(9)+"</td>");
                                        out.print("<td><a href='rimozionePren.jsp?username="+r.getString(1)+"&sport="+r.getString(2)+"&orario="+r.getString(3)+"&paese="+r.getString(4)+"&provincia="+r.getString(7)+"&data="+r.getString(9)+"'>Rimuovi</a></td>");
                                    out.println("</tr>");
                                out.println("</table>");
                            }    
                }  
            }                   
            catch(Exception e){
                out.println(e);
            }      
        %>
    </body>
</html>