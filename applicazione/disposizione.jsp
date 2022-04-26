<html>
    <body>
        <h1>Benvenuto nella pagina di messa a disposizione</h1>
        <h2>Qui potrai mettere a disposizione i tuoi campi</h2>

                <h2>Indicare: comune,via,numero,sport del campo di cui si da la disponibilita</h2>
                <form action="disposizione.jsp" method="POST">
                    <%
                        String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
                        Connection connection=null;
                        String sportQuery=null;
                        String prov=null;
                        String comuneQuery=null;    
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
                            HttpSession s = request.getSession();
                            prov=(String)s.getAttribute("provincia"); 
			    String ruolo = (String)s.getAttribute("ruolo");
                            if (ruolo == null){
                    		response.sendRedirect("login.jsp");
                	    }
                            comuneQuery = "SELECT nome,provincia FROM Comuni WHERE provincia = '"+prov+"';"; 
                            result = st.executeQuery(comuneQuery);
                            out.println("<select name='comune' id ='comune'>");
                            out.println("<option value=null selected>Selezionare un paese</option>");
                            while(result.next()){                               
                                    out.println("<option value='"+result.getString(1)+"'>"+result.getString(1)+"</option>");
                            }
                            out.println("</select>"); 

                        }
                        catch(Exception e){
                            System.out.println(e);
                        }
                    %>         
                    <input type="text" id="via" name="via" placeholder="via" required>
                    <input type="number" id="numero" name="numero" placeholder="numero" min='0'required>
                    <input type="submit" id="btn" name="btn" value="Metti a disposizione">
                </form>
                <%@ page import="java.io.*" %>
                <%@ page import="java.sql.*" %>
                <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
                <%@ page import="java.util.concurrent.TimeUnit" %>
                <%
                    String Sport = request.getParameter("sport");   
                    String Comune = request.getParameter("comune");
                    String Via = request.getParameter("via");
                    String num = request.getParameter("numero");
                    String query;
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
			            prov = (String)s.getAttribute("provincia");
                        connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                        Statement stat = connection.createStatement();
                        
                        if((user !=null) && (prov != null) && (Sport != null) && (Comune != null) && (Via != null) && (num != null)){                            
                                query = "INSERT INTO Struttura(Sede,Provincia,Comune,Via,Numero,Sport) VALUES('"+user+"','"+prov+"','"+Comune+"','"+Via+"','"+num+"','"+Sport+"');";
                                System.out.println(query); 
                                stat.executeUpdate(query);      
                        }
                    }
                    catch(Exception e){
                        out.println(e);
                    }
                    if((user !=null) && (prov != null) && (Sport != null) && (Comune != null) && (Via != null) && (num != null)){
                        String url = "Gestore.html";
                        response.sendRedirect(url);
                    } 
                %>
                 <input type="button" onclick="location.href='Gestore.jsp'" value="Home"/>
    </body>
</html>
