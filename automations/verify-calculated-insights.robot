*** Settings ***
Library           QWeb
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite
Library           FakerLibrary


*** Test Cases ***


Verify Calculated Insight
    Appstate      Data Cloud Setup
    LaunchApp     Data Cloud
    ClickText     More
    ClickText     Calculated Insights
    ClickText     Select a List View: Calculated Insights
    ClickText     All Calculated Insights
    VerifyText    Spend Profile By Guest


