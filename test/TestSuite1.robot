*** Settings ***
Library    SeleniumLibrary
Library         Dialogs
Library           String

Default Tags    sanity   

*** Keywords ***
LoginKW
    [Arguments]  ${Username}  ${Password}
    Input Text        id=user-name    ${Username}
    Input Password    id=password    ${Password}
    Click Button      id=login-button 


*** Variables ***
${URL}    https://www.saucedemo.com/
@{CREDENTIALS}    standard_user    secret_sauce
&{LOGINDATA}    username=standard_user    password=secret_sauce
&{INVALIDLOGINDATA}    username=invalid_user    password=secret_sauce
${PATH}    ../Driver/chromedriver.exe

*** Test Cases ***
OpenWebSiteWithInvalidCredentials
    Open Browser    ${URL}    chrome    executable_path=${PATH}  options=add_argument("--incognito")
    Set Browser Implicit Wait    5
    LoginKW  ${INVALIDLOGINDATA}[username]  ${INVALIDLOGINDATA}[password]
    Sleep    5
    Element Should Be Visible  class=error-button
    Pause Execution    Hi There please Press Ok

OpenWebSiteWithValidCredentials
    Execute Javascript    window.open('')
    Switch Window  locator=NEW
    Go To   ${URL}
    Set Browser Implicit Wait    5
    LoginKW  ${LOGINDATA}[username]  ${LOGINDATA}[password]
    Pause Execution    Press OK

AddItemToCartAndCheckCartAfterwards
    Execute Javascript    window.open('')
    Switch Window  locator=NEW
    Go To   ${URL}
    LoginKW  ${LOGINDATA}[username]  ${LOGINDATA}[password]
    ${ItemPrice} =  Get Text  class=inventory_item_price
    ${ItemPrice} =  Remove String        ${ItemPrice}   $
    ${ItemPrice} =  Convert To Number    ${ItemPrice}
    Click Button    id=add-to-cart-sauce-labs-backpack
    Sleep  10
    Click Element    class=shopping_cart_link
    @{CartITems}  Get WebElements  class=cart_item
    Should Not Be Empty    ${CartITems}
    Pause Execution    Press OK
    Set Global Variable  ${ItemPrice}


#CheckIfPriceMatchesInCart
#   We need to create a test to check if the price of the selected item matches the price of the item in the Cart
#   Price of the added item is saved in a variable called ItemPrice
#   Navigate to the cart before deleting the item and retrieve the price of the available item
#   Remove the -dollar sign- $ and cast it from string to number
#   Compare the two variables to each other     
    

RemoveItemFromCartAndCheckCartAfterwards
    Execute Javascript    window.open('')
    Switch Window  locator=NEW
    Go To   ${URL}
    LoginKW  ${LOGINDATA}[username]  ${LOGINDATA}[password]
    Click Element    class=shopping_cart_link
    Sleep  5
    Click Button    id=remove-sauce-labs-backpack
    Pause Execution    Press OK
    @{CartITems}  Get WebElements  class=cart_item
    Should Be Empty    ${CartITems}
    
    
 
 
    
  
    
   
         