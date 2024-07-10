import banco_dados.Conexao;
import model.Pizza;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Conexao conexao = new Conexao();
        Pizza pizzaModel = new Pizza(conexao);

        List<Pizza> pizzaList = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = pizzaModel.buscarPizza(0); // Aqui buscamos todas as pizzas, ajuste conforme necessário
            while (rs.next()) {
                Pizza pizza = new Pizza(conexao);
                pizza.setId(rs.getInt("pizza_id"));
                pizza.setNome(rs.getString("pizza_nome"));
                pizza.setDescricao(rs.getString("pizza_descricao"));
                pizza.setPreco(rs.getDouble("pizza_preco"));
                pizzaList.add(pizza);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conexao.fecharConexao(null, null, rs);
        }

        request.setAttribute("pizzaList", pizzaList);
        request.getRequestDispatcher("pizzas.jsp").forward(request, response);
    }
}
