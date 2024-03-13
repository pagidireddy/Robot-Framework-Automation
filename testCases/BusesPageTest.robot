*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/KeyWords.robot

*** Variables ***
${url}=    https://www.makemytrip.com/
${browser}=    chrome
${source_city}=    Anantapur
${destination_city}=    Chennai
${travel_date}=    Mon Mar 11 2024

*** Test Cases ***
Test Buses Tab
    Open The Browser    ${url}    ${browser}
    Click on Buses
    Enter City Names And Travel Date    ${source_city}    ${destination_city}   ${travel_date}
    Search Buses And Save Details To Excel
