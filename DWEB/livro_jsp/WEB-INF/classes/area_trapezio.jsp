<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title> Cálculo da Área de um Trapézio </title>
</head>

<body>
  <% int intBaseMaior, intBaseMenor, intAltura, intArea;
    intBaseMenor=Integer.parseInt(request.getParameter("base_menor"));
    intBaseMaior=Integer.parseInt(request.getParameter("base_maior"));
    intAltura=Integer.parseInt(request.getParameter("altura")); intArea=((intBaseMenor + intBaseMaior) * intAltura)/2;
    %>

    <h2> Valor da area do trapezio: <%= intArea %>
    </h2>
</body>

</html>