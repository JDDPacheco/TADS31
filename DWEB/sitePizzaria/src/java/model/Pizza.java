package model;

public class Pizza {
    private int id;
    private String nome;
    private String descricao;
    private double preco;

    // Getters and Setters
    private int getId() {
        return id;
    }

    private void setId(int id) {
        this.id = id;
    }

    private String getNome() {
        return nome;
    }

    private void setNome(String nome) {
        this.nome = nome;
    }

    private String getDescricao() {
        return descricao;
    }

    private void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    private double getPreco() {
        return preco;
    }

    private void setPreco(double preco) 
    {
        this.preco = preco;
    }
    
    // Constructor
    private Pizza(int id, String nome, String descricao, double preco) {
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.preco = preco;
    }
    
    public Pizza(){}
    
    private int ultimaPizza(){
        int ultimo = 0;
        
        /* Desenvolver código para buscar o último id de Pizza usado no Banco de Dados*/
        
        return ultimo;
    }
    
    // Criar novo registro de Pizza
    public void setPizza(String nome, String descricao, double preco){
        
        //Criando novo registro de Pizza
        int id = ultimaPizza() + 1; // usa o próximo id disponível
        
        /* Desenvolver código para gravar id, nome, descricao e preco no Banco de Dados*/
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
