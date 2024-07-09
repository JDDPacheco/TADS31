package model;

import banco_dados.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Pizza {
    
    private Conexao conexao;

    public Pizza(Conexao conexao) {
        this.conexao = conexao;
    }
    
    // Criar novo registro de Pizza
    public boolean inserirPizza(String nome, String descricao, double preco) {
        
        //  Linha de comando SQL
        String strComandoSQL = "INSERT INTO pizza(pizza_nome, pizza_descricao, pizza_preco) VALUES(?, ?, ?)";
        
        // Inicia conexão com BD e envia o comando
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = conexao.abrirConexao();
            if (con == null) return false;
            ps = con.prepareStatement(strComandoSQL);
            ps.setString(1, nome);
            ps.setString(2, descricao);
            ps.setDouble(3, preco);
            ps.executeUpdate();
            return true;
        } catch (Exception erro) {
            erro.printStackTrace();
            return false;
        } finally {
            //  fecha a conexão com o BD
            conexao.fecharConexao(con, ps, null);
        }
    }
    
    // Buscar um registro de Pizza por 'id'
    public ResultSet buscarPizza(int id_pizza) {
        // Linha de comando SQL
        String strComandoSQL = "SELECT * FROM pizza WHERE pizza_id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = conexao.abrirConexao();
            if (con == null) return null;
            ps = con.prepareStatement(strComandoSQL);
            ps.setInt(1, id_pizza);
            rs = ps.executeQuery();
            return rs;
        } catch (Exception erro) {
            erro.printStackTrace();
            return null;
        } finally {
            // A conexão, PreparedStatement e ResultSet devem ser fechados após o uso do ResultSet
        }
    }
    
    // Alterar uma pizza pelo 'id'
    public boolean alterarPizza(int idPizza, String descricao, String nome, double preco) {
    String strComandoSQL = "UPDATE pizza SET pizza_descricao = ?, pizza_nome = ?, pizza_preco = ? WHERE id_pizza = ?";

    Connection con = null;
    PreparedStatement ps = null;
    try {
        con = conexao.abrirConexao();
        if (con == null) return false;
        ps = con.prepareStatement(strComandoSQL);
        ps.setString(1, descricao);
        ps.setString(2, nome);
        ps.setDouble(3, preco);
        ps.setInt(4, idPizza);
        ps.executeUpdate();
        return true;
    } catch (Exception erro) {
        erro.printStackTrace();
        return false;
    } finally {
        conexao.fecharConexao(con, ps, null);
    }
}


}
