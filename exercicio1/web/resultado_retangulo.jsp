<!DOCTYPE html>
<html>
<head>
    <title>Resultado do Cálculo da Área do Retângulo</title>
    <meta lang="PT-BR" charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Resultado do Cálculo da Área do Retângulo</h1>
    <p>Valor da base: <%= request.getAttribute("base") %></p>
    <p>Valor da altura: <%= request.getAttribute("altura") %></p>
    <p><span style="font-weight: bold; color: #ff5733;">Área do Retângulo: <%= request.getAttribute("area") %></span></p>
    <a href="index.html" class="btn-voltar">Voltar à Página Inicial</a>
        <a href="form-retangulo.html" class="btn-voltar">Novas dimensões</a>
</body>
</html>