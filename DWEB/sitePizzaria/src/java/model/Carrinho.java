package model;

import java.util.ArrayList;

public class Carrinho {
    private int id;
    private String cliente;
    private String telefone;
    private String endereco;
    private ArrayList<Pizza> pizzas = new ArrayList<Pizza>();
    private double precoTotal;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCliente() {
        return cliente;
    }

    public void setCliente(String cliente) {
        this.cliente = cliente;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public ArrayList<Pizza> getPizzas() {
        return pizzas;
    }

    public void setPizzas(ArrayList<Pizza> pizzas) {
        this.pizzas = pizzas;
    }

    public double getPrecoTotal() {
        return precoTotal;
    }

    public void setPrecoTotal(double precoTotal) {
        this.precoTotal = precoTotal;
    }

    
    // Constructor
    public Carrinho(int id, String cliente, String telefone, String endereco, double precoTotal){
        this.id = id;
        this.cliente = cliente;
        this.telefone = telefone;
        this.endereco = endereco;
        this.precoTotal = precoTotal;
    }

    public Carrinho() {
    }
    
    // Methods
    private int ultimoCarrinho(){
        int ultimo = 0;
        
        /* Desenvolver código para buscar o último id de Carrinho usado no Banco de Dados*/
        
        return ultimo;
    }
    
    // Criar novo registro de Carrinho
    public void setCarrinho(String cliente){

        //Criando novo registro de Pizza
        int id = ultimoCarrinho() + 1; // usa o próximo id disponível

        /* Desenvolver código para gravar id, cliente, descricao e preco no Banco de Dados*/
    }
    
    // Adicionar uma pizza no Carrinho
    public void addPizzaInKart(int id, Pizza pizza){
        this.pizzas.add(pizza);
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
