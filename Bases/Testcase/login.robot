*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${browser}    chrome
${url}    https://192.168.10.1/
${username}    admin
${password}    ttcn@99CN

*** Test Cases ***

Login
    ${options}=    Evaluate    ["--no-sandbox", "--disable-gpu", "--disable-dev-shm-usage"]    modules=sys
    Open Browser    ${url}    ${browser}    options=${options}
    Maximize Browser Window
    loginWebgui
    logoutwebgui
    Close Browser
    
*** Keywords ***
loginWebgui
    Click Button    id:details-button
    Click Link    id:proceed-link
    Input Text    id:username    ${username}
    Input Text    id:password    ${password}
    Click Button    id:loginbutton

logoutwebgui
    Sleep    3
    Select Frame    header
    Click Element    xpath://*[@id="logOut"]/font
    Unselect Frame    

