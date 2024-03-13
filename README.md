# Robot Framework Automation

This project aims to automate testing for the buses page using Robot Framework. It tests various functionalities of the buses page and fetches details, saving them to Excel. Additionally, it generates HTML reports for better visualization of test results.

## Prerequisites

Before running the tests, ensure you have the following installed:

- Python
- Robot Framework
- SeleniumLibrary
- Robot Framework ExcelLibrary

## Running the Tests

To run the tests, execute the following command in your terminal:

```bash
robot --outputdir Reports testCases\*.robot
