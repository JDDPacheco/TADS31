public class Usuario {
    // Variáveis de instância
    private String usuario;
    private String senha;

    // Construtor
    public Usuario(String usuario, String senha) {
        this.usuario = usuario;
        this.senha = senha;
    }

    // Métodos getter e setter para o nome de usuário
    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    // Métodos getter e setter para a senha
    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
}

