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
                <form action prenotazione.jsp method="post">
                    <%
                        String oraQuery = "SELECT ora FROM Orari;";
                        connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                        Statement s = connection.createStatement();
                        ResultSet r = s.executeQuery(oraQuery);                       
                        out.println("<select name='ora' id='ora'>");
                        out.println("<option value=null selected>Selezionare un orario</option>");
                        while(r.next()){                               
                                out.println("<option value='"+r.getString(1)+"'>"+r.getString(1)+"</option>"); //per mostrare tutti gli orari
                        }
                        out.println("</select>");
                        out.println("<input type='text' id='data' name='data' placeholder='data es. 01/02/2022'>");
                    %>
                    <input type="submit" id="btn" name="btn" value="Verifica disponibilità">
                </form>
                <%
                    try{
                        DateTimeFormatter form = DateTimeFormatter.ofPattern("dd/MM/yyyy");  
                        LocalDate oggi = LocalDate.now();
                        LocalDate d = null;
                        String orario=request.getParameter("ora");
                        String Data=request.getParameter("data");
                        String sede = request.getParameter("sede");   
                        HttpSession sess = request.getSession();
                        String User = (String)sess.getAttribute("username");
			            String ruolo = (String)sess.getAttribute("ruolo");
                        if (ruolo == null){
                    		response.sendRedirect("login.jsp");
                	}
                        connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                        Statement st = connection.createStatement();                        
                        String verifica = "SELECT Sede,orario,data FROM Prenotazioni WHERE Sede = '"+sede+"' AND orario = '"+orario+"' AND data= '"+Data+"';";
                        r = st.executeQuery(verifica);
                        if(r.next()){
                            out.println("<h1>Orario e/o data non disponibile</h1>");
                        }
                        else {
                            if((User != null) && (sede !=null) && (orario != null) && (Data != null)){                                     
                                    d  = LocalDate.parse(Data,form);
                                    boolean isbefore = d.isBefore(oggi);
                                    if(isbefore){
                                        out.println("<h1>Immettere una date successiva a quella di oggi</h1>");  
                                    }
                                    else{
                                        query = "INSERT INTO Prenotazioni(Sede,Utente,orario,data) VALUES('"+sede+"','"+User+"','"+orario+"','"+Data+"');";                             
                                        st.executeUpdate(query);   
                                        out.println("<h1>Prenotazione avvenuta con successo</h1>");         
                                    }                                              
                            }
                            if((User != null) && (sede !=null) && (orario != null) && (Data != null)){
                            out.println("<a href='Utente.jsp'>Clicca qui per tornare alla home</a>");
                        }                          
                    }                        
                    }
                    catch(Exception e){
                        out.println(e);
                    }                   
                %>
    </body>
</html>
 