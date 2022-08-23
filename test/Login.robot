*** Settings ***
Library    SeleniumLibrary
Library         Dialogs

Default Tags    sanity   

*** Keywords ***
LoginKW
    [Arguments]  ${Username}  ${Password}
    Input Text        id=user-name    ${Username}
    Input Password    id=password    ${Password}
    Click Button      id=login-button 


*** Variables ***
${URL}    https://www.saucedemo.com/
# @{CREDENTIALS}    standard_user    secret_sauce
&{VALIDLOGINDATA}    username=standard_user    password=secret_sauce
&{INVALIDLOGINDATA}    username=invalid_user    password=secret_sauce
${PATH1}    ./Driver/chromedriver.exe
${PATH2}    ./Driver/msedgedriver.exe

*** Test Cases ***
OpenWebSiteWithInvalidCredentials
    Open Browser    ${URL}    edge    executable_path=${PATH2}  options=add_argument("--incognito")
    Set Browser Implicit Wait    5
    LoginKW  ${INVALIDLOGINDATA}[username]  ${INVALIDLOGINDATA}[password]
    Sleep    5
    Element Should Be Visible  class=error-button
    Pause Execution    Hi There please Press Ok
 
 
    
  
    
   
         