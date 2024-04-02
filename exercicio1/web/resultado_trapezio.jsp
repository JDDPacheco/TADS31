<!DOCTYPE html>
<html>
    <head>
        <title>Resultado do C�lculo da �rea do Trap�zio</title>
        <meta lang="PT-BR" charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <h1>Resultado do C�lculo da �rea do Trap�zio</h1>
        <p>Valor da base menor: <%= request.getAttribute("base_menor") %></p>
        <p>Valor da base maior: <%= request.getAttribute("base_maior") %></p>
        <p>Valor da altura: <%= request.getAttribute("altura") %></p>
        <p><span style="font-weight: bold; color: #ff5733;">�rea do Trap�zio: <%= request.getAttribute("area") %></span></p>
        <a href="menu.jsp" class="btn-voltar">Voltar � P�gina Inicial</a>
        <a href="form-trapezio.html" class="btn-voltar">Novas dimens�es</a>
    </body>
</html>