*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${browser}    chrome
${url}    https://192.168.10.1/
${username}    admin
${password}    ttcn@99CN

*** Test Cases ***

Login
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    loginWebgui
    Close Browser
    
*** Keywords ***
loginWebgui
    Click Button    id:details-button
    Click Link    id:proceed-link
    Input Text    id:username    ${username}
    Input Text    id:password    ${password}
    Click Button    id:loginbutton
