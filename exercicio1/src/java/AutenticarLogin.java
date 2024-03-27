import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/AutenticarLogin"})
public class AutenticarLogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Populando o código com instâncias de usuários
        Usuario[] usuarios = new Usuario[5];
        usuarios[0] = new Usuario("diogo", "1234");
        usuarios[1] = new Usuario("harley", "5678");
        usuarios[2] = new Usuario("george", "9012");
        usuarios[3] = new Usuario("cristian", "3456");
        usuarios[4] = new Usuario("tereza", "7890");
        
        
        String usuarioRecebido = (request.getParameter("usuario"));
        String senha = (request.getParameter("senha"));
        
        
        
        // Defina os valores necessários nos atributos do request
        request.setAttribute("raio", intRaio);
        request.setAttribute("area", dblArea);
        
        // Encaminhe o controle para a página .jsp desejada
        request.getRequestDispatcher("resultado_circunferencia.jsp").forward(request, response);
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
