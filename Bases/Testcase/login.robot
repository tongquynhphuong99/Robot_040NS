*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${browser}    chrome
${url}    https://192.168.10.1/
${username}    admin
${password}    ttcn@99CN
${USER_DATA_DIR}    /tmp/robot-profile-${RUNID}
*** Test Cases ***

Login
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${RANDOM}=     Evaluate    __import__('uuid').uuid4().hex
    ${USER_DATA_DIR}=    Set Variable    /tmp/robot-profile-${RANDOM}
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --user-data-dir=${USER_DATA_DIR}
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

