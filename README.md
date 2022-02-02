<h1 align="center">Control Expenses</h1>
<h4 align="center">APP em Flutter de Controle de Despesas</h4>

<h6 align="center">Em Desenvolvimento</h6>

<!-- TODO: Video/GIF do APP Executando -->

---

## Sobre o Projeto

O objetivo desse APP é permitir que o Usuario posssa **Organizar** e **Visualizar** os seus **gastos**.

Ao acessar o APP, é possivel navegar entre diferentes **intervalos de Tempo**, mostrando os gastos desse periodo. Nesse intervalo de Tempo, é **somado** todos os gastos e **exibido**, em **percetual**, quanto foi **gasto naquele dia em comparação com o perido**.

### Pontos Desenvolvidos

- [X] Fragmentação dos Widgets em arquivos, para maior Manutenibilidade da Arvore de Componentes
- [X] Criação de Widgets Adapatativos e Responsivos. Eles se adaptam à diferentes tamanhos de dispositivos e sendo compativel com o Design conforme o Sistema Operacional (Android e IOS)
- [X] Divisão de Responsabilidade entre os Widgets
- [X] Utilização do modelo de Programação Declarativo; usando de recursos da propria Linguagem para execução de Processos
- [X] Utilização de Widgets Stateful, com atualização de Estado em tempo de execução
- [X] Criação e Utilização de um Tema (Theme) customizado para o APP
- [X] Interação Direta e Indireta entre Widgets
- [X] Criação de Graficos Dinamicos
- [X] Utilização de EditText, recuperando e utilizando o valor
- [X] Exibição e Encerramento de Modal


## Como Executar ?

### Pré-Requisitos
Para a **execução** desse projeto, é **necessario** os seguintes itens:
- [Git - Versionamento de Codigo](https://git-scm.com/downloads)
- [VsCode - Editor de Codigo (Utilizado no Desenvolvimento)](https://code.visualstudio.com/download)
- [Android Studio - IDE de Desenvolvimento da JetBrains](https://developer.android.com/studio?hl=pt-br)
- [Flutter - Framework Utilizado no Desenvolvimento](https://docs.flutter.dev/get-started/install)

> Caso tenha alguma duvida em relação à **intalação do Flutter**, [clique aqui](https://docs.flutter.dev/get-started/install) e leia o passo a passo da documentação

### Instalando o Projeto

Abra o Terminal do **Git** (Git Bash), copie e cole as linhas abaixo:

```
# 0 - Confirme sua Instalação do GIT (Recomendado)
git --version

# 0 - Confirme sua Instalação do Flutter (Opcional)
flutter doctor

# 1 - Clone/Baixe o Repositorio
git clone https://github.com/GuilhermePalma/Control_Expenses.git

# 2 - Acesse o Diretorio
cd Control_Expenses

# 3 - Inicie o VsCode (Opcional, tambem pode utilizar o Android Studio)
code .

# 4 - Execute o APP no seu Celular ou Emuador
flutter run
```

## Tecnologias Utilizadas

Esse Projeto foi construido em **[Flutter](https://flutter.dev)**, um Framework baseado em **[Dart](https://dart.dev)**. Por conta do Flutter ser uma Linguagem multi-plataforma, é possivel executar esse Projeto tanto em Aparelhos Android, como tambem em iPhone.

[Clique Aqui (Documentação do Flutter)](https://flutter.dev) para conhecer mais sobre o **Flutter**