*** Settings ***
Library                         QWeb
Library                         QForce
Library                         String
Library                         Collections


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
        GoTo                    ${DYNAMIC_LOGIN}
        ${current_url}=         GetUrl
        Log                     Current URL: ${current_url}
        ${instance_url}=        Get Regexp Matches          ${current_url}              (https://.*\\.force\\.com)
        ${instance_url}=        Get From List               ${instance_url}             0
        Log                     IU: ${instance_url}
        Set Global Variable     ${home_url}                 ${instance_url}/lightning/page/home
        Set Global Variable     ${data_cloud_setup_url}     ${instance_url}/lightning/setup/SetupOneHome/home?setupApp=audience360
        Set Global Variable     ${salesforce_setup_url}     ${instance_url}/lightning/setup/SetupOneHome/home?setupApp=all
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
    Log                         DC Setup URL: ${data_cloud_setup_url}
    GoTo                        ${data_cloud_setup_url}
    VerifyTitle                 Data Cloud Setup | Salesforce

Salesforce Setup
    Home
    GoTo                        ${salesforce_setup_url}
    VerifyText                  Setup Home

Refresh Data Stream
    [Arguments]                 ${stream_name}
    ClickText                   Data Streams
    ClickText                   Select a List View: Data Streams
    ClickText                   All Data Streams
    ClickText                   ${stream_name}
    RefreshPage
    ClickText                   Refresh Now
    IF                          '${stream_name}' != 'Contact_Home'
    # Your code here
        UseModal                on                          //div[contains(@class, 'slds-modal__container')]
        ClickText               Refresh Only New Files
        ClickElement            //button[contains(@class, 'slds-button_brand') and contains(., 'Refresh Now')]
        VerifyNoText            Refresh Only New Files
        UseModal                off
    END