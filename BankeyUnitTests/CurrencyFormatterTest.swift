//
//  CurrencyFormatterTest.swift
//  BankeyUnitTests
//
//  Created by Owais Kreifeh on 18/06/2022.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
    var formatter: CurrencyFormatter!;
    
    override func setUp() {
        super.setUp();
        formatter = CurrencyFormatter();
    }
    
    func testBreakDecimalIntoComponents() throws {
        let result = formatter.breakIntoDollarsAndCents(1234.56);
        XCTAssertEqual(result.0, "1,234")
        XCTAssertEqual(result.1, "56")
    }
    
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(123456.12345);
        let expected = "JOD 123,456.123";
        XCTAssertEqual(result, expected)
    }
    
    func testDollarsZeroFormatted() throws {
        let result = formatter.dollarsFormatted(0);
        let expected = "JOD 0.000";
        XCTAssertEqual(result, expected)

    }
    
}
