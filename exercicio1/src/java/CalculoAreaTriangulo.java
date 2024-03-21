import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/CalculoAreaTriangulo"})
public class CalculoAreaTriangulo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int intBase, intAltura;
        double dblArea;
        
        intBase = Integer.parseInt(request.getParameter("base"));
        intAltura = Integer.parseInt(request.getParameter("altura"));
        dblArea = (intBase * intAltura) / 2;
        
        // Defina os valores necessários nos atributos do request
        request.setAttribute("base", intBase);
        request.setAttribute("altura", intAltura);
        request.setAttribute("area", dblArea);
        
        // Encaminhe o controle para a página .jsp desejada
        request.getRequestDispatcher("resultado_triangulo.jsp").forward(request, response);
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
