*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource   Locators.robot
Library    ../libraries/make_excel.py

*** Keywords ***
Open The Browser
    [Arguments]    ${url}    ${browser}
    Open Browser     ${url}    ${browser}
    Maximize Browser Window
    Sleep    1s

Click on Buses
    TRY
        Wait Until Page Contains Element    ${IFRAME}
        Select Frame    ${IFRAME}
        Wait Until Page Contains Element    ${IFRMCLOSEBUTTON}
        Click Element    ${IFRMCLOSEBUTTON}
        Unselect Frame
        Wait Until Element Is Visible    ${BUSESMENU}
        Click Element    ${BUSESMENU}
        Wait Until Element Is Visible    ${FROMCITY}
    EXCEPT
        Wait Until Element Is Visible    ${BUSESMENU}
        Click Element    ${BUSESMENU}
        Wait Until Element Is Visible    ${FROMCITY}
        END

Enter City Names And Travel Date
    [Arguments]    ${From}    ${To}    ${Date}
    Click Element    ${FROMCITY}
    Wait Until Element Is Visible    ${FROMCITYBOX}
    Input Text    ${FROMCITYBOX}    ${From}
    Wait Until Page Contains    SUGGESTIONS
    Wait Until Page Contains Element    //span[contains(@class, 'sr_city') and contains(text(), '${From}')]
    Click Element    //span[contains(@class, 'sr_city') and contains(text(), '${From}')]
    Click Element    ${TOCITYBOX}
    Input Text    ${TOCITYBOX}    ${To}
    Wait Until Page Contains    SUGGESTIONS
    Wait Until Page Contains Element    //span[contains(@class, 'sr_city') and contains(text(), '${To}')]
    Click Element    //span[contains(@class, 'sr_city') and contains(text(), '${To}')]
    Wait Until Page Contains Element    //div[@aria-label='${Date}']
    Click Element    //div[@aria-label='${Date}']

Search Buses And Save Details To Excel
    Click Button    ${Search}
    Execute JavaScript    return document.readyState == 'complete'
    ${condition}=    Run Keyword And Return Status    Page Should Contain    No buses found
    IF    ${condition}    Capture Page Screenshot    Results/Nobusesfound.png
    Pass Execution If        ${condition}
    ...  ELSE
    Wait Until Page Contains Element        ${BUSLIST}
    ${elements1}   Get WebElements    ${BUSES}
    ${elementsize}    Get Length        ${elements1}
    ${all}    Create List
    FOR    ${ele}    IN RANGE       1    ${elementsize}+1
        ${busname}    Get Text    (//div[@class='makeFlex']/div/p)[${ele}]
        ${bustype}    Get Text    (//p[@class='makeFlex hrtlCenter secondaryTxt nowrapStyle'])[${ele}]
        ${departure}    Get Text    (//span[contains(@class,'font18 latoBlack blackText appendRight4')])[${ele}]
        ${arrival}    Get Text    (//span[contains(@class,'font18 blackText appendRight4 latoRegular')])[${ele}]
        ${price}    Get Text    (//span[@id='price'])[${ele}]
        ${SeatsLeft}    Get Text    (//div[@class='makeFlex hrtlCenter secondaryTxt font12'])[${ele}]
        ${dict}    Create Dictionary
        Set To Dictionary    ${dict}    BusName=${busname}    BusType=${bustype}    Departure=${departure}    Arrival=${arrival}    SeatsLeft=${SeatsLeft}    Price=${price}
        Append To List    ${all}    ${dict}
    END
    Pd Excel File    Reports/Results/Bus_List.xlsx    ${all}
