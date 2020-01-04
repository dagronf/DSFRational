//
//  DSFRational.swift
//
//  Copyright © 2020 Darren Ford. All rights reserved.
//
//  MIT license
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial
//  portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
//  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation

/// Representation of a deconstructed `BinaryFloatingPoint` value into its rational components
@objc public protocol RationalRepresentation: class {
	@objc var fraction: Double { get }
	@objc var whole: Int { get }
	@objc var numerator: UInt { get }
	@objc var denominator: UInt { get }
	@objc var description: String { get }
}

// MARK: - Objective-C compatible functions

@objc public class DSFRational: NSObject {

	/// Convert a fractional value (eg. 44.25) to numerator/denominators (44 1/4)
	/// - Parameter fraction: The fractional value to convert to rational values
	///
	/// Example:
	///
	/// *Swift*
	/// ```
	/// let check = DSFRational.value(for: 11.112)
	/// ```
	/// *Objective-C*
	/// ```
	/// id<RationalRepresentation> result = [DSFRational value: 11.112];
	/// assert([[result description] isEqual: @"-11 14/125"]);
	/// ```
	@objc static func value(for fraction: Double) -> RationalRepresentation {
		return fraction.rationalValue
	}

	/// Convert a fractional value (eg. 44.25) to numerator/denominators (44 1/4)
	/// - Parameter fraction: The fractional value to convert to rational values
	/// - Parameter maxDenominator: The maximum denominator to check to
	///
	/// Example:
	///
	/// *Swift*
	/// ```
	/// let check = Rational.value(for: 11.112, maxDenominator: 100000)
	/// ```
	/// *Objective-C*
	/// ```
	/// id<RationalRepresentation> result = [Rational value: 11.112 maxDenominator: 100000];
	/// assert([[result description] isEqual: @"-11 14/125"]);
	/// ```
	@objc static func value(for fraction: Double, maxDenominator: Int) -> RationalRepresentation {
		return fraction.rational(maxDenominator: maxDenominator)
	}
}

// MARK: - Swift support

extension BinaryFloatingPoint {

	/// Simple convenience var for rational value with a default max denominator
	public var rationalValue: RationalRepresentation {
		return self.rational()
	}

	/// Convert a fractional value (eg. 44.25) to numerator/denominators (44 1/4)
	/// - Parameter fraction: The fractional value to convert to rational values
	/// - Parameter maxDenominator: The maximum denominator to check to
	///
	/// Here is an algorithm for converting a value to the closest fraction
	/// (given a maximum value for the denominator). It is based on Farey Sequences.
	///
	/// It is probably much faster than finding GCDs and the results are much more useful.
	///
	/// For example, using the suggestions above, .333333 will be converted
	/// to 333333/1000000, which is probably not what you want. Using this algorithm,
	/// you will get 1/3.
	///
	/// [Original post](http://www.gamedev.net/topic/354209-how-do-i-convert-a-decimal-to-a-fraction-in-c/)
	public func rational(maxDenominator: Int = 1000000) -> RationalRepresentation {
		var low_n: UInt = 0
		var low_d: UInt = 1
		var high_n: UInt = 1
		var high_d: UInt = 1
		var mid_n: UInt = 0
		var mid_d: UInt = 0

		var numerator: UInt = 0
		var denominator: UInt = 0

		var whole: Int = 0
		var value = self

		if abs(value) >= 1 {
			whole = Int(value)
			value = abs(self) - Self(labs(whole))
		}

		repeat {
			mid_n = low_n + high_n
			mid_d = low_d + high_d
			if Self(mid_n) < value * Self(mid_d) {
				low_n = mid_n
				low_d = mid_d
				numerator = high_n
				denominator = high_d
			}
			else {
				high_n = mid_n
				high_d = mid_d
				numerator = low_n
				denominator = low_d
			}
		}
			while (mid_d <= maxDenominator)
		return RationalRepresentationResult(fraction: Double(self), whole: whole, numerator: numerator, denominator: denominator)
	}
}

/// Internal rational result type
private class RationalRepresentationResult: RationalRepresentation {
	public let fraction: Double
	public let whole: Int
	public let numerator: UInt
	public let denominator: UInt
	public var description: String {
		if abs(self.whole) > 0 {
			return "\(self.whole) \(self.numerator)/\(self.denominator)"
		}
		else {
			return "\(self.numerator)/\(self.denominator)"
		}
	}

	fileprivate init(fraction: Double, whole: Int, numerator: UInt, denominator: UInt) {
		self.fraction = fraction
		self.whole = whole
		self.numerator = numerator
		self.denominator = denominator
	}
}
