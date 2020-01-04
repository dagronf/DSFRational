# Objective-C/Swift Rational class

An extension for floating point values to return the rational components for that value

<p align="center">
    <img src="https://img.shields.io/github/v/tag/dagronf/DSFRational" />
    <img src="https://img.shields.io/badge/macOS-10.9+-red" />
    <img src="https://img.shields.io/badge/iOS-11.0+-blue" />
    <img src="https://img.shields.io/badge/tvOS-11.0+-orange" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.0-orange.svg" />
    <img src="https://img.shields.io/badge/License-MIT-lightgrey" />
    <img src="https://img.shields.io/badge/pod-compatible-informational" alt="CocoaPods" />
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
    </a>
</p>

```swift
/// Swift example

let rational = -9.90.rationalValue
// result.fraction, -9.90)
// result.description, "-9 9/10")
// result.whole, -9)
// result.numerator, 9)
// result.denominator, 10)
```

```objective-c
/// Objective-C example

id<RationalRepresentation> result = [DSFRational valueFor:-11.112];
assert([[result description] isEqual:@"-11 14/125"]);
assert([result whole] == -11);
assert([result numerator] == 14);
assert([result denominator] == 125);
assert([result fraction] == -11.112);
```



## Notes

The algorithm arises from a comment on [GameDev.net](https://www.gamedev.net/) by user John Bolton.

> Here is an algorithm for converting a value to the closest fraction (given a maximum value for the denominator). It is based on Farey Sequences. It is probably much faster than finding GCDs and the results are much more useful. For example, using the suggestions above, .333333 will be converted to 333333/1000000, which is probably not what you want. Using this algorithm, you will get 1/3.

[Click here to see original post](https://www.gamedev.net/forums/topic/354209-how-do-i-convert-a-decimal-to-a-fraction-in-c/?do=findComment&comment=3321651)
