<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Menu de Pizzas</title>
        <meta lang="PT-BR" charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <form method="post" action="CalculoAreaCircunferencia" name="calculo_area">
        <h1 style="text-align: center;"> Cálculo da área de uma circunferência</h1>
        <p> Digite o valor do raio: <input name="raio" type="number"><br>
        </p>
        <p>
        <input type="submit" name="btnCalcular" id="btnCalcular" value="Calcular"> <br>
        </p>
        </form>
        <a href="index.jsp" class="btn-voltar">Voltar à Página Inicial</a>
    </body>
</html>