*** Settings ***
Documentation        Ações e elementos da página de cadastro de tarefas


Library            Browser

*** Keywords ***
Submit task form
    [Arguments]        ${task}

    #input[placeholder$=tarefa]  // usando expressão regular
    #o dólar($) significa termina com 
    #o acento(^) significa começa com 
    #o asterisco(*$*) significa buscar tudo(contains) 
    Fill Text         css=input[placeholder$=tarefa]        ${task}[name]

    ${tags_element}        Set Variable            css=input[name=tags]

    
    FOR    ${tag}    IN    @{task}[tags]
        Fill Text         ${tags_element}        ${tag}
        Sleep             1 
        Press Keys        ${tags_element}        Enter  
    END
         

    Click             css=button >> text=Cadastrar

   