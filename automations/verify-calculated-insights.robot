*** Settings ***
Library             QWeb
Resource            ../resources/common.robot
Suite Setup         Setup Browser
Suite Teardown      End suite
Library             FakerLibrary


*** Test Cases ***


Deploy and Publish Calculated Insight
    Appstate        Data Cloud Setup
    LaunchApp       Data Cloud
    ClickText       More
    ClickText       Calculated Insights
    ClickText       New
    UseModal        on
    ClickText       Create from a Data Kit
    ClickText       Next
    ClickText       Spend Profile By Guest
    Sleep           15
    ClickText       Next
    VerifyNoText    New Insight
    UseModal        off
    SwitchWindow    NEW
    ClickText       Save and Run
    UseModal        on
    ClickText       Next
    ClickText       Enable
    UseModal        off 
    Sleep           15
    RefreshPage
    ClickText       Show 5 more actions
    ClickText       Publish Now

