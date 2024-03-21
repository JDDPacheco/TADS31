import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/CalculoAreaCircunferencia"})
public class CalculoAreaCircunferencia extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int intRaio = Integer.parseInt(request.getParameter("raio"));
        double dblArea;
        
        dblArea = 3.14159 * (intRaio * intRaio);
        
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