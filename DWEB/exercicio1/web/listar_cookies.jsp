<%-- 
    Document   : listar_cookies
    Created on : 02/04/2024, 19:52:55
    Author     : José Diogo Dutra Pacheco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css">
        <title>Listar Cookies</title>
    </head>
    <body>
        <h1> Bem vindo ao exemplo de visualizacao de cookies: </h1>
        <%@ page import = "javax.servlet.http.*" %>
        <%
            Cookie menuCookie[] = request.getCookies();
            
            for(Cookie lista: request.getCookies()){
                
            }
        %>
    </body>
</html>
