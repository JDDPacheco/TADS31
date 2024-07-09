package model;

import banco_dados.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class Pizza {
    
    private Conexao conexao;

    public Pizza(Conexao conexao) {
        this.conexao = conexao;
    }
    
    // Criar novo registro de Pizza
    public boolean inserirPizza(String nome, String descricao, double preco) {
        String strComandoSQL = "INSERT INTO pizza(descricao_pizza) VALUES('"+ nome +","+ descricao +","+ preco +"')";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = conexao.abrirConexao();
            if (con == null) return false;
            ps = con.prepareStatement(strComandoSQL);
            ps.setString(1, descricao);
            ps.executeUpdate();
            return true;
        } catch (Exception erro) {
            erro.printStackTrace();
            return false;
        } finally {
            conexao.fecharConexao(con, ps, null);
        }
    }
    
    // Buscar um registro de Pizza
    public Pizza getPizza(int id){
        
        /* Desenvolver código para ler do Banco de Dados uma pizza por id como parâmetro*/
        String nome = "Mussarella";     // nome lido do Banco de Dados
        String descricao = "Queijo Mussarella e Orégano";   // descricao lido do Banco de Dados
        double preco = 35.00;   // preco lido do Banco de Dados
        
        return new Pizza(id, nome, descricao, preco);
    }
}
