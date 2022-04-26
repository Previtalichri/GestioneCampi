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
        <%@ page import="java.text.*" %>
        <%@ page import="java.util.Date" %>
        <%@ page import="java.time.format.DateTimeFormatter" %>
        <%@ page import="java.time.LocalDate" %>
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
                DateTimeFormatter form = DateTimeFormatter.ofPattern("dd/MM/yyyy");  
                LocalDate oggi = LocalDate.now();   
                HttpSession s = request.getSession();
                String ruolo = (String)s.getAttribute("ruolo");
                if (ruolo == null){
                    response.sendRedirect("login.jsp");
                }
                String sede = (String)s.getAttribute("username"); 
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                ricerca = "SELECT Sede,Utente,orario,data FROM Prenotazioni WHERE Sede = '"+sede+"';";
                Statement st = connection.createStatement();
                boolean isbefore=false; 
                LocalDate data=null;      
                String dataDb = null;
                ResultSet r = st.executeQuery(ricerca);        
                if(sede != null){                                                
                        out.println("<table>"); 
                            out.println("<tr>");
                                out.println("<th>Sede ospitante</th>");
                                out.println("<th>Orario</th>");
                                out.println("<th>Data</th>");  
                            out.println("</tr>"); 
                            out.println("</table>");
                            while(r.next()){
                                dataDb = r.getString(4);
                                data = LocalDate.parse(dataDb,form);
                                isbefore = data.isBefore(oggi);
                                if(isbefore){
                                }
                                else{
                                out.println("<table>"); 
                                    out.println("<tr>");
                                        out.println("<td>"+r.getString(1)+"</td>");
                                        out.println("<td>"+r.getString(3)+"</td>");
                                        out.println("<td>"+r.getString(4)+"</td>");
                                    out.println("</tr>");
                                out.println("</table>");
                                }
                            }    
                }  
            }                   
            catch(Exception e){
                out.println(e);
            }      
        %>
        <br><input type="button" onclick="location.href='Gestore.jsp'" value="Home"/>
    </body>
</html>