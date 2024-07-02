<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title> Calculo de Área </title>
</head>

<body>
  <% int intFiguraGeometrica; String strTituloFormulario, strFormulario; if(request.getParameter("TipoFigura") !=null)
    intFiguraGeometrica=Integer.parseInt(request.getParameter("TipoFigura")); else intFiguraGeometrica=0;
    if(intFiguraGeometrica==1){
      strTituloFormulario="Calculo da area de um Retangulo" ;
      strFormulario="<form name='formCalcularAreaFiguras' method='get' action='area_retangulo.jsp'>" ;
    }else if(intFiguraGeometrica==2){
      strTituloFormulario=" Calculo da area de uma Circunferência" ;
      strFormulario="<form name='formCalcularAreaFiguras' method='get' action='area_circunferencia.jsp'>" ;
    }else if(intFiguraGeometrica==3){
      strTituloFormulario=" Calculo da area de um Triângulo Retangulo" ;
      strFormulario="<form name='formCalcularAreaFiguras' method='get' action='area_triangulo.jsp'>" ;
    }else{
      strTituloFormulario=""" Erro""" ; strFormulario="<form name='formCalcularAreaFiguras'>;
  }
  out.println(strFormulario);
  %>
</body>
</html>