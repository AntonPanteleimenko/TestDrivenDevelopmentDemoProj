//
//  MathTests.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 28.06.2021.
//

import XCTest
@testable import TestExamples

class MathTests: XCTestCase {
    
//    var formatter: MoneyFormatter!
//
//    override func setUpWithError() throws {
//        formatter = MoneyFormatter()
//    }
//
//    override func tearDownWithError() throws {
//        formatter = nil
//    }

    func testMath_ForMoneyFormatter_WithWholeNUmber() {
        
        // Arrange
        
        let formatter = MoneyFormatter()
        
        // Act
        
        // Assert
        
        XCTAssertEqual(formatter.string(decimal: 0), "0.00")
        
        XCTAssertEqual(formatter.string(decimal: 0), "0.00")
        XCTAssertEqual(formatter.string(decimal: 1), "1.00")
        
        XCTAssertEqual(formatter.string(decimal: 0), "0.00")
        XCTAssertEqual(formatter.string(decimal: 1), "1.00")
        XCTAssertEqual(formatter.string(decimal: 2), "2.00")
        XCTAssertEqual(formatter.string(decimal: 123), "123.00")
        XCTAssertEqual(formatter.string(decimal: -2), "-2.00")
    }

//    func testMath_ForMoneyFormatter_WithDecimalNUmber_AndOneDecimalPlace() {
//
//        // Arrange
//
//        //let formatter = MoneyFormatter()
//
//        // Act
//
//        // Assert
//
////        XCTAssertEqual(formatter.string(decimal: 1.1), "1.10")
//
//        XCTAssertEqual(formatter.string(decimal: 1.1), "1.10")
//        XCTAssertEqual(formatter.string(decimal: 1.2), "1.20")
//        XCTAssertEqual(formatter.string(decimal: -1.2), "-1.20")
//    }

//    func testMath_ForMoneyFormatter_WithDecimalNUmber_AndTwoDecimalPlaces() {
//
//        // Arrange
//
//        //let formatter = MoneyFormatter()
//
//        // Act
//
//        // Assert
//
//        XCTAssertEqual(formatter.string(decimal: 1.11), "1.11")
//        XCTAssertEqual(formatter.string(decimal: 1.12), "1.12")
//        XCTAssertEqual(formatter.string(decimal: -1.12), "-1.12") // - "Later error"
//    }

//    func testMath_ForMoneyFormatter_WithDecimalNUmber_AndAnyDecimalPlaces() {
//
//        // Arrange
//
//        //let formatter = MoneyFormatter()
//
//        // Act
//
//        // Assert
//
//        XCTAssertEqual(formatter.string(decimal: 1.111), "1.11")
//        XCTAssertEqual(formatter.string(decimal: 1.119), "1.11")
//    }
    
    
    /* ************************************************** */
    
    
//    func testMath_ForMoneyFormatter_WithWholeNUmber() {
//
//        // Arrange
//        // Act
//
//        // Assert
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "0")!), "0.00")
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "1")!), "1.00")
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "2")!), "2.00")
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "123")!), "123.00")
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "-2")!), "-2.00")
//    }
//
//    func testMath_ForMoneyFormatter_WithDecimalNUmber_AndOneDecimalPlace() {
//
//        // Arrange
//        // Act
//
//        // Assert
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "1.1")!), "1.10")
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "1.2")!), "1.20")
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "-1.2")!), "-1.20")
//    }
//
//    func testMath_ForMoneyFormatter_WithDecimalNUmber_AndTwoDecimalPlaces() {
//
//        // Arrange
//        // Act
//
//        // Assert
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "1.11")!), "1.11")
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "1.12")!), "1.12")
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "-1.12")!), "-1.12")
//    }
//
//    func testMath_ForMoneyFormatter_WithDecimalNUmber_AndAnyDecimalPlaces() {
//
//        // Arrange
//        // Act
//
//        // Assert
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "1.111")!), "1.11")
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "1.119")!), "1.11")
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "1.23456789")!), "1.23")
//        XCTAssertEqual(formatter.string(decimal: Decimal(string: "-1.23456789")!), "-1.24")
//    }
}
