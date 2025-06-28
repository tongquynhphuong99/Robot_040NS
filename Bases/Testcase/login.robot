*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${browser}    chrome
${url}    https://192.168.10.1/
${username}    admin
${password}    ttcn@99CN

*** Test Cases ***

Login
    ${timestamp}=    Evaluate    __import__('time').time()
    ${profile_dir}=  Set Variable    /tmp/chrome-profile-${timestamp}
    Open Browser    ${url}    ${browser}
    ...    options=add_argument(--no-sandbox)
    ...    options=add_argument(--disable-dev-shm-usage)
    ...    options=add_argument(--user-data-dir=${profile_dir})
    ...    options=add_argument(--headless)
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

