*** Settings ***
Library    SeleniumLibrary

Default Tags    sanity   

*** Variables ***
${URL}    https://www.saucedemo.com/
@{CREDENTIALS}    standard_user    secret_sauce
&{LOGINDATA}    username=standard_user    password=secret_sauce
&{INVALIDLOGINDATA}    username=invalid_user    password=secret_sauce
${PATH}    C:/Users/saif_zaghloul/Downloads/chromedriver_win32/chromedriver.exe

*** Test Cases ***
OpenWebSiteWithInvalidCredentials
    Open Browser    ${URL}    chrome    executable_path=${PATH}  options=add_argument("--incognito")
    Set Browser Implicit Wait    5
    LoginKW  ${INVALIDLOGINDATA}[username]  ${INVALIDLOGINDATA}[password]
    Sleep    5
    Element Should Be Visible  class=error-button

OpenWebSiteWithValidCredentials
    Execute Javascript    window.open('')
    Switch Window  locator=NEW
    Go To   ${URL}
    Set Browser Implicit Wait    5
    LoginKW  ${LOGINDATA}[username]  ${LOGINDATA}[password]
    Sleep    5

AddItemToCartAndCheckCartAfterwards
    Execute Javascript    window.open('')
    Switch Window  locator=NEW
    Go To   ${URL}
    LoginKW  ${LOGINDATA}[username]  ${LOGINDATA}[password]
    Sleep    5
    Click Button    id=add-to-cart-sauce-labs-backpack
    Sleep    5
    Click Element    class=shopping_cart_link
    Sleep    5
    @{CartITems}  Get WebElements  class=cart_item
    Should Not Be Empty    ${CartITems}
    

RemoveItemFromCartAndCheckCartAfterwards
    Execute Javascript    window.open('')
    Switch Window  locator=NEW
    Go To   ${URL}
    LoginKW  ${LOGINDATA}[username]  ${LOGINDATA}[password]
    Sleep    5
    Click Element    class=shopping_cart_link
    Sleep    5
    Click Button    id=remove-sauce-labs-backpack
    Sleep    5
    @{CartITems}  Get WebElements  class=cart_item
    Should Be Empty    ${CartITems}
 
 
*** Keywords ***
LoginKW
    [Arguments]  ${Username}  ${Password}
    Input Text        id=user-name    ${Username}
    Input Password    id=password    ${Password}
    Click Button      id=login-button 
    
    
 
 
    
  
    
   
         