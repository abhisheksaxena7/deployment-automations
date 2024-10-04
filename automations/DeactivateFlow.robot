*** Settings ***
Resource             ../resources/common.robot
Suite Setup          Setup Browser
Suite Teardown       End suite
Library              FakerLibrary

*** Test Cases ***
Login to target
    Dynamic Login
    Sleep            5
    LogScreenshot

    # Entering A Lead
    #                [tags]                      Lead    Salesforce Login
    #                Appstate                    Home
    #                LaunchApp                   Sales

    #                #First we will navigate to the Leads tab in the Sales Application. We will start a new lead from this screen.
    #                ClickText                   Leads
    #                VerifyText                  Recently Viewed    timeout=120s
    #                ClickText                   New    anchor=Import
    #                VerifyText                  Lead Information
    #                UseModal                    On    # Only find fields from open modal dialog


    #                #We will create a new lead using randomly generated Data (This is done via FakerLibrary).
    #                ${firstname}=               FakerLibrary.firstname
    #                ${lastname}=                FakerLibrary.lastname
    #                Set Suite Variable          ${firstname}
    #                Set Suite Variable          ${lastname}
    #                Picklist                    Salutation    Ms.
    #                TypeText                    First Name    ${firstname}
    #                TypeText                    Last Name    ${lastname}
    #                Picklist                    Lead Status    Open
    #                TypeText                    Phone    +12234567858449    First Name
    #                TypeText                    Company    Growmore    Last Name
    #                TypeText                    Title    Manager    Address Information
    #                TypeText                    Email    ${firstname}.${lastname}@gmail.com    Rating
    #                TypeText                    Website    https://www.growmore.com/

    #                ClickText                   Lead Source
    #                ClickText                   Advertisement
    #                ClickText                   Save    partial_match=False
    #                UseModal                    Off
    #                Sleep                       2

    #                ClickText                   Details    anchor=Chatter
    #                VerifyText                  Ms. ${firstname} ${lastname}
    #                VerifyText                  Manager    anchor=Title
    #                VerifyField                 Phone    +12234567858449
    #                VerifyField                 Company    Growmore
    #                VerifyField                 Website    https://www.growmore.com/

    #                ClickText                   Leads
    #                VerifyText                  ${firstname} ${lastname}
    #                VerifyText                  Manager
    #                VerifyText                  Growmore

    # Delete Created Lead
    #                [tags]                      Lead    Salesforce Login
    #                LaunchApp                   Sales
    #                ClickText                   Leads
    #                VerifyText                  Recently Viewed    timeout=120s

    #                Wait Until Keyword Succeeds    1 min    5 sec    ClickText    ${firstname} ${lastname}
    #                ClickText                   Show more actions
    #                ClickText                   Delete
    #                ClickText                   Delete