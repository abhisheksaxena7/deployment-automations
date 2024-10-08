*** Settings ***
Library                         QWeb
Library                         QForce
Library                         String


*** Variables ***
${BROWSER}                      chrome
${username}                     YOUR USERNAME HERE
${login_url}                    https://YOURDOMAIN.my.salesforce.com                    # Salesforce instance. NOTE: Should be overwritten in CRT variables
${home_url}                     ${login_url}/lightning/page/home


*** Keywords ***
Setup Browser
    Set Library Search Order    QWeb                        QForce
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              20s                         #sometimes salesforce is slow


End suite
    Set Library Search Order    QWeb                        QForce
    Close All Browsers


Static Login
    [Documentation]             Login to Salesforce instance
    Set Library Search Order    QWeb                        QForce
    GoTo                        ${static_login_url}
    TypeText                    Username                    ${username}                 delay=1
    TypeText                    Password                    ${password}
    ClickText                   Log In

Dynamic Login
    [Documentation]             Login to Salesforce instance
    ${DYNAMIC_LOGIN}=           Get Variable Value          ${loginUrl}                 NoValuePassed
    IF                          '${DYNAMIC_LOGIN}' != 'NoValuePassed'
        GoTo                    ${DYNAMIC_LOGIN}
    ELSE
        Static Login
    END

Home
    [Documentation]             Navigate to homepage, login if needed
    Set Library Search Order    QWeb                        QForce
    GoTo                        ${home_url}
    ${login_status} =           IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If              ${login_status}             Dynamic Login
    ClickText                   Home
    VerifyTitle                 Home | Salesforce