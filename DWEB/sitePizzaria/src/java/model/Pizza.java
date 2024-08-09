package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Pizza {

    private Connection conBanco;
    private PreparedStatement psComando;
    private ResultSet rsRegistros;

    // Métodos de Pizza
    public void configurarConexao(Connection conBanco){
        this.conBanco = conBanco;
    }

    public boolean inserirPizza(String nome, String descricao, double preco){

        String strComandoSQL = "INSERT INTO pizza(pznome, pzdesc, pzpreco) VALUES('"+nome+"','"+descricao+"',"+preco+")";

        try{
            psComando = conBanco.prepareStatement(strComandoSQL);
            psComando.executeUpdate();
            return true;
        }catch(Exception erro){
            erro.printStackTrace();
            return false;
        }
    }

    public boolean alterarPizza(int idPizza, String descricao, String nome, double preco) {
        String strComandoSQL = "UPDATE Pizzas SET pzdesc = '"+descricao+"', pznome = '"+nome+"', pzpreco = '"+preco+"' WHERE pzid = "+idPizza;
        try{
            psComando = conBanco.prepareStatement(strComandoSQL);
            psComando.executeUpdate();
            return true;
        }catch(Exception erro){
            erro.printStackTrace();
            return false;
        }
    }

    public boolean excluirPizza(int id) {
        String strComandoSQL = "DELETE FROM Pizzas WHERE pzid = "+id;
        try{
            psComando = conBanco.prepareStatement(strComandoSQL);
            psComando.executeUpdate();
            return true;
        }catch(Exception erro){
            erro.printStackTrace();
            return false;
        }
    }

    public ResultSet listarPizzas(){
        String strComandoSQL = "SELECT * FROM Pizzas";
        try{
            psComando = conBanco.prepareStatement(strComandoSQL);
            rsRegistros = psComando.executeQuery();
            return rsRegistros;
        }catch(Exception erro){
            erro.printStackTrace();
            return null;
        }
    }
}