# README – Resumo da Aula



## Primeiro dia de aula – Curso de Desenvolvimento de Sistemas (SENAI)



No primeiro dia de aula do curso de Desenvolvimento de Sistemas do SENAI, iniciamos as atividades com a apresentação do professor e dos alunos, promovendo a integração da turma. Em seguida, foram apresentadas as regras da escola, abordando normas de convivência, uso adequado dos laboratórios e as responsabilidades dos alunos durante o curso.



Após esse momento inicial, realizamos a criação de uma conta separada no computador, destinada exclusivamente aos alunos do curso de Desenvolvimento de Sistemas, com o objetivo de manter a organização e a segurança no uso das máquinas. Na sequência, instalamos as principais ferramentas que serão utilizadas ao longo do curso, como o Git e o Visual Studio Code, além de aprendermos a criar e configurar um perfil no GitHub, entendendo sua importância para o versionamento de código e para o trabalho colaborativo.



Também organizamos nosso local de trabalho, criando pastas no computador e estruturando o ambiente de desenvolvimento. Cada aluno criou uma pasta com seu próprio nome e um arquivo README, que será utilizado para registrar atividades e projetos. Durante a aula, foi realizada a votação para a escolha dos representantes de sala, definindo os alunos responsáveis por representar a turma.



Por fim, aprendemos e utilizamos alguns comandos básicos no Prompt de Comando (CMD), fundamentais para a navegação no sistema e para a configuração do Git, como os comandos cd e mkdir, além dos comandos git config --global user.name e git config --global user.email. O primeiro dia de aula foi essencial para a integração da turma e para a preparação do ambiente de desenvolvimento, criando uma base sólida para o início das atividades práticas do curso.



## Introdução ao Desenvolvimento Mobile - Aula 2 - 03/02/2026

### Tipos de Desenvolvimento

- Nativo
    - Android:
        - SDK : Android SDK
        - IDE : Android Studio
        - Linguagens: Kotlin e Java
        - Ambientes: Mac, Win, Linux

    - Ios:
        - SDK: Cocoa Touch02/02
        - IDE: Xcode
        - Liguagens: Swift / Objective-C
        - Ambientes: Mac

- Multiplataforma
    - React Native:
        - SDK: Node.JS
        - IDE: VSCode
        - Linguagens: JavaScript / TypeScript
        - Ambientes: Mac, Win, Linux
    
- Flutter
    - SDK: Flutter SDK
    - IDE: VSCode, Android Studio
    - Linguagens: Dart
    - Ambientes: Mac, Win, Linux
 
## Preparação do Ambiente de desenvolvimento

### Instalação do FlutterSDK
- Download do arquivo ZIP na página flutter.dev
- inclusão do flutter na pasta C:\src
- inclusão do flutter\bin nas varáveis de ambiente
- teste o flutter --version

### Instalação do AndroidSDK
- download do Android SDK - Command Line Tools
- adicionar o Command-line ao c:\src\AndroidSDK
- adicionar o SDKManager as variáveis de ambiente
    - emulador
    - platforms
    - platform-tools
    - build tools
- adicionar ADB e o Emulator as Variáveis de Ambiente
- Criação da Imagem do Emulador - via sdkmanager
- Build do Emulador - via sdkmanager

### Criação de Projetos e Códigos da Linha de Comando

- criação de projetos
    - flutter create nome_do_app
        - flags(parâmetros):
            - --empty : Cria um aplicativo "vazio"(hello World!)
            - --platforms : permite a seleção de uma plataforma de desenvolvimento
                - ex: --platforms=android (a criação do projeto será somente para a plataforma android)
    - exemplo de criação de uma aplicativo android vazio
        - flutter create nome_do_app --empty --platforms=android
        - obs: nome do aplicativo: todas as letras minúsculas, separação de palavras com "_";
    - flutter doctor
        - permite correção de pequenos problemas no flutter e identificação dos parâmetros funcionais em relação as plataforma de desenvolvimento
        - sempre rodar o flutter doctor no começo do desenvolvimento
    - flutter clean
        - limpa cache do build(apaga o apk anterior)
    - flutter run -v 
        - build do app (apk)

- gerenciamento de dependências do PubSpec()
    - instalação
        - flutter pub add nome_dependencia
    - baixar e instalar dependências projetadas 
        - flutter pub get
     - outros comando do flutter pub(dependências)
        - flutter pub outdated ( verifica se as dependências estão desatualizadas)
        - flutter pub upgrade ( atualiza as dependências do flutter pub)


