*** Settings ***
Documentation        Ações e elementos da página de login


Library             Browser

*** Keywords ***
Submit login form
    [Arguments]        ${user}


    # placeholder que termina com mail
    Fill Text         css=input[placeholder$=mail]     ${user}[email]
    Fill Text         css=input[placeholder=Senha]     ${user}[password]

    #Click             xpath=//button[text()='Entrar'] usar xpath um último caso
    # aqui é mais simples
    Click             css=button >> text=Entrar





