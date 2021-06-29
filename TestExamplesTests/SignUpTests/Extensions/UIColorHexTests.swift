//
//  UIColorHexTests.swift
//  TestExamplesTests
//
//  Created by Anton Panteleimenko on 11.06.2021.
//

import XCTest
import UIKit
@testable import TestExamples

class UIColorHexTests: XCTestCase {
    
    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }
    
    func testUIColorInit_WithRGB() {
        // Arrange
        let sus = UIColor(r: 30.0, g: 144.0, b: 255)
        let dodgerBlueHexColor = UIColor.init(hexString: "1E90FF")
        // Act
        // Assert
        XCTAssertEqual(sus, dodgerBlueHexColor)
        XCTAssertNotNil(sus)
        XCTAssertNotNil(dodgerBlueHexColor)
    }
    
    func testUIColorInit_WithGrayColor() {
        // Arrange
        let sus = UIColor(gray: 192.0)
        let silverColor = UIColor.init(hexString: "C0C0C0")
        // Act
        // Assert
        XCTAssertEqual(sus, silverColor)
        XCTAssertNotNil(sus)
        XCTAssertNotNil(silverColor)
    }
    
    func testUIColorInit_WithRandomColor() {
        // Arrange
        let sus = UIColor.randomCGColor()
        // Act
        // Assert
        XCTAssertNotNil(sus)
    }

    func testUIColorInit_WithHexAlhpa() {
        // Arrange
        let sus = UIColor.init(hex: 16752762, alpha: 1.0)
        let lightSalmon = UIColor.init(hexString: "FFA07A")
        // Act
        // Assert
        XCTAssertEqual(sus, lightSalmon)
        XCTAssertNotNil(sus)
        XCTAssertNotNil(lightSalmon)
    }
    
    func testUIColorInit_WithHexString() {
        // Arrange
        let wrongColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        let threeDigits = UIColor.init(hexString: "F0F")
        let fourDigits = UIColor.init(hexString: "FC0C")
        let sixDigits = UIColor.init(hexString: "FF0000")
        let eightDigits = UIColor.init(hexString: "FF0000CC")
        let defaultState = UIColor.init(hexString: "FFF00000CCC")
        let errorState = UIColor.init(hexString: "what?")
        // Act
        // Assert
        XCTAssertNotNil(threeDigits)
        XCTAssertNotNil(fourDigits)
        XCTAssertNotNil(sixDigits)
        XCTAssertNotNil(eightDigits)
        XCTAssertEqual(wrongColor, defaultState)
        XCTAssertEqual(wrongColor, errorState)
    }
}
