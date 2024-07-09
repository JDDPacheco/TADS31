package banco_dados;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager;

public class Conexao {

    private String url = "jdbc:mysql://localhost:3306/seu_banco_de_dados";
    private String user = "root";
    private String password = "root";

    // Método para abrir a conexão
    public Connection abrirConexao() {
        try {
            return DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Erro ao abrir a conexão.");
            return null;
        }
    }

    // Método para fechar a conexão e liberar recursos
    public void fecharConexao(Connection con, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
            if (con != null && !con.isClosed()) {
                con.close();
            }
            System.out.println("Conexão fechada com sucesso!");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Erro ao fechar a conexão.");
        }
    }

    

    public boolean alterarPizza(int idPizza, String descricao, String nome, double preco) {
        String strComandoSQL = "UPDATE pizza SET pizza_descricao = "+ descricao +", pizza_nome = "+ nome +",pizza_preco = "+ preco +" WHERE id_pizza = "+ idPizza;

        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = abrirConexao();
            if (con == null) return false;
            ps = con.prepareStatement(strComandoSQL);
            ps.setString(1, descricao);
            ps.setInt(2, idPizza);
            ps.executeUpdate();
            return true;
        } catch (Exception erro) {
            erro.printStackTrace();
            return false;
        } finally {
            fecharConexao(con, ps, null);
        }
    }

    public boolean excluirPizza(int id) {
        String strComandoSQL = "DELETE FROM pizza WHERE id_pizza = ?";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = abrirConexao();
            if (con == null) return false;
            ps = con.prepareStatement(strComandoSQL);
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;
        } catch (Exception erro) {
            erro.printStackTrace();
            return false;
        } finally {
            fecharConexao(con, ps, null);
        }
    }

    
    
}
