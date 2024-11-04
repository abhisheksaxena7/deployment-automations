*** Settings ***
Library    QWeb
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         FakerLibrary

*** Test Cases ***


Verify Data Cloud is Setup
    [tags]                      Lead                        Salesforce Login
    Appstate                    Data Cloud Setup
    VerifyText                  Set Up Your Data Cloud Instance
    VerifyText                  Your Data Cloud instance is live and connected to your home org.
