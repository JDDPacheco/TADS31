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
    <div class="container">
        <h1>Faça seu login</h1>
        
        <!-- Verifica se há uma mensagem de erro e exibe um alerta -->
        <% 
        String mensagemErro = (String) request.getAttribute("mensagemErro");
        if (mensagemErro != null && !mensagemErro.isEmpty()) {
        %>
        <div class="alert">
            <%= mensagemErro %>
        </div>
        <% } %>
        
        <form action="AutenticarLogin" method="post" name="login">
            <p>Usuário: <input name="usuario" type="text" required></p>
            <p>Senha: <input type="password" id="senha" name="senha" required></p>
            <input type="submit" name="btnCalcular" id="btnCalcular" value="Enviar">
        </form>
    </div>
</body>
</html>

