import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/index"})
public class index extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter saida;
        HttpSession sessao = request.getSession();
        
        response.setContentType("text/html;charset=UTF-8");
        saida = response.getWriter();
        saida.println("<html>");
        saida.println("<head>");
        saida.println("<title> Calculo de areas de figuras geometricas </title>");
        saida.println("<link rel=\"stylesheet\" href=\"style.css\">");
        saida.println("</head>");
        saida.println("<body>");
        
        if(sessao.isNew()){
            sessao.setMaxInactiveInterval(10*60);
            saida.println("<h1 style=\"text-align: center;\"> Uma nova sessao foi criada! </h1>");
        }else{
            saida.println("<h1 style=\"text-align: center;\"> Ola... Voce voltou a pagina! </h1>");
        }
        
        saida.println("<a href=\""+response.encodeURL("login.jsp")+"\">Entrar</a>");
        saida.println("</body>");
        saida.println("</hrml>");
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
    }// </editor-fold>

}
