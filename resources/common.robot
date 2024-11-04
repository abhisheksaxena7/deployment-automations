*** Settings ***
Library                         QWeb
Library                         QForce
Library                         String


*** Variables ***
${BROWSER}                      chrome
${home_url}                     ${dc_static_login_url}/lightning/page/home
${data_cloud_setup_url}         ${dc_static_login_url}/lightning/setup/SetupOneHome/home?setupApp=audience360
${salesforce_setup_url}         ${dc_static_login_url}/lightning/setup/SetupOneHome/home?setupApp=all

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
    GoTo                        ${dc_static_login_url}
    TypeText                    Username                    ${dc_username}              delay=1
    TypeText                    Password                    ${dc_password}
    ClickText                   Log In

Dynamic Login
    [Documentation]             Login to Salesforce instance
    ${DYNAMIC_LOGIN}=           Get Variable Value          ${loginUrl}                 NoValuePassed
    IF                          '${DYNAMIC_LOGIN}' != 'NoValuePassed'
        Set Global Variable     ${home_url}                 ${loginUrl}/lightning/page/home
        Set Global Variable     ${data_cloud_setup_url}     ${loginUrl}/lightning/setup/SetupOneHome/home?setupApp=audience360
        Set Global Variable     ${salesforce_setup_url}     ${loginUrl}/lightning/setup/SetupOneHome/home?setupApp=all
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

Data Cloud Setup
    Home
    Sleep                       5
    Log                         DC Setup URL: ${data_cloud_setup_url}
    GoTo                        ${data_cloud_setup_url}
    VerifyTitle                 Data Cloud Setup | Salesforce

Salesforce Setup
    Home
    GoTo                        ${salesforce_setup_url}
    VerifyText                  Setup Home