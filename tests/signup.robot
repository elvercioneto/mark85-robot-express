*** Settings ***

Documentation        Cenários de teste do cadastro de usuários


Library              FakerLibrary

Resource            ../resources/base.resource


# Suite Setup         Log    Tudo aqui ocorre antes da Suite
# Suite Teardown      Log    Tudo aqui ocorre depois da Suite

Test Setup            Start Session
Test Teardown         Take Screenshot

# *** Variables ***

# ${name}            Fernando Papito
# ${email}           papito@yahoo.com
# ${password}        pwd123 

*** Test Cases ***
Deve poder cadastrar um novo usuário

    ${user}                Create Dictionary 
    ...    name=Fernando Papito
    ...    email=papito@yahoo.com
    ...    password=pwd123

    # estrategia faker nao deve ser usada para campos chave
    # ${name}                     FakerLibrary.Name
    # ${email}                    FakerLibrary.Free Email
    # ${password}                 Set Variable        pwd123
   
    Remove user from database    ${user}[email]

    Go to signup page
    Submit signup form        ${user}
    Notice should be          Boas vindas ao Mark85, o seu gerenciador de tarefas.     
  
Não deve permitir o cadastro com o email duplicado
    [Tags]    dup

     ${user}                Create Dictionary 
    ...    name=Papito Fernando
    ...    email=fernando@gmail.com
    ...    password=pwd123


    Remove user from database    ${user}[email]
    Insert user from database    ${user}


    Go to signup page
    Submit signup form        ${user}
    Notice should be          Oops! Já existe uma conta com o e-mail informado.
 
 Deve validar Campos Obrigatórios
     [Tags]            required

     ${user}            Create Dictionary
     ...                name=${EMPTY}
     ...                email=${EMPTY}
     ...                password=${EMPTY}
     
     Go to signup page
     Submit signup form    ${user}

     Alert should be    Informe seu nome completo
     Alert should be    Informe seu e-email
     Alert should be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com email incorreto
    [Tags]            invalid

    ${user}            Create Dictionary
    ...                name=Charles Xavier
    ...                email=xavier.com.br
    ...                password=pwd123

    Go to signup page
    Submit signup form     ${user} 
    Alert should be        Digite um e-mail válido    

Não deve cadastrar com senha muito curta
    [Tags]        temp
    
    @{password_list}        Create List    1    12    123    1234    12345


    FOR    ${password}    IN    @{password_list}
    
            ${user}            Create Dictionary
            ...                name=Fernando Papitp
            ...                email=papito@msn.com
            ...                password=${password}
            
            Go to signup page
            Submit signup form    ${user}

     Alert should be    Informe uma senha com pelo menos 6 digitos
        
    END
   

*** Keywords ***
Short password
    [Arguments]       ${short_pass}
    
    [Tags]            short_pass

     ${user}            Create Dictionary
     ...                name=Fernando Papitp
     ...                email=papito@msn.com
     ...                password=${short_pass}
     
     Go to signup page
     Submit signup form    ${user}

     Alert should be    Informe uma senha com pelo menos 6 digitos