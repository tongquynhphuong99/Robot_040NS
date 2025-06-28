*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${browser}    chrome
${url}    https://192.168.10.1/
${username}    admin
${password}    ttcn@99CN
${chrome_options}    add_argument(--no-sandbox); add_argument(--disable-dev-shm-usage); add_argument(--disable-gpu); add_argument(--user-data-dir=/tmp/chrome-profile-${RANDOM})
*** Test Cases ***

Login
    Open Browser    ${url}    ${browser}    options=${chrome_options}
    Maximize Browser Window
    loginWebgui
    logoutwebgui
    [Teardown]    Close Browser
    
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

