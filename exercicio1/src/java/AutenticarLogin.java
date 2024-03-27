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
        
        // Recebido por requisição
        String usuarioRecebido = (request.getParameter("usuario"));
        String senhaRecebida = (request.getParameter("senha"));
        
        /** Lógica do Login */
        // Variável para verificar se o usuário foi encontrado
        boolean usuarioEncontrado = false;
        // Verificando se o usuário e a senha correspondem a algum usuário cadastrado
        for (Usuario usuario : usuarios) {
            if (usuario.getUsuario().equals(usuarioRecebido) && usuario.getSenha().equals(senhaRecebida)) {
                // Usuário encontrado
                usuarioEncontrado = true;
                break; // Interrompe o loop assim que o usuário for encontrado
            }
        }
        // Verificando se o usuário foi encontrado ou não
        if (usuarioEncontrado) {
            // Usuário autenticado com sucesso
            // Redireciona para o index
            // Último usuário logado
            String ultimoUsuario = usuarioRecebido;
            request.setAttribute("ultimoUsuario", ultimoUsuario);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            // Usuário não autenticado, exibir mensagem de erro
            request.setAttribute("mensagemErro", "Usuário ou senha incorretos. Por favor, tente novamente.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
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
