<%-- 
    Document   : menu
    Created on : 02/07/2024, 20:32:04
    Author     : Diogo e Cristian
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pizzaria Oliveira & Pacheco</title>
    <meta lang="PT-BR" charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <h1>Menus de Pizzas</h1>
        <div class="container">
        <c:forEach var="pizza" items="${pizzas}">
            <div class="pizza-block">
                <h2>${pizza.nome}</h2>
                <p>${pizza.descricao}</p>
                <div class="price">R$ ${pizza.preco}</div>
                <form action="carrinho" method="post">
                    <input type="hidden" name="id" value="${pizza.id}">
                    <input type="submit" value="Adicionar ao Carrinho">
                </form>
            </div>
        </c:forEach>
    </div>              
</body>

</html>
