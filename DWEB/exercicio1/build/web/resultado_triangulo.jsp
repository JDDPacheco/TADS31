<!DOCTYPE html>
<html>
    <head>
        <title>Resultado do C�lculo da �rea do Tri�ngulo</title>
        <meta lang="PT-BR" charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <h1>Resultado do C�lculo da �rea do Tri�ngulo-Ret�ngulo</h1>
        <p>Valor da base maior: <%= request.getAttribute("base") %></p>
        <p>Valor da altura: <%= request.getAttribute("altura") %></p>
        <p><span style="font-weight: bold; color: #ff5733;">�rea do Tri�ngulo: <%= request.getAttribute("area") %></span></p>
        <a href="menu.jsp" class="btn-voltar">Voltar � P�gina Inicial</a>
        <a href="form-triangulo.html" class="btn-voltar">Novas dimens�es</a>
    </body>
</html>