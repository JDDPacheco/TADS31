<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title> Cálculo da Área de um Retangulo </title>
</head>

<body>
  <% int intBase, intAltura, intArea;
    intBase=Integer.parseInt(request.getParameter("base"));
    intAltura=Integer.parseInt(request.getParameter("altura"));
    intArea=(intBase * intAltura);
    %>

    <h2> Valor da area do retangulo: <%= intArea %>
    </h2>
</body>

</html>