<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <body>
        <%
        try{
            HttpSession s = request.getSession();         
            s.invalidate() ;
            String url = "loginUtente.jsp";
            response.sendRedirect(url);
        }
        catch(Exception e){
            out.println(e);
        }
        %>
    </body>
</html>
