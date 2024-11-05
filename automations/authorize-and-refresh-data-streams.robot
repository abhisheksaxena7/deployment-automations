*** Settings ***
Library                         QWeb
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         FakerLibrary


*** Test Cases ***


Establish and verify AWS connection
    Appstate                    Data Cloud Setup
    ClickText                   Other Connectors

    #Verify Connection Record exists
    VerifyText                  Coral Cloud S3 Connection

    #Check if Connection is Inactive
    ${connection_inactive}=     Is Text                     Inactive
    IF                          ${connection_inactive}
        ClickText               Show actions
        ClickText               Activate
        TypeSecret              AWS access key              ${AWS_access_key}
        TypeSecret              AWS secret access key       ${AWS_secret_access_key}
        ClickText               Test Connection
        VerifyText              Connection was established
        ClickText               Save
    ELSE
        VerifyText              Active
    END


Enable Agents
    #Enable Einstein
    Appstate                    Salesforce Setup
    TypeText                    Quick Find                  einstein setup
    ClickText                   Einstein Setup
    ${einstein_is_not_enabled}=                             Is Text                     Off
    Run Keyword If              ${einstein_is_not_enabled}                              ClickCheckbox            Turn on EinsteinOnOff    on
    VerifyText                  On

    #Enable Copilot
    TypeText                    Quick Find                  Agents
    ClickText                   Agents
    ${copilot_is_not_enabled}=                              Is Text                     Off
    Run Keyword If              ${copilot_is_not_enabled}                               ClickCheckbox            Basic optionOnOff    on
    VerifyText                  On

    #Verify Einstein for Sales is on
    TypeText                    Quick Find                  Einstein for Sales
    ClickText                   Einstein for Sales
    VerifyText                  Enabled                     anchor=follow-up notes.