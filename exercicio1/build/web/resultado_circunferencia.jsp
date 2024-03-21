<!DOCTYPE html>
<html>
    <head>
        <title>Resultado do Cálculo da Área da Circunferência</title>
        <meta lang="PT-BR" charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <h1>Resultado do Cálculo da Área da Circunferência</h1>
        <p>Valor do raio: <%= request.getAttribute("raio") %></p>
        <p><span style="font-weight: bold; color: #ff5733;">Área da Circunferência: <%= request.getAttribute("area") %></span></p>
        <a href="index.html" class="btn-voltar">Voltar ao Início</a>
        <a href="form-circunferencia.html" class="btn-voltar">Novas dimensões</a>
    </body>
</html>
