//
//  SMHS_ScheduleTests.swift
//  SMHS ScheduleTests
//
//  Created by Jevon Mao on 3/15/21.
//

import XCTest
import SwiftUI
@testable import SMHSSchedule__iOS_

class SMHS_ScheduleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArrayLastExtension() { 
        var intArray = [1,2,3,0]
        var stringArray = ["a", "c", "b"]
        var emptyArray: [Double] = []
        XCTAssertEqual(intArray.last, 0)
        XCTAssertEqual(stringArray.last, "b")
        intArray.last = 3
        stringArray.last = "J"
        XCTAssertEqual(intArray.last, 3)
        XCTAssertEqual(stringArray.last, "J")
        XCTAssertEqual(emptyArray.last, nil)
    }
    
    func testUIKitColorExtension() {
        XCTAssertEqual(Color.platformBackground, Color(UIColor.systemBackground))
        XCTAssertEqual(Color.platformLabel , Color(UIColor.label))
        XCTAssertEqual(Color.platformSecondaryBackground, Color(UIColor.secondarySystemBackground))
    }
    
    func testHexStringToColor() {
        let blueColor = hexStringToColor(hex: "#3498db")
        let redColor = hexStringToColor(hex: "e74c3c")
        let testBlueColor = Color(.sRGB, red: 52 / 255, green: 152 / 255, blue: 219 / 255, opacity: 1)
        let testRedColor = Color(.sRGB, red: 231 / 255, green: 76 / 255, blue: 60 / 255, opacity: 1)
        XCTAssertEqual(redColor, testRedColor)
        XCTAssertEqual(blueColor, testBlueColor)
    }
    
    func testStringLinesExtension() {
        let testString = "SMHS Schedule\nis the best app\n"
        XCTAssertEqual(testString.lines[0], "SMHS Schedule")
        XCTAssertEqual(testString.lines[1], "is the best app")
        let testString2 = ""
        XCTAssertEqual(testString2.lines.isEmpty, true)
        let testString3 = "1\n8\n0\n7"
        XCTAssertEqual(testString3.lines[0], "1")
        XCTAssertEqual(testString3.lines[2], "0")
        XCTAssertEqual(testString3.lines[3], "7")
    }
    
    func testCurrentWeekDayExtension() {
        let currentWeekday = Calendar.current.component(.weekday, from: Date())-1
        XCTAssertEqual(Date.currentWeekday, currentWeekday)
    }
    
    func testGetDayOfTheWeekExtension() {
        let dayOfTheWeek = Calendar.current.component(.weekday, from: Date())-1
        XCTAssertEqual(Date.getDayOfTheWeek(for: Date()), dayOfTheWeek)
    }

    func testParseScheduleData() throws {
        let sampleText = "BEGIN:VCALENDAR\r\nVERSION:2.0\r\nPRODID:-//Santa Margarita Catholic High School/finalsite//NONSGML v1.0//EN\r\nCALSCALE:GREGORIAN\r\nX-WR-CALNAME:BELL Schedule\r\nBEGIN:VEVENT\r\nUID:703702@smhsorg.finalsite.com\r\nDTSTAMP:20210421T222201Z\r\nDTSTART;VALUE=DATE:20210322\r\nSUMMARY:SMCHS Events\r\nDESCRIPTION:\\nSpring Recess\\n\\nFaculty/Student Holiday\\n\\nB JV/V Golf @ Ayala Tourn\\n\\nG JV Tennis vs Tesoro 3:00\\n\\nG V Golf vs Aliso Niguel 4:30\\n\\nG V Tennis @ Tesoro 3:00\\n\r\nPRIORITY:0\r\nEND:VEVENT\r\nBEGIN:VEVENT\r\nUID:703695@smhsorg.finalsite.com\r\nDTSTAMP:20210421T222201Z\r\nDTSTART;VALUE=DATE:20210323\r\nSUMMARY:Special Schedule Day 5\r\nDESCRIPTION:Period 5                                   8:00-9:05\\n\\nPeriod 6                                   9:12-10:22 \\n(5 minutes for announcements)\\n\\nNutrition             Period 7 \\n10:22-11:02       10:29-11:34 \\n\\nPeriod 7             Nutrition \\n11:09-12:14      11:34-12:14 \\n\\nPeriod 1                                   12:21-1:26 \\n\\nClass Officer Elections            1:31-2:00 \\n(So/Jr report to Distribution Periods for elections) \\n\\nOffice Hours                            2:05-2:30 \\n------------------------------- \\n\\nClass Officer Elections\\n\\n(So/Jr 8:00-2:00)\\n\\n(Fr/Sr 8:00-1:26)\\n\\nHomecoming Spirit Week\\n\\nB FS/JV/V Soccer @ MD 3:15/7:00/5:00\\n\\nFr/V Baseball @ Dana Hills 3:15/3:15\\n\\nG FS/JV/V Soccer vs MD 3:00/7:15/5:30\\n\\nG JV Tennis @ JSerra 3:00\\n\\nG V Tennis vs JSerra 3:15\\n\\nJV Blue Baseball vs Dana Hills 3:15\\n\\nKairos\\n\\nSball @ San Clemente 3:30\\n\r\nPRIORITY:0\r\nEND:VEVENT\r\nBEGIN:VEVENT\r\nUID:703692@smhsorg.finalsite.com\r\nDTSTAMP:20210421T222201Z\r\nDTSTART;VALUE=DATE:20210324\r\n"
        let expectation = XCTestExpectation(description: "Wait for parsing text")
        var scheduleWeeks: [ScheduleWeek]?
        ScheduleDateHelper().parseScheduleData(withRawText: sampleText){
            scheduleWeeks = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        let unwrappedScheduleWeeks = try XCTUnwrap(scheduleWeeks)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
