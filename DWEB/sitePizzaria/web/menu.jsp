<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<jsp:useBean id="conexao" scope="page" class="banco_dados.Conexao" />
<jsp:useBean id="pizza" scope="page" class="model.Pizza" />
<!DOCTYPE html>
<html>
<head>
    <title>Menu de Pizzas</title>
    <meta lang="PT-BR" charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Menu de Pizzas</h1>
    <form action="processarPedido.jsp" method="post">
        <table border="5">
            <thead>
                <tr>
                    <th>Sabor</th>
                    <th>Descrição</th>
                    <th>Preço</th>
                    <th>Quantidade</th>
                </tr>
            </thead>
            <tbody>
            <% 
                if(conexao.abrirConexao()) {
                    pizza.configurarConexao(conexao.obterConexao());
                   
                    ResultSet rs = pizza.listarPizzas();
                    
                    if (rs != null) {
                        while (rs.next()) {
                            int id = rs.getInt("pzid");
                            String nome = rs.getString("pznome");
                            String descricao = rs.getString("pzdesc");
                            double preco = rs.getDouble("pzpreco");
                        %>
                        <tr>
                            <td><%= nome %></td>
                            <td><%= descricao %></td>
                            <td>R$ <%= preco %></td>
                            <td>
                                <input type="number" name="quantidade_<%= id %>" value="0" min="0">
                            </td>
                        </tr>
                    <%        
                        }
                    } else {
                        out.println("<tr><td colspan=\"4\">Nenhuma pizza encontrada.</td></tr>");
                    }
                    conexao.fecharConexao();
                } else {
                    out.println("<tr><td colspan=\"4\">Falha na conexão com o banco de dados.</td></tr>");
                }
            %>
            </tbody>
        </table>
        <br>
        <input type="submit" value="Enviar Pedido">
    </form>
</body>
</html>
