<%-- 
    Document   : criar_cookies
    Created on : 02/04/2024, 19:35:13
    Author     : José Diogo Dutra Pacheco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css">
        <title>Criar Cookies</title>
    </head>
    <body>
        <h1> Bem vindo ao exemplo de criacao de cookies: </h1>
        <%@ page import = "javax.servlet.http.*" %>
        <%
            Cookie cookieLivros;
            
            cookieLivros = new Cookie("Codigo7042","Arquitetura_de_Computadores");
            response.addCookie(cookieLivros);
            
            cookieLivros = new Cookie("Codigo1093","Algoritmo_e_Linguagens");
            response.addCookie(cookieLivros);
            
            cookieLivros = new Cookie("Codigo7042","Desenvolvimento_para_Web_com_Java");
            response.addCookie(cookieLivros);
        %>
    </body>
</html>
