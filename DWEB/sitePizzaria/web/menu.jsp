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
    <form id="pedidoForm" action="carrinho.jsp" method="POST">
        <fieldset>
            <legend>Escolha o sabor da sua Pizza:</legend>
            <div class="container">
                <div class="pizza-block" data-value="Calabresa">
                    <input type="radio" class="hidden-input" name="sabor" value="Calabresa" id="calabresa">
                    <h2>Calabresa</h2>
                    <p>Calabresa com cebola</p>
                    <div class="price">R$ 25,00</div>
                </div>
                <div class="pizza-block" data-value="Portuguesa">
                    <input type="radio" class="hidden-input" name="sabor" value="Portuguesa" id="portuguesa">
                    <h2>Portuguesa</h2>
                    <p>Presunto, ovo e cebola</p>
                    <div class="price">R$ 28,00</div>
                </div>
                <div class="pizza-block" data-value="Frango com Catupiry">
                    <input type="radio" class="hidden-input" name="sabor" value="Frango com Catupiry" id="frango">
                    <h2>Frango com Catupiry</h2>
                    <p>Frango desfiado com catupiry</p>
                    <div class="price">R$ 30,00</div>
                </div>
                <div class="pizza-block" data-value="Quatro Queijos">
                    <input type="radio" class="hidden-input" name="sabor" value="Quatro Queijos" id="quatroQueijos">
                    <h2>Quatro Queijos</h2>
                    <p>Mussarela, provolone, gorgonzola e parmesão</p>
                    <div class="price">R$ 32,00</div>
                </div>
                <div class="pizza-block" data-value="Margarita">
                    <input type="radio" class="hidden-input" name="sabor" value="Margarita" id="margarita">
                    <h2>Margarita</h2>
                    <p>Tomate, mussarela e manjericão</p>
                    <div class="price">R$ 27,00</div>
                </div>
                <div class="pizza-block" data-value="Romeu e Julieta">
                    <input type="radio" class="hidden-input" name="sabor" value="Romeu e Julieta" id="romeuJulieta">
                    <h2>Romeu e Julieta</h2>
                    <p>Goiabada com queijo</p>
                    <div class="price">R$ 29,00</div>
                </div>
                <div class="pizza-block" data-value="Caboquinho">
                    <input type="radio" class="hidden-input" name="sabor" value="Caboquinho" id="caboquinho">
                    <h2>Caboquinho</h2>
                    <p>Tucumã, banana e queijo coalho</p>
                    <div class="price">R$ 35,00</div>
                </div>
            </div>
        </fieldset>

        <input type="submit" value="Adicionar ao Carrinho">
        
        <a href="confirmacao.html">Finalizar Pedido</a>
    </form>

    <script>
        const pizzaBlocks = document.querySelectorAll('.pizza-block');
        const hiddenInputs = document.querySelectorAll('.hidden-input');

        pizzaBlocks.forEach(block => {
            block.addEventListener('click', () => {
                pizzaBlocks.forEach(b => b.classList.remove('selected'));
                block.classList.add('selected');
                block.querySelector('.hidden-input').checked = true;
            });
        });
    </script>
</body>

</html>
