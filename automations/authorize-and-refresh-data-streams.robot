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
    UseModal                   on
    ClickText                  Refresh Only New Files
    Sleep                      5
    ClickText                  Refresh Now                 anchor=Cancel
    UseModal                   off

    #Refresh Guest Data Stream
    ClickText                  Data Streams
    ClickText                  Select a List View: Data Streams
    ClickText                  All Data Streams
    #TypeText                  Search this list...         Guest\n
    #ClickText                 Show Actions
    #ClickText                 Refresh Now
    #ClickText                 Refresh Now                 anchor=Cancel
    #ClickText                 Guest_
    #ClickText                 Refresh Now
    #ClickText                 Refresh Only New Files
    #ClickText                 Refresh Now                 anchor=Cancel


