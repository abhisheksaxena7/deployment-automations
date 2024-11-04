*** Settings ***
Library           QWeb
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite
Library           FakerLibrary

*** Test Cases ***


Verify Data Cloud is Setup
    Appstate      Data Cloud Setup
    VerifyText    Set Up Your Data Cloud Instance
    VerifyText    Your Data Cloud instance is live and connected to your home org.

Enable Agents
    #Enable Einstein
    Appstate      Salesforce Setup
    TypeText      Quick Find                  einstein setup
    ClickText     Einstein Setup
    ${einstein_is_not_enabled}=    Is Text    Off
    Run Keyword If    ${einstein_is_not_enabled}    ClickCheckbox    Turn on EinsteinOnOff    on
    VerifyText    On
    
    #Enable Copilot
    TypeText      Quick Find                  Agents
    ClickText     Agents
    ${copilot_is_not_enabled}=    Is Text    Off
    Run Keyword If    ${copilot_is_not_enabled}    ClickCheckbox    Basic optionOnOff    on
    VerifyText    On
    
    #Verify Einstein for Sales is on
    TypeText      Quick Find                  Einstein for Sales
    ClickText     Einstein for Sales
    VerifyText    Enabled                     anchor=follow-up notes.

    
