*** Settings ***

Documentation            Ações e elemtentos do cabeçalho do mark85

Library                    String
Library                    Browser

*** Keywords ***
User should be logged in 
    [Arguments]        ${name}

    @{splited_name}    Split String        ${name}
    Log                 ${splited_name}

    ${element}        Set Variable        css=header .right small
    
    Wait For Elements State    ${element}     visible        5 
    Get Text                   ${element}     equal         Olá, ${splited_name}[0]
Go to task form
    Click       css=.button-add     