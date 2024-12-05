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
    Appstate                   Data Cloud Setup
    LaunchApp                  Data Cloud

    #Refresh Reservation and Guest Data Streams
    Refresh Data Stream        Reservation_
    Refresh Data Stream        Guest_

Create Data Stream
    Appstate                   Data Cloud Setup
    LaunchApp                  Data Cloud
    ClickText                  Data Streams
    ClickText                  New
    UseModal                   on
    ClickText                  Salesforce CRM
    ClickText                  Next
    Sleep                      10
    ClickText                  Salesforce_Contacts
    Sleep                      10
    ClickText                  Next
    Sleep                      10
    ClickText                  Next
    Sleep                      10
    ClickText                  Deploy
    Sleep                      30
    VerifyNoText               New Data Stream
    UseModal                   off
    # #Refresh Contacts Data Stream
    Refresh Data Stream        Contact_Home