import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/CalculoAreaTrapezio"})
public class CalculoAreaTrapezio extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int intBaseMaior, intBaseMenor, intAltura;
        double dblArea;
        
        intBaseMenor=Integer.parseInt(request.getParameter("base_menor"));
        intBaseMaior=Integer.parseInt(request.getParameter("base_maior"));
        intAltura=Integer.parseInt(request.getParameter("altura"));
        dblArea=((intBaseMenor + intBaseMaior) * intAltura)/2;
        
        // Defina os valores necessários nos atributos do request
        request.setAttribute("base_menor", intBaseMenor);
        request.setAttribute("base_maior", intBaseMaior);
        request.setAttribute("altura", intAltura);
        request.setAttribute("area", dblArea);
        
        // Encaminhe o controle para a página .jsp desejada
        request.getRequestDispatcher("resultado_trapezio.jsp").forward(request, response);
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
