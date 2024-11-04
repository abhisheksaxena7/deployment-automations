*** Settings ***
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         FakerLibrary

*** Test Cases ***


Enable Data C
    [tags]                      Lead                        Salesforce Login
    Appstate                    Home
    LaunchApp                   Data Cloud