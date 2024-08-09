import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Pizza;
import banco_dados.Conexao;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/MenuServlet"})
public class MenuServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Conexao conexao = new Conexao();
        Pizza pizza = new Pizza();
        ResultSet rs = null;

        if(conexao.abrirConexao()){
            pizza.configurarConexao(conexao.obterConexao());
            rs = pizza.listarPizzas();
            conexao.fecharConexao();
        }else{
            System.out.println("<p>Falha na conexao com o banco de dados</p>");
        }

        // Defina os valores necessários nos atributos do request
        request.setAttribute("listaDePizzas", rs);

        // Encaminhe o controle para a página .jsp desejada
        request.getRequestDispatcher("menu.jsp").forward(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
