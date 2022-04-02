
<!DOCTYPE HTML>
<html>

  <body>
    <%@ page import="java.io.*" %>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
    <a href="ricercaGuest.jsp">Clicca qui per cercare un campo</a>
    <h1>Benvenuto nella pagina di registrazione</h1>
    <form action="index.jsp" form="POST">
    <select id="tipo" name="tipo">
        <option value="utente">Utente</option>
        <option value="gestore">Gestore</option>
    </select>
    <input type="submit" id="btn" name="btn" value="Avvia registrazione">
    </form>

    <%
        String type = request.getParameter("tipo");
        if(type =="utente"){
            out.println("<form action='registrazioneUtente.jsp' method='POST'>");
        <input type="text" id="uernameUt" name="usernameUt" placeholder="username" required>
        <input type="password" id="passwordUt" name="passwordUt" placeholder="password" required>
        <input type="submit" id="btn" name="btn" value="registrati">
      </form>
      <a href="login.jsp">Hai gia un account?</a>

        }
    %>
      
  </body>
</html>