#include <iostream>
#include <stdio.h>
#include <locale.h>
#include <stdlib.h>
#include <tchar.h>
#include <windows.h>
#include <unistd.h>
#include <string.h>
#include <time.h>

#define TAM_DESCRICAOCURTA 20
#define TAM_DESCRICAOLONGA 50

using namespace std;

int dia_atual, mes_atual, ano_atual; //variáveis globais que armazenarão o dia, mês e ano atual.

int TAMCONJ_DISCIPLINA = 0;
int TAMCONJ_TURMA = 0;
int TAMCONJ_ALUNO = 0;

//  Inclusão da função gotoxy

/*  Método gotoxy   */

HANDLE console = GetStdHandle(STD_OUTPUT_HANDLE);
COORD CursorPosition;

void gotoxy(int x, int y){
    CursorPosition.X = x; // Locates column
    CursorPosition.Y = y; // Locates Row
    SetConsoleCursorPosition(console,CursorPosition); // Sets position for next thing to be printed
}

/*  Definição das Estruturas    */

/** Estruturas da Complementares    */

/*  Estrutura de Data   */
typedef struct{
    int dia, mes, ano;
} Data;

/** Estrutura da Disciplina  */
typedef struct {
   char	  nome[TAM_DESCRICAOLONGA];
   int	  codigo, ch;
}Disciplina;

/** Estrutura da Turma  */
typedef struct{
    int disCodigo, alunoMatricula, ano, faltas;
    float nota1, nota2, nota3, nota4, media;
    char situacao;
}Turma;

/** Estrutura do Aluno */
typedef struct{
    int matricula;
    char nome[TAM_DESCRICAOLONGA];
    Data dataNascimento;
}Aluno;

/*  Prototipação dos métodos    */

/** Métodos Relacionados à exibição do Menu, Sub-menus e Finalização do Programa */
void ChamarMenuPrimario(Disciplina *disciplina, Turma *turma, Aluno *aluno);
void ChamarMenuRelatorio(Disciplina *disciplina, Turma *turma, Aluno *aluno);
void EncerrarAplicacao(Disciplina *disciplina, Turma *turma, Aluno *aluno);
void ErroOpcaoInvalida();

/** Métodos Relacionados à Arquivos */
void CarregarVetor(Disciplina *disciplina);
void GravarDados(Disciplina *disciplina);


/** Métodos Relacionados aos Cadastros  */

/** Métodos do CRUD de Disciplina    */
void ChamarMenuCRUD(Disciplina *disciplina);
void CriarNovo(Disciplina *disciplina);
void ReceberDados(Disciplina *disciplina, int i, int x, int y);
void Editar(Disciplina *disciplina);
void Excluir(Disciplina *disciplina);
int ProcurarDados(Disciplina *disciplina, int numProcurado, int x, int y);
void ImprimirDados(Disciplina *disciplina, int i, int x, int y);

/** Métodos do CRUD de Turma   */
void ChamarMenuCRUD(Disciplina *disciplina, Turma *turma, Aluno *aluno);
void CriarNovo(Disciplina *disciplina, Turma *turma, Aluno *aluno);
void ReceberDados(Disciplina *disciplina, Turma *turma, Aluno *aluno, int i, int x, int y);
void Editar(Disciplina *disciplina, Turma *turma, Aluno *aluno);
void Excluir(Disciplina *disciplina, Turma *turma, Aluno *aluno);
int ProcurarDados(Disciplina *disciplina, Turma *turma, Aluno *aluno, int numTurmaProcurado, int x, int y);
void ImprimirDados(Disciplina *disciplina, Turma *turma, Aluno *aluno, int i, int x, int y);

/** Métodos do CRUD de Aluno  */
void ChamarMenuCRUD(Aluno *aluno);
void CriarNovo(Aluno *aluno);
void ReceberDados(Aluno *aluno, int i, int x, int y);
void Editar(Aluno *aluno);
void Excluir(Aluno *aluno);
int ProcurarDados(Aluno *aluno, int numAlunoProcurado, int x, int y);
void ImprimirDados(Aluno *aluno, int i, int x, int y);

/** Métodos Relacionados aos Relatórios */
void ExibirListagem(Disciplina *disciplina);


/** Métodos Adicionais*/

/*  Prototipação das funções do programa    */

Data LerData(int x, int y);
int GerarSequencialAleatorio();
char* LerString();
Data AtualizarDataAtual();

/*  Inicialização do Programa   */

int main(){

    setlocale(LC_ALL, "Portuguese");

    Disciplina disciplina[30];
    Turma turma[30];
    Aluno aluno[200];

    CarregarVetor(disciplina);

    //CarregarVetorCliente(cadastro);

    //CarregarVetorProfissional(matricula);

    //CarregarVetorProfissao(profissao);

    system("cls");
    gotoxy(5,1);
    cout << "*********************************  Prova P1 ***********************************";
    gotoxy(5,3);
    cout << "**************** Desenvolvido por:   José Diogo Dutra Pacheco *****************";
    gotoxy(5,5);
    cout << "**************  Seja Bem-Vindo(a)! O programa iniciará em breve  **************";
    sleep(2);

    ChamarMenuPrimario(disciplina, turma, aluno);

    return 0;
}


//  Implementação dos métodos

/****************************************************************************************************************************/
/**                                    MÉTODOS PARA SALVAR E CARREGAR DADOS EM ARQUIVO                                     **/
/****************************************************************************************************************************/

/** Disciplina */
void GravarDados(Disciplina *disciplina){

    int i;

    FILE *arqDisciplina = fopen("arqDisciplina.txt", "w");

    if (arqDisciplina == NULL) {
        printf("Erro ao criar o arquivo de Disciplina.\n Aguarde nova tentativa . . .");
    }else{
        for(i = 0; i < TAMCONJ_DISCIPLINA; i++){
            if(i == 0){
                fprintf(arqDisciplina, "%d;%s;%d", disciplina[i].codigo, disciplina[i].nome, disciplina[i].ch);
            }else{
                fprintf(arqDisciplina, "\n%d;%s;%d", disciplina[i].codigo, disciplina[i].nome, disciplina[i].ch);
            }
        }
    }

    fclose(arqDisciplina);
}

void CarregarVetor(Disciplina *disciplina){

    int i = 0, cont = 0;

    FILE *arqDisciplina = fopen("arqDisciplina.txt", "r");

    do{
        if (arqDisciplina == NULL) {
            printf("Erro ao abrir o arquivo de Disciplinas.\n Será realizada nova tentativa . . .");
            sleep(2);
            FILE *arqDisciplina = fopen("arqDisciplina.txt", "a");
            fclose(arqDisciplina);
            cont++;
        }else{
            while(fscanf(arqDisciplina, "%d;%50[^;];%d*c", &disciplina[i].codigo, disciplina[i].nome, &disciplina[i].ch) == 3){
                i++;
                TAMCONJ_DISCIPLINA++;
            }
            cont--;
        }
    }while(cont == 1);

    fclose(arqDisciplina);

}

/****************************************************************************************************************************/
/**                                            MÉTODOS DE NAVEGAÇÃO DO PROGRAMA                                            **/
/****************************************************************************************************************************/

void ChamarMenuPrimario(Disciplina *disciplina, Turma *turma, Aluno *aluno){

    int opcao = 0;

        system("cls");
        gotoxy(5,1);
        cout << "*********************  Programa: Atendimento Hospitalar ***********************";
        gotoxy(5,3);
        cout << "Escolha o ambiente que deseja acessar:";
        gotoxy(5,5);
        cout << "[1] Aluno";
        gotoxy(5,6);
        cout << "[2] Disciplina";
        gotoxy(5,7);
        cout << "[3] Turma";
        gotoxy(5,8);
        cout << "[4] Relatório";
        gotoxy(5,9);
        cout << "[0] Sair";
        gotoxy(5,11);
        cout << "Entre a opcão desejada: ";
        cin >> opcao;

        switch(opcao){

            case 1:
                ChamarMenuCRUD(aluno);
                ChamarMenuPrimario(disciplina, turma, aluno);
                break;

            case 2:
                ChamarMenuCRUD(disciplina);
                ChamarMenuPrimario(disciplina, turma, aluno);
                break;

            case 3:
                ChamarMenuCRUD(disciplina, turma, aluno);
                ChamarMenuPrimario(disciplina, turma, aluno);
                break;

            case 4:
                ChamarMenuRelatorio(disciplina, turma, aluno);
                ChamarMenuPrimario(disciplina, turma, aluno);
                break;

            case 0:
                EncerrarAplicacao(disciplina, turma, aluno);

            default:
                ErroOpcaoInvalida();
                ChamarMenuPrimario(disciplina, turma, aluno);
        }
}

void ChamarMenuRelatorio(Disciplina *disciplina, Turma *turma, Aluno *aluno){

    int opcao = 0;

        system("cls");
        gotoxy(5,1);
        cout << "*********************  Programa: Atendimento Hospitalar ***********************";
        gotoxy(5,3);
        cout << "Escolha Relatório que deseja acessar:";
        gotoxy(5,5);
        cout << "[1] Listagem das Disciplinas.";
        gotoxy(5,7);
        cout << "[0] Voltar ao Menu anterior.";
        gotoxy(5,9);
        cout << "Entre a opcão desejada: ";
        cin >> opcao;

        switch(opcao){

            case 1:
                ExibirListagem(disciplina);
                ChamarMenuRelatorio(disciplina, turma, aluno);
                break;

            case 0:
                ChamarMenuPrimario(disciplina, turma, aluno);
                break;

            default:
                ErroOpcaoInvalida();
                ChamarMenuRelatorio(disciplina, turma, aluno);
        }
}

void EncerrarAplicacao(Disciplina *disciplina, Turma *turma, Aluno *aluno){
    system("cls");
    gotoxy(5,1);
    cout << "*********************************  Prova P1 ***********************************";
    gotoxy(5,3);
    cout << "**************** Desenvolvido por:   José Diogo Dutra Pacheco *****************";
    gotoxy(5,5);
    cout << "******************  Obrigado por utilizar nossos serviços!!  ******************";
    gotoxy(5,10);
    exit(0);
}

void ErroOpcaoInvalida(){
    system("cls");
    gotoxy(5,1);
    cout << "*********************************  Prova P1 ***********************************";
    gotoxy(14,10);
    cout << "*********************  Opção Inválida! ***********************";
    sleep(2);
}

/****************************************************************************************************************************/
/**                                             MÉTODOS DO AMBIENTE DE CADASTRO                                            **/
/****************************************************************************************************************************/

/*************************************************************************************/
/**                            MÉTODOS DE DISCIPLINA                                **/
/*************************************************************************************/

void ChamarMenuCRUD(Disciplina *disciplina){

    int opcao = 0;

    system("cls");
    gotoxy(5,1);
    cout << "*********************************  Prova P1 ***********************************";
    gotoxy(5,3);
    cout << "Escolha a opção que deseja:";
    gotoxy(5,5);
    cout << "[1] Cadastrar.";
    gotoxy(5,6);
    cout << "[2] Editar";
    gotoxy(5,7);
    cout << "[3] Excluir";
    gotoxy(5,8);
    cout << "[0] Retornar";
    gotoxy(5,10);
    cout << "Entre a opcão desejada: ";
    cin >> opcao;

    switch(opcao){

            case 1:
                CriarNovo(disciplina);
                ChamarMenuCRUD(disciplina);
            break;

            case 2:
                Editar(disciplina);
                ChamarMenuCRUD(disciplina);
            break;

            case 3:
                Excluir(disciplina);
                ChamarMenuCRUD(disciplina);
            break;

            case 0:
            break;

            default:
                ErroOpcaoInvalida();
                ChamarMenuCRUD(disciplina);
            break;
        }
}
/** C - Create *//* Método para adicionar uma nova Profissão no sistema */
void CriarNovo(Disciplina *disciplina){

    int i, j;

    i = TAMCONJ_DISCIPLINA;
    TAMCONJ_DISCIPLINA++;
    system("cls");
    gotoxy(5,1);
    cout << "*********************************  Prova P1 ***********************************";
    gotoxy(5,3);
    cout << "*************************** Cadastrar Disciplina ******************************";

    j = GerarSequencialAleatorio();

    for(int k = 0; k < TAMCONJ_DISCIPLINA; k++){ //  Testa se o número gerado já existe entre os códigos já existentes no sistema
        if(disciplina[k].codigo == j){
            CriarNovo(disciplina);
        }
    }

    disciplina[i].codigo = j; // Atribui ao código o número gerado aleatoriamente

    ReceberDados(disciplina, i, 5, 6);   // Chama o método que recebe do usuário os dados, os últimos dois números são o parametro para gotoxy, ou seja para o método saber em que lugar da tela ele vai ter que escrever.

}

void ReceberDados(Disciplina *disciplina, int i, int x, int y){

    gotoxy(x,y); //vai para o lugar que foi informado na chamada do método.
    cout << "Código Disciplina: " << disciplina[i].codigo;
    gotoxy(x,y+1); //y+1 é porque pula pra proxima linha
    cout << "Nome Disciplina: ";
    gotoxy(x,y+2);
    cout << "CH: ";
    gotoxy(x+17,y+1);
    strcpy(disciplina[i].nome, LerString()); // Nesta linha copiamos uma string que é lida através de uma função criada neste programa

    gotoxy(x+4,y+2);
    cin >> disciplina[i].ch;
    gotoxy(x,y+4);  // Pular duas linhas
    GravarDados(disciplina);
    cout << "Dados registrados com sucesso!";
    gotoxy(x,y+6);
    system("pause");
}

int ProcurarDados(Disciplina *disciplina, int numProcurado, int x, int y){

    char j = 'n';

    for (int i = 0; i < TAMCONJ_DISCIPLINA ; i++){
        if(disciplina[i].codigo == numProcurado){
            ImprimirDados(disciplina,i,x,y);
            j = 's';
            return i;
        }
    }

    if(j == 'n'){
        cout << "\n\n\t\t\t\tRegistro não encontrado! Tente novamente.\n\n";
        sleep(2);
        return 0;
    }
}

void ImprimirDados(Disciplina *disciplina, int i, int x, int y){

    gotoxy(x,y);
    cout << "Confira os dados.";
    gotoxy(x,y+2);
    printf("Código: %d", disciplina[i].codigo);
    gotoxy(x,y+3);
    printf("Nome: %s", disciplina[i].nome);
    gotoxy(x,y+4);
    printf("CH: %d", disciplina[i].ch);
}

/** U - Update */
void Editar(Disciplina *disciplina){

    int i, numProcurado, opcao;

    system("cls");

    gotoxy(5,1);
    cout << "*********************************  Prova P1 ***********************************";
    gotoxy(5,3);
    cout << "***************************** Editar Disciplina *******************************";
    gotoxy(5,5);
    cout << "Digite o número do registro que você deseja editar: ";
    cin >> numProcurado;

    i = ProcurarDados(disciplina, numProcurado,5,7);

    gotoxy(5,15);
    cout << "Tem certeza que deseja continuar com a edição?";
    gotoxy(5,16);
    cout << "[1] Para editar este registro.";
    gotoxy(5,17);
    cout << "[2] Para editar outro registro.";
    gotoxy(5,18);
    cout << "[0] Para voltar ao menu anterior.";
    gotoxy(5,20);
    cout << "Digite sua opção: ";
    cin >> opcao;

    switch(opcao){
    case 1:
        gotoxy(5,14);
        cout << "Insira os novos dados para o registro.";
        gotoxy(5,15);
        cout << "                                                           ";
        gotoxy(5,16);
        cout << "                                                           ";
        gotoxy(5,17);
        cout << "                                                           ";
        gotoxy(5,18);
        cout << "                                                           ";
        gotoxy(5,20);
        cout << "                                                           "; //Essa parte substitui o menu de opções por digitos vazios dando a impressão que esta parte da tela foi limpa

        ReceberDados(disciplina,i,5,16);    // Aqui também chamamos aquele método que recebe do usuário e registra os dados da profissão

        break;

    case 2:
        Editar(disciplina);
        break;

    case 0:
        break;

    default:
        ErroOpcaoInvalida();
        Editar(disciplina);
        break;
    }
}

/** D - Delete *//*  Método para excluir uma Profissão  */
void Excluir(Disciplina *disciplina){

    int i, j, numProcurado, opcao;

    system("cls");

    gotoxy(5,1);
    cout << "*********************************  Prova P1 ************************************";
    gotoxy(5,3);
    cout << "***************************** Excluir Disciplina *******************************";
    gotoxy(5,6);
    cout << "Digite o número do registro que você deseja excluir: ";
    cin >> numProcurado;

    j = ProcurarDados(disciplina, numProcurado,5,8);

    gotoxy(5,14);
    cout << "Digite 1 para confirmar a exclusão ou 0(zero) para voltar ao menu anterior: ";
    cin >> opcao;

    switch(opcao){
    case 1:
        for(i = j; i < TAMCONJ_DISCIPLINA; i++){
            disciplina[i].codigo = disciplina[i+1].codigo;
            strcpy(disciplina[i].nome, disciplina[i+1].nome);
            disciplina[i].ch = disciplina[i+1].ch;
        }
        TAMCONJ_DISCIPLINA--;
        gotoxy(5,17);
        GravarDados(disciplina);
        cout << "Registro excluído com sucesso!";
        gotoxy(5,19);
        system("pause");
        break;

    case 0:
        break;

    default:
        ErroOpcaoInvalida();
        Excluir(disciplina);
        break;
    }
}


/*************************************************************************************/
/**                            MÉTODOS DE ALUNO                                     **/
/*************************************************************************************/

void ChamarMenuCRUD(Aluno *aluno){

    int opcao = 0;

    system("cls");
    gotoxy(5,1);
    cout << "*********************************  Prova P1 ***********************************";
    gotoxy(5,3);
    cout << "Escolha a opção que deseja:";
    gotoxy(5,5);
    cout << "[1] Cadastrar.";
    gotoxy(5,6);
    cout << "[2] Editar";
    gotoxy(5,7);
    cout << "[3] Excluir";
    gotoxy(5,8);
    cout << "[0] Retornar";
    gotoxy(5,10);
    cout << "Entre a opcão desejada: ";
    cin >> opcao;

    switch(opcao){

            case 1:
                CriarNovo(aluno);
                ChamarMenuCRUD(aluno);
            break;

            case 2:
                Editar(aluno);
                ChamarMenuCRUD(aluno);
            break;

            case 3:
                Excluir(aluno);
                ChamarMenuCRUD(aluno);
            break;

            case 0:
            break;

            default:
                ErroOpcaoInvalida();
                ChamarMenuCRUD(aluno);
            break;
        }
}
/** C - Create */
void CriarNovo(Aluno *aluno){

    int i, j;

    i = TAMCONJ_ALUNO;
    TAMCONJ_ALUNO++;
    system("cls");
    gotoxy(5,1);
    cout << "*********************************  Prova P1 ***********************************";
    gotoxy(5,3);
    cout << "****************************** Cadastrar Aluno ********************************";

    j = GerarSequencialAleatorio();

    for(int k = 0; k < TAMCONJ_ALUNO; k++){ //  Testa se o número gerado já existe entre os códigos já existentes no sistema
        if(aluno[k].matricula == j){
            CriarNovo(aluno);
        }
    }

    aluno[i].matricula = j; // Atribui ao código o número gerado aleatoriamente

    ReceberDados(aluno, i, 5, 6);   // Chama o método que recebe do usuário os dados, os últimos dois números são o parametro para gotoxy, ou seja para o método saber em que lugar da tela ele vai ter que escrever.

}

void ReceberDados(Aluno *aluno, int i, int x, int y){

    gotoxy(x,y); //vai para o lugar que foi informado na chamada do método.
    cout << "Matrícula: " << aluno[i].matricula;
    gotoxy(x,y+1); //y+1 é porque pula pra proxima linha
    cout << "Nome: ";
    gotoxy(x,y+2);
    cout << "Data de Nascimento:   /  /";
    gotoxy(x+6,y+1);
    strcpy(aluno[i].nome, LerString()); // Nesta linha copiamos uma string que é lida através de uma função criada neste programa
    aluno[i].dataNascimento = LerData(x+20, y+2);
    gotoxy(x,y+4);
    //GravarDados(aluno);
    cout << "Dados registrados com sucesso!";
    gotoxy(x,y+6);
    system("pause");
}

int ProcurarDados(Aluno *aluno, int numProcurado, int x, int y){

    char j = 'n';

    for (int i = 0; i < TAMCONJ_ALUNO ; i++){
        if(aluno[i].matricula == numProcurado){
            ImprimirDados(aluno,i,x,y);
            j = 's';
            return i;
        }
    }

    if(j == 'n'){
        cout << "\n\n\t\t\t\tRegistro não encontrado! Tente novamente.\n\n";
        sleep(2);
        return 0;
    }
}

void ImprimirDados(Aluno *aluno, int i, int x, int y){

    gotoxy(x,y);
    cout << "Confira os dados.";
    gotoxy(x,y+2);
    printf("Matrícula: %d", aluno[i].matricula);
    gotoxy(x,y+3);
    printf("Nome: %s", aluno[i].nome);
    gotoxy(x,y+4);
    printf("Data de Nascimento: %02d/%02d/%04d", aluno[i].dataNascimento.dia, aluno[i].dataNascimento.mes, aluno[i].dataNascimento.ano);
}

/** U - Update */
void Editar(Aluno *aluno){

    int i, numProcurado, opcao;

    system("cls");

    gotoxy(5,1);
    cout << "*********************************  Prova P1 ***********************************";
    gotoxy(5,3);
    cout << "******************************* Editar Aluno **********************************";
    gotoxy(5,5);
    cout << "Digite o número do registro que você deseja editar: ";
    cin >> numProcurado;

    i = ProcurarDados(aluno, numProcurado,5,7);

    gotoxy(5,15);
    cout << "Tem certeza que deseja continuar com a edição?";
    gotoxy(5,16);
    cout << "[1] Para editar este registro.";
    gotoxy(5,17);
    cout << "[2] Para editar outro registro.";
    gotoxy(5,18);
    cout << "[0] Para voltar ao menu anterior.";
    gotoxy(5,20);
    cout << "Digite sua opção: ";
    cin >> opcao;

    switch(opcao){
    case 1:
        gotoxy(5,14);
        cout << "Insira os novos dados para o registro.";
        gotoxy(5,15);
        cout << "                                                           ";
        gotoxy(5,16);
        cout << "                                                           ";
        gotoxy(5,17);
        cout << "                                                           ";
        gotoxy(5,18);
        cout << "                                                           ";
        gotoxy(5,20);
        cout << "                                                           "; //Essa parte substitui o menu de opções por digitos vazios dando a impressão que esta parte da tela foi limpa

        ReceberDados(aluno,i,5,16);    // Aqui também chamamos aquele método que recebe do usuário e registra os dados da profissão

        break;

    case 2:
        Editar(aluno);
        break;

    case 0:
        break;

    default:
        ErroOpcaoInvalida();
        Editar(aluno);
        break;
    }
}

/** D - Delete */
void Excluir(Aluno *aluno){

    int i, j, numProcurado, opcao;

    system("cls");

    gotoxy(5,1);
    cout << "*********************************  Prova P1 ************************************";
    gotoxy(5,3);
    cout << "******************************* Excluir Aluno **********************************";
    gotoxy(5,6);
    cout << "Digite o número do registro que você deseja excluir: ";
    cin >> numProcurado;

    j = ProcurarDados(aluno, numProcurado,5,8);

    gotoxy(5,14);
    cout << "Digite 1 para confirmar a exclusão ou 0(zero) para voltar ao menu anterior: ";
    cin >> opcao;

    switch(opcao){
    case 1:
        for(i = j; i < TAMCONJ_ALUNO; i++){
            aluno[i].matricula = aluno[i+1].matricula;
            strcpy(aluno[i].nome, aluno[i+1].nome);
            aluno[i].dataNascimento.dia = aluno[i+1].dataNascimento.dia;
            aluno[i].dataNascimento.mes = aluno[i+1].dataNascimento.mes;
            aluno[i].dataNascimento.ano = aluno[i+1].dataNascimento.ano;
        }
        TAMCONJ_ALUNO--;
        gotoxy(5,17);
        //GravarDados(aluno);
        cout << "Registro excluído com sucesso!";
        gotoxy(5,19);
        system("pause");
        break;

    case 0:
        break;

    default:
        ErroOpcaoInvalida();
        Excluir(aluno);
        break;
    }
}


/*************************************************************************************/
/**                            MÉTODOS DE TURMA                                     **/
/*************************************************************************************/

void ChamarMenuCRUD(Disciplina *disciplina, Turma *turma, Aluno *aluno){

    int opcao = 0;

    system("cls");
    gotoxy(5,1);
    cout << "*********************************  Prova P1 ***********************************";
    gotoxy(5,3);
    cout << "Escolha a opção que deseja:";
    gotoxy(5,5);
    cout << "[1] Cadastrar.";
    gotoxy(5,6);
    cout << "[2] Editar";
    gotoxy(5,7);
    cout << "[3] Excluir";
    gotoxy(5,8);
    cout << "[0] Retornar";
    gotoxy(5,10);
    cout << "Entre a opcão desejada: ";
    cin >> opcao;

    switch(opcao){

            case 1:
                CriarNovo(disciplina, turma, aluno);
                ChamarMenuCRUD(disciplina, turma, aluno);
            break;

            case 2:
                Editar(disciplina, turma, aluno);
                ChamarMenuCRUD(disciplina, turma, aluno);
            break;

            case 3:
                Excluir(disciplina, turma, aluno);
                ChamarMenuCRUD(disciplina, turma, aluno);
            break;

            case 0:
            break;

            default:
                ErroOpcaoInvalida();
                ChamarMenuCRUD(disciplina, turma, aluno);
            break;
        }
}
/** C - Create */
void CriarNovo(Disciplina *disciplina, Turma *turma, Aluno *aluno){

    int i, j;

    i = TAMCONJ_TURMA;
    TAMCONJ_TURMA++;
    system("cls");
    gotoxy(5,1);
    cout << "*********************************  Prova P1 ***********************************";
    gotoxy(5,3);
    cout << "****************************** Cadastrar Turma ********************************";

    ReceberDados(disciplina, turma, aluno, i, 5, 6);   // Chama o método que recebe do usuário os dados, os últimos dois números são o parametro para gotoxy, ou seja para o método saber em que lugar da tela ele vai ter que escrever.

}

void ReceberDados(Disciplina *disciplina, Turma *turma, Aluno *aluno, int i, int x, int y){

    gotoxy(x,y); //vai para o lugar que foi informado na chamada do método.
    cout << "Código da Disciplina: ";
    gotoxy(x,y+1);
    cout << "Matrícula do Aluno: ";
    gotoxy(x,y+2);
    cout << "Ano: ";
    gotoxy(x,y+3);
    cout << "Nota 1: ";
    gotoxy(x,y+4);
    cout << "Nota 2: ";
    gotoxy(x,y+5);
    cout << "Nota 3: ";
    gotoxy(x,y+6);
    cout << "Nota 4: ";
    gotoxy(x,y+7);
    cout << "Faltas: ";
    gotoxy(x+22,y);
    cin >> turma[i].disCodigo;
    gotoxy(x+20,y+1);
    cin >> turma[i].alunoMatricula;
    gotoxy(x+5,y+2);
    cin >> turma[i].ano;
    gotoxy(x+8,y+3);
    cin >> turma[i].nota1;
    gotoxy(x+8,y+4);
    cin >> turma[i].nota2;
    gotoxy(x+8,y+5);
    cin >> turma[i].nota3;
    gotoxy(x+8,y+6);
    cin >> turma[i].nota4;
    gotoxy(x+8,y+7);
    cin >> turma[i].faltas;
    gotoxy(x,y+9);
    turma[i].media = (turma[i].nota1 + turma[i].nota2 + turma[i].nota3 + turma[i].nota4)/4; //   Calcula a média e armazena em media
    if(turma[i].media >= 5){ // Verifica se a media é maior que 5, se sim situação aprovado (A), senão reprovado (R)
        turma[i].situacao ='A';
    }else{
        turma[i].situacao ='R';
    }
    //GravarDados(turma);
    cout << "Dados registrados com sucesso!";
    gotoxy(x,y+11);
    system("pause");
}

int ProcurarDados(Disciplina *disciplina, Turma *turma, Aluno *aluno, int numProcurado, int x, int y){

    char j = 'n';

    for (int i = 0; i < TAMCONJ_TURMA ; i++){
        if((turma[i].disCodigo*100000)+turma[i].alunoMatricula == numProcurado){
            ImprimirDados(disciplina, turma, aluno,i,x,y);
            j = 's';
            return i;
        }
    }

    if(j == 'n'){
        cout << "\n\n\t\t\t\tRegistro não encontrado! Tente novamente.\n\n";
        sleep(2);
        return 0;
    }
}

void ImprimirDados(Disciplina *disciplina, Turma *turma, Aluno *aluno, int i, int x, int y){

    gotoxy(x,y);
    cout << "Confira os dados.";
    gotoxy(x,y+2); //vai para o lugar que foi informado na chamada do método.
    cout << "Código da Disciplina: " << turma[i].disCodigo;
    gotoxy(x,y+3);
    cout << "Matrícula do Aluno: " << turma[i].alunoMatricula;
    gotoxy(x,y+4);
    cout << "Ano: " << turma[i].ano;
    gotoxy(x,y+5);
    printf("Nota 1: %.2f",turma[i].nota1);
    gotoxy(x,y+6);
    printf("Nota 2: %.2f",turma[i].nota2);
    gotoxy(x,y+7);
    printf("Nota 3: %.2f",turma[i].nota3);
    gotoxy(x,y+8);
    printf("Nota 4: %.2f",turma[i].nota4);
    gotoxy(x,y+9);
    cout << "Faltas: " << turma[i].faltas;
    gotoxy(x,y+10);
    printf("Média: %.2f",turma[i].media);
    gotoxy(x,y+11);
    cout << "Situação: ";
    if(turma[i].situacao == 'A'){
        cout << "Aprovado(a)";
    }else{
        cout << "Reprovado(a)";
    }

}

/** U - Update */
void Editar(Disciplina *disciplina, Turma *turma, Aluno *aluno){

    int i, numProcurado, opcao;

    system("cls");

    gotoxy(5,1);
    cout << "*********************************  Prova P1 ***********************************";
    gotoxy(5,3);
    cout << "******************************* Editar Turma **********************************";
    gotoxy(5,5);
    cout << "Digite o número do registro que você deseja editar (CodDisciplina & MatAluno - Exemplo: 4586545125): ";
    cin >> numProcurado;

    i = ProcurarDados(disciplina, turma, aluno, numProcurado,5,7);

    gotoxy(5,20);
    cout << "Tem certeza que deseja continuar com a edição?";
    gotoxy(5,21);
    cout << "[1] Para editar este registro.";
    gotoxy(5,22);
    cout << "[2] Para editar outro registro.";
    gotoxy(5,23);
    cout << "[0] Para voltar ao menu anterior.";
    gotoxy(5,25);
    cout << "Digite sua opção: ";
    cin >> opcao;

    switch(opcao){
    case 1:
        gotoxy(5,20);
        cout << "Insira os novos dados para o registro.";
        gotoxy(5,21);
        cout << "                                                           ";
        gotoxy(5,22);
        cout << "                                                           ";
        gotoxy(5,23);
        cout << "                                                           ";
        gotoxy(5,25);
        cout << "                                                           ";//Essa parte substitui o menu de opções por digitos vazios dando a impressão que esta parte da tela foi limpa

        ReceberDados(disciplina, turma, aluno,i,5,22);    // Aqui também chamamos aquele método que recebe do usuário e registra os dados

        break;

    case 2:
        Editar(disciplina, turma, aluno);
        break;

    case 0:
        break;

    default:
        ErroOpcaoInvalida();
        Editar(disciplina, turma, aluno);
        break;
    }
}

/** D - Delete */
void Excluir(Disciplina *disciplina, Turma *turma, Aluno *aluno){

    int i, j, numProcurado, opcao;

    system("cls");

    gotoxy(5,1);
    cout << "*********************************  Prova P1 ************************************";
    gotoxy(5,3);
    cout << "******************************* Excluir Aluno **********************************";
    gotoxy(5,6);
    cout << "Digite o número do registro que você deseja excluir (CodDisciplina & MatAluno - Exemplo: 4586545125): ";
    cin >> numProcurado;

    j = ProcurarDados(disciplina, turma, aluno, numProcurado,5,8);

    gotoxy(5,20);
    cout << "Digite 1 para confirmar a exclusão ou 0(zero) para voltar ao menu anterior: ";
    cin >> opcao;

    switch(opcao){
    case 1:
        for(i = j; i < TAMCONJ_TURMA; i++){
            turma[i].alunoMatricula = turma[i+1].alunoMatricula;
            turma[i].ano = turma[i+1].ano;
            turma[i].disCodigo = turma[i+1].disCodigo;
            turma[i].faltas = turma[i+1].faltas;
            turma[i].media = turma[i+1].media;
            turma[i].nota1 = turma[i+1].nota1;
            turma[i].nota2 = turma[i+1].nota2;
            turma[i].nota3 = turma[i+1].nota3;
            turma[i].nota4 = turma[i+1].nota4;
            turma[i].situacao = turma[i+1].situacao;
        }
        TAMCONJ_TURMA--;
        gotoxy(5,22);
        //GravarDados(aluno);
        cout << "Registro excluído com sucesso!";
        gotoxy(5,24);
        system("pause");
        break;

    case 0:
        break;

    default:
        ErroOpcaoInvalida();
        Excluir(disciplina, turma, aluno);
        break;
    }
}

/****************************************************************************************************************************/
/**                                            MÉTODOS DO AMBIENTE DE RELATÓRIOS                                           **/
/****************************************************************************************************************************/

void ExibirListagem(Disciplina *disciplina){

    int i, j;

    system("cls");
    gotoxy(5,1);
    cout << "*********************  Programa: Atendimento Hospitalar ***********************";
    gotoxy(5,3);
    cout << "*******************  Relatório: Listagem de Profissionais *********************";

    for (i = 0; i < TAMCONJ_DISCIPLINA; i++){
        gotoxy(5,5+i);
        printf("Disciplina %02d - ",i+1);
        gotoxy(5+16,5+i);
        cout << "Código: " << disciplina[i].codigo;
        gotoxy(5+16+7+8,5+i);
        printf("CH: %02d h",disciplina[i].ch);
        gotoxy(5+16+7+10+8,5+i);
        printf("Nome: %s", disciplina[i].nome);
    }
    gotoxy(5,5+i+1);
    system("pause");
}
/** Funções do Programa */

/*  Função para ler uma data    */
Data LerData(int x, int y){
    Data data;
    int dia, mes, ano;
    Data dataatual;

    dataatual = AtualizarDataAtual();

    gotoxy(x,y);
    cin >> dia;
    gotoxy(x+3,y);
    cin >> mes;
    gotoxy(x+6,y);
    cin >> ano;

    if(dia < 1 || dia > 31){
        gotoxy(x+20,y);
        cout << "Insira uma data válida! (dia deve estar entre 1 e 31)\n";
        LerData(x,y);
    }

    if(mes < 1 || mes > 12){
        gotoxy(x+20,y);
        cout << "\t\tInsira uma data válida! (mês deve estar entre 1 e 12)\n";
        LerData(x,y);
    }

    if(ano < 1900 || ano > dataatual.ano){
        gotoxy(x+20,y);
        printf ("\t\tInsira uma data válida! (ano deve estar entre 1900 e %i)\n",dataatual.ano);
        LerData(x,y);
    }

    data.dia = dia;
    data.mes = mes;
    data.ano = ano;

    return data;
}

/*  Gerar um número sequencial aleatório entre 10000 e 99999*/
int GerarSequencialAleatorio(){

    int min = 10000;  // Valor mínimo desejado
    int max = 99999; // Valor máximo desejado
    int codigo = 0;

    srand(time(NULL));  //Atualiza o tempo do sistema para garantir aleatoriedade
    codigo = min + rand() % (max - min + 1); // Gera o código aleatório entre o máximo e o mínimo desejado

    return codigo;
}

char* LerString(){

    char linhadigitada[TAM_DESCRICAOLONGA];

    fflush(stdin);
    fgets(linhadigitada, sizeof(linhadigitada), stdin);
    size_t len = strlen(linhadigitada);
    if (len > 0 && linhadigitada[len - 1] == '\n') {
        linhadigitada[len - 1] = '\0';
    }

    char* copia = (char*)malloc(len);
    if (copia) {
        strcpy(copia, linhadigitada);
    }

    return copia;
}

Data AtualizarDataAtual(){

    Data data_atual;

    // Obtém a hora atual do sistema
    time_t currentTime;
    struct tm *localTime;
    currentTime = time(NULL);
    localTime = localtime(&currentTime);

    // Extrai o dia, mês e ano
    dia_atual = localTime->tm_mday;
    mes_atual = localTime->tm_mon + 1;  // Os meses em struct tm são de 0 a 11
    ano_atual = localTime->tm_year + 1900; // Ano é contado a partir de 1900

    data_atual.dia = dia_atual;
    data_atual.mes = mes_atual;
    data_atual.ano = ano_atual;

    return data_atual;

}
