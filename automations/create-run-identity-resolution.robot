*** Settings ***
Library                         QWeb
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         FakerLibrary


*** Test Cases ***


Deploy and Run Identity Resolution
    Appstate                    Data Cloud Setup
    LaunchApp                   Data Cloud
    ClickText                   Identity Resolutions
    ClickText                   New
    UseModal                    on
    ClickText                   Install from Datakits
    ClickText                   Next
    ClickText                   Select Item   anchor=Guest Name and Email
    ClickText                   Next
    ClickText                   Save
    VerifyNoText                New Ruleset
    UseModal                    off
    Sleep                       10
    ClickText                   Run Ruleset