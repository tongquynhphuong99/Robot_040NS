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
    ...    options=add_argument(--no-sandbox)
    ...    options=add_argument(--disable-dev-shm-usage)
    ...    options=add_argument(--user-data-dir=/tmp/chrome-profile-${RANDOM})
    ...    options=add_argument(--headless)  # Bỏ dòng này nếu bạn muốn thấy trình duyệt
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

