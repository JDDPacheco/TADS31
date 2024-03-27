<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <meta lang="PT-BR" charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <h1 style="text-align: center;"> Faça seu login </h1>
        <form action="AutenticarLogin" method="post" name="login">
        <p> Usuário: <input name="usuario" type="text" required><br>
        </p>
        <label for="senha">Senha:</label>
        <input type="password" id="senha" name="senha">
        <input type="submit" name="btnCalcular" id="btnCalcular" value="Enviar">
</form>
    </body>
</html>
