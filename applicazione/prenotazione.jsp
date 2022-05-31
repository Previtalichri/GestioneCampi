<html>
    <body>  
                <%@ page import="java.io.*" %>
                <%@ page import="java.sql.*" %>
                <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
                <%@ page import="java.util.concurrent.TimeUnit" %>
                <%@ page import="java.util.Date" %>
                <%@ page import="java.time.format.DateTimeFormatter" %>
                <%@ page import="java.time.LocalDate" %>

                <h1>Benvenuto nella pagina della prenotazione</h1>
                <h2>Immettere orario e data della richiesta</h2>
                <h3>Se l'orario e la data saranno disponibili, sarete direttamente indirizzati alla home</h3>
                <h4>In caso contrario immettere un altro orario e/o data</h4>
                <%
                    String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
                    Connection connection=null;
            
                    String query;
                    try{
                        Class.forName(DRIVER);
                    }
                    catch (ClassNotFoundException e) {
                        out.println("Errore: Impossibile caricare il Driver Ucanaccess");
                    }
                %>
                <!-- per selezionare date e orari -->
                <form action = prenotazione.jsp method="post">
                    
                                           
                        <input type='text' id='data' name='data' placeholder='data es. 01/02/2022'>
                    
                        <input type="submit" id="btn" name="btn" value="Verifica disponibilità">
                        </form>

                    <%  
                        String sede = request.getParameter("sede");   
                    try{
                        DateTimeFormatter form = DateTimeFormatter.ofPattern("dd/MM/yyyy");  
                        LocalDate oggi = LocalDate.now();
                        LocalDate d = null;
                        String Data=request.getParameter("data");
                        
                        HttpSession sess = request.getSession();
                        String User = (String)sess.getAttribute("username");
			            String ruolo = (String)sess.getAttribute("ruolo");
                        if (ruolo == null){
                    		response.sendRedirect("login.jsp");
                        }
                        System.out.println(User+" "+sede);
                        if((User != null) && (sede !=null) && (Data != null)){   
                            System.out.println("lkjhblkjhb");                                  
                            d  = LocalDate.parse(Data,form);
                            boolean isbefore = d.isBefore(oggi);
                            if(isbefore){
                                out.println("<h1>Immettere una date successiva a quella di oggi</h1>");  
                            }
                            else{

                                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                                Statement st = connection.createStatement();  

                                String oraQuery = "SELECT ora FROM Orari;";
                                Statement s = connection.createStatement();
                                ResultSet r = s.executeQuery(oraQuery);    
                                String dataDisp = request.getParameter("data");
                                String controllo = "SELECT Sede,orario,data FROM Prenotazioni WHERE Sede = '"+sede+"' AND data= '"+dataDisp+"';";
                                Statement statement = connection.createStatement();
                                ResultSet result = statement.executeQuery(controllo);
                                out.println("<table>");
                                out.println("<tr>");
                                out.println("<th>Orari disponibili</th>");
                                out.println("<tr>");
                                out.println("</table>");
                                while(r.next()){
                                    out.println("aaaaaaaaaaaaaaaaa");
                                    while(result.next())  {
                                        out.println("bbbbbbbbbbbbbbbbbbb");
                                        if(!(r.getString(1).equals(result.getString(2))))  {
                                            out.println("ccccccccccccccc");
                                            out.println("<table>"); 
                                            out.println("<tr>");
                                            out.println("<td>"+r.getString(1)+"</td>");
                                            out.print("<td><a href='prenotazione.jsp?sede="+sede+"&sede="+sede+"&user="+User+"&orario="+r.getString(1)+"&data="+dataDisp+"&controllo='yes''>Clicca qui per completare la prenotazione</a></td>");
                                        }                          
                                    }                  
                                }
                                         
                            }                                              
                        }
                            if((User != null) && (sede !=null) && (Data != null)){
                            out.println("<a href='Utente.jsp'>Clicca qui per tornare alla home</a>");
                        }                          
                                           
                    }
                    catch(Exception e){
                        out.println(e);
                    }                   

                String controllo = request.getParameter("controllo");
                if (controllo == "yes"){
                    connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                    String user = request.getParameter("user");
                    String orario = request.getParameter("orario");
                    String data = request.getParameter("data");
                    Statement ss = connection.createStatement();  
                    try{
                        query = "INSERT INTO Prenotazioni(Sede,Utente,orario,data) VALUES('"+sede+"','"+user+"','"+orario+"','"+data+"');";                             
                        ss.executeUpdate(query);   
                        out.println("<h1>Prenotazione avvenuta con successo</h1>");      

                    }
                    catch (Exception e){
                        out.println(e);
                    }
                }
                
                

                %>
    </body>
</html>
 