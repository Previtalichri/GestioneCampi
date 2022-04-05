<html>
    <body>
        <h1> Benvenuti nella pagina Utente, qui e' possibile selezionare tutte le azioni che puoi e vuoi fare</h1>
        <input type="button" onclick="location.href='ricerca.jsp'" value="Cerca"/>
        <input type="button" onclick="location.href='elencoPren.jsp'" value="Elenco prenotazioni"/>
        <input type="button" onclick="location.href='logOutUtente.jsp'" value="log out"/>
        <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        <%@ page import="java.util.*" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
        
        <%
            String utente;
            String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
            Connection connection = null;
            String dataQuery = null;
            String eliminazione = null;
            try{
                Class.forName(DRIVER);
            }
            catch (ClassNotFoundException e) {
                out.println("Errore: Impossibile caricare il Driver Ucanaccess");
            }     
            try{
                HttpSession s = request.getSession();
                utente = (String)s.getAttribute("username");
                String ruolo = (String)s.getAttribute("ruolo");  
                if(ruolo == "gestore"){
                    response.sendRedirect("Gestore.jsp"); 
                }   
            }
            catch(Exception e){
                System.out.println(e);
            }
        %>

    </body>
</html>


