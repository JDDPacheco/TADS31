<!DOCTYPE html>
<%@ page import="java.util.Date" %>
  <%@ page import="java.text.SimpleDateFormat" %>

    <html lang="pt-br">

    <head>
      <meta http-equiv="Content-Type" content="text/html: charset=UTF-8">
      <title>Exemplo de uso de elemento sintático de JSP</title>
    </head>

    <body>
      <%! int intContAcessos=0; %>
        <% java.util.Data dataAtual=new java.util.Date(); String srtData=new
          SimpleDateFormat("dd/MM/yyyy").format(dataAtual); %>
          <h2> Data atual: <%= srtData %>
          </h2><br>
          <% out.println("<h2> Contagem de atualizações da pagina </h2> <br>");
            intContAcessos++;
            %>
            <h2> Numero de vezes que voce acessou/atualizou esta pagina: <%= intContAcessos %>
            </h2>
    </body>

    </html>