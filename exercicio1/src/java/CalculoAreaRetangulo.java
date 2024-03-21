import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/CalculoAreaRetangulo"})
public class CalculoAreaRetangulo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int intBase = Integer.parseInt(request.getParameter("base"));
        int intAltura = Integer.parseInt(request.getParameter("altura"));
        
        int intArea = intBase * intAltura;
        
        // Define os resultados do cálculo como atributos do request
        request.setAttribute("base", intBase);
        request.setAttribute("altura", intAltura);
        request.setAttribute("area", intArea);
        
        // Encaminha o controle para a página .jsp desejada
        request.getRequestDispatcher("resultado_retangulo.jsp").forward(request, response);
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
