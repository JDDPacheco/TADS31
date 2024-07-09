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
}
