*** Settings ***
Library    SeleniumLibrary

Default Tags    sanity   

*** Variables ***
${URL}    https://www.saucedemo.com/
@{CREDENTIALS}    standard_user    secret_sauce
&{LGOINDATA}    username=standard_user    password=secret_sauce
${PATH}    C:/Users/saif_zaghloul/Downloads/chromedriver_win32/chromedriver.exe

*** Test Cases *** 
FirstTest
    Open Browser    ${URL}    chrome    executable_path=${PATH}
    Set Browser Implicit Wait    5
    LoginKW  
    Sleep    5

SecondTest
    Click Button    id=add-to-cart-sauce-labs-backpack
    ${ItemName}    Get Text    xpath=//*[@id="item_4_title_link"]/div
    Click Element    class=shopping_cart_link
    Log To Console    ${ItemName}
 
 
*** Keywords ***
LoginKW
    Input Text        id=user-name    ${LGOINDATA}[username]
    Input Password    id=password    ${LGOINDATA}[password]
    Click Button      id=login-button 
    
    
 
 
    
  
    
   
         