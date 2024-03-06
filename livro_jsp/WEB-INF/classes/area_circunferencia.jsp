<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title> Cálculo da Área de uma Circunferência </title>
</head>

<body>
  <% int intRaio, intArea;
    intRaio=Integer.parseInt(request.getParameter("raio"));
    intArea=(3.14159 * (intRaio * intRaio));
    %>

    <h2> Valor da area da Circunferência: <%= intArea %>
    </h2>
</body>

</html>