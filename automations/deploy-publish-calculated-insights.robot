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
    ClickText       Next
    VerifyNoText    New Insight
    UseModal        off
    SwitchWindow    NEW
    ClickText       Save                        parent=LIGHTNING-BUTTON
    ClickText       Next
    ClickText       Enable
    Sleep 10
    RefreshPage
    ClickText       Show 5 more actions
    ClickText       Publish Now

