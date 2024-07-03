<%-- 
    Document   : menu
    Created on : 02/07/2024, 20:32:04
    Author     : Diogo e Cristian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Pizzaria Oliveira & Pacheco</title>
    <meta lang="PT-BR" charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <h1>Menus de Pizzas</h1>
    <form id="pedidoForm" action="calculo_pedido.jsp" method="POST">
        <fieldset>
    <legend>Escolha o sabor da sua Pizza:</legend>
    <div>
        <input type="checkbox" id="calabresa" name="sabor" value="Calabresa">
        <label for="calabresa">Calabresa</label>
    </div>
    <div>
        <input type="checkbox" id="portuguesa" name="sabor" value="Portuguesa">
        <label for="portuguesa">Portuguesa</label>
    </div>
    <div>
        <input type="checkbox" id="frango" name="sabor" value="Frango com Catupiry">
        <label for="frango">Frango com Catupiry</label>
    </div>
    <div>
        <input type="checkbox" id="quatroQueijos" name="sabor" value="Quatro Queijos">
        <label for="quatroQueijos">Quatro Queijos</label>
    </div>
    <div>
        <input type="checkbox" id="margarita" name="sabor" value="Margarita">
        <label for="margarita">Margarita</label>
    </div>
    <div>
        <input type="checkbox" id="romeuJulieta" name="sabor" value="Romeu e Julieta">
        <label for="romeuJulieta">Romeu e Julieta</label>
    </div>
    <div>
        <input type="checkbox" id="caboquinho" name="sabor" value="Caboquinho">
        <label for="caboquinho">Caboquinho</label>
    </div>
</fieldset>

        <input type="submit" value="Adicionar ao Carinho">
        
        <a href="pedido.html">Finalizar Pedido</a>
    </form>

    <script>
// Obtém todos os checkboxes dentro do campo de cobertura
const checkboxes = document.querySelectorAll('input[name="sabor"]');

// Adiciona um listener de evento para cada checkbox
checkboxes.forEach((checkbox) => {
    checkbox.addEventListener('change', function() {
        // Desmarca todos os checkboxes, exceto o que foi clicado
        checkboxes.forEach((cb) => {
            if (cb !== this) {
                cb.checked = false;
            }
        });
    });
});
    </script>
</body>

</html>
