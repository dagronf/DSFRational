import XCTest
@testable import DSFRational

final class RationalTests: XCTestCase {
	func testRationals() {
		let third = 0.333333333.rational()
		XCTAssertEqual(third.fraction, 0.333333333)
		XCTAssertEqual(third.description, "1/3")
		XCTAssertEqual(third.whole, 0)
		XCTAssertEqual(third.numerator, 1)
		XCTAssertEqual(third.denominator, 3)

		let quarterv: CGFloat = 4.25
		let quarter = quarterv.rationalValue
		XCTAssertEqual(quarter.fraction, 4.25)
		XCTAssertEqual(quarter.description, "4 1/4")
		XCTAssertEqual(quarter.whole, 4)
		XCTAssertEqual(quarter.numerator, 1)
		XCTAssertEqual(quarter.denominator, 4)

		let fractionv: CGFloat = -3.1000999000
		let fraction = fractionv.rational()
		XCTAssertEqual(fraction.fraction, -3.1000999000)
		XCTAssertEqual(fraction.description, "-3 501/5005")
		XCTAssertEqual(fraction.whole, -3)
		XCTAssertEqual(fraction.numerator, 501)
		XCTAssertEqual(fraction.denominator, 5005)

		let value = -9.90
		let result = value.rationalValue
		XCTAssertEqual(result.fraction, -9.90)
		XCTAssertEqual(result.description, "-9 9/10")
		XCTAssertEqual(result.whole, -9)
		XCTAssertEqual(result.numerator, 9)
		XCTAssertEqual(result.denominator, 10)

		let check = DSFRational.value(for: 11.112)
		XCTAssertEqual(check.fraction, 11.112)
		XCTAssertEqual(check.description, "11 14/125")
		XCTAssertEqual(check.whole, 11)
		XCTAssertEqual(check.numerator, 14)
		XCTAssertEqual(check.denominator, 125)

//		Objective-C test code
//		id<RationalRepresentation> result = [DSFRational valueFor:-15.5];
//		assert([[result description] isEqual:@"-15 1/2"]);
//		assert([result whole] == -15);
//		assert([result numerator] == 1);
//		assert([result denominator] == 2);
//		assert([result fraction] == -15.5);

	}

	static var allTests = [
		("testRationals", testRationals),
	]
}
