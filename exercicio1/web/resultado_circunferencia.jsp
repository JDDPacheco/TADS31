<!DOCTYPE html>
<html>
    <head>
        <title>Resultado do C�lculo da �rea da Circunfer�ncia</title>
        <meta lang="PT-BR" charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <h1>Resultado do C�lculo da �rea da Circunfer�ncia</h1>
        <p>Valor do raio: <%= request.getAttribute("raio") %></p>
        <p><span style="font-weight: bold; color: #ff5733;">�rea da Circunfer�ncia: <%= request.getAttribute("area") %></span></p>
        <a href="index.html" class="btn-voltar">Voltar ao In�cio</a>
        <a href="form-circunferencia.html" class="btn-voltar">Novas dimens�es</a>
    </body>
</html>
