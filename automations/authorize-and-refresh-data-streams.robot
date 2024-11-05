*** Settings ***
Library                        QWeb
Resource                       ../resources/common.robot
Suite Setup                    Setup Browser
Suite Teardown                 End suite
Library                        FakerLibrary


*** Test Cases ***


Establish and verify AWS connection
    Appstate                   Data Cloud Setup
    ClickText                  Other Connectors

    #Verify Connection Record exists
    VerifyText                 Coral Cloud S3 Connection

    #Check if Connection is Inactive
    ${connection_inactive}=    Is Text                     Inactive
    IF                         ${connection_inactive}
        ClickText              Show actions
        ClickText              Activate
        TypeSecret             AWS access key              ${AWS_access_key}
        TypeSecret             AWS secret access key       ${AWS_secret_access_key}
        ClickText              Test Connection
        VerifyText             Connection was established
        ClickText              Save
    ELSE
        VerifyText             Active
    END


Refresh Data Streams
    #Enable Einstein
    Appstate                   Data Cloud Setup
    LaunchApp                  Data Cloud

    #Refresh Reservation Data Stream
    ClickText                  Data Streams
    ClickText                  Select a List View: Data Streams
    ClickText                  All Data Streams
    ClickText                  Reservation_
    ClickText                  Refresh Now
    UseModal                   on                          //div[contains(@class, 'slds-modal__container')]
    ClickText                  Refresh Only New Files
    ClickElement               //button[contains(@class, 'slds-button_brand') and contains(., 'Refresh Now')]
    VerifyNoText               Refresh Only New Files
    UseModal                   off

    #Refresh Guest Data Stream
    ClickText                  Data Streams
    ClickText                  Select a List View: Data Streams
    ClickText                  All Data Streams
    ClickText                  Guest_
    ClickText                  Refresh Now
    UseModal                   on                          //div[contains(@class, 'slds-modal__container')]
    ClickText                  Refresh Only New Files
    ClickElement               //button[contains(@class, 'slds-button_brand') and contains(., 'Refresh Now')]
    UseModal                   off

