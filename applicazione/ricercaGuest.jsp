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
        <h2>Indicare sport e/o provincia del campo richiesto</h2>
        <h3>Essendo un utente non registrato qui sarà possibile solo cercare e non prenotare</h3>
        <a href="index.jsp">Per registrarsi clicca qui</a><br><br>
        <form action="ricercaGuest.jsp" method="POST">
            <%
                        String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
                        Connection connection=null;
                        String sportQuery=null;
                        String provQuery=null;
                        HttpSession s = request.getSession();
                        String ruolo = (String)s.getAttribute("provincia");
                            if (ruolo == null){
                    		response.sendRedirect("login.jsp");
                	    }
                        try{
                            Class.forName(DRIVER);
                        }
                        catch (ClassNotFoundException e) {
                            out.println("Errore: Impossibile caricare il Driver Ucanaccess");
                        }
                        try{
                            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                            sportQuery = "SELECT tipo FROM Sport;";
                            Statement st = connection.createStatement();
                            ResultSet result = st.executeQuery(sportQuery);
                            out.println("<select name='sport' id='sport'>");
                            out.println("<option value=null selected>Selezionare un'attivita</option>");
                            while(result.next()){                               
                                    out.println("<option value='"+result.getString(1)+"'>"+result.getString(1)+"</option>");
                            }
                            out.println("</select>");
                            provQuery = "SELECT Nome FROM Province;";
                            result = st.executeQuery(provQuery);
                            out.println("<select name='provincia' id='provincia'>");
                            out.println("<option value=null selected>Selezionare una provincia</option>");
                            while(result.next()){                               
                                    out.println("<option value='"+result.getString(1)+"'>"+result.getString(1)+"</option>");
                            }
                            out.println("</select>");

                        }
                        catch(Exception e){
                            System.out.println(e);
                        }
                    %>  
            <input type="submit" id="btn" name="btn" value="Cerca">
        </form>
        
        <%
            String Sport = request.getParameter("sport");
            String prov = request.getParameter("provincia");
            String ricerca;	
	        String verifica;
            try{
                Class.forName(DRIVER);
            }
            catch (ClassNotFoundException e) {
                out.println("Errore: Impossibile caricare il Driver Ucanaccess");
            }
            try{
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
		
                ricerca = "SELECT Sede,Provincia,Comune,Via,Numero,Sport FROM Struttura WHERE sport = '"+Sport+"'AND Provincia = '"+prov+"';";
                Statement s = connection.createStatement();
                ResultSet r = s.executeQuery(ricerca);           
                if((Sport != null) && (prov != null)){                                                    
                        out.println("<table>"); 
                        out.println("<tr>");
                            out.println("<th>Sede ospitante</th>");
                            out.println("<th>Provincia</th>");
                            out.println("<th>Comune</th>");
                            out.println("<th>Via</th>"); 
                            out.println("<th>Numero</th>");  
                            out.println("<th>Sport</th>"); 
                        out.println("</tr>"); 
                        out.println("</table>");
                        while(r.next()){         
                            out.println("<table>"); 
                                out.println("<tr>");
                                    out.println("<td>"+r.getString(1)+"</td>");
                                    out.println("<td>"+r.getString(2)+"</td>");
                                    out.println("<td>"+r.getString(3)+"</td>");
                                    out.println("<td>"+r.getString(4)+"</td>");
                                    out.println("<td>"+r.getString(5)+"</td>");
                                    out.println("<td>"+r.getString(6)+"</td>"); 
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