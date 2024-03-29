# [AwesomeNumbersKit][ANK/D]

Large number arithmetic in Swift.

| Package | Swift | iOS  | iPadOS | Mac Catalyst | macOS | tvOS | watchOS |
|:-------:|:-----:|:----:|:------:|:------------:|:-----:|:----:|:-------:|
| 4.0.2   | 5.8   | 16.4 | 16.4   | 16.4         | 13.3  | 16.4 | 9.4     |

> [!IMPORTANT]
> The development of this project has moved over to [**Numberick**](https://github.com/oscbyspro/Numberick).

## ANKCoreKit ([Sources][COR/S], [Tests][COR/T], [Benchmarks][COR/B])

Models, protocols, extensions and utilities underpinning this package.

### Protocols

- [ANKBinaryInteger](Sources/ANKCoreKit/ANKBinaryInteger.swift)
- [ANKBitPatternConvertible](Sources/ANKCoreKit/ANKBitPatternConvertible.swift)
- [ANKCoreInteger](Sources/ANKCoreKit/ANKCoreInteger.swift)
- [ANKFixedWidthInteger](Sources/ANKCoreKit/ANKFixedWidthInteger.swift)
- [ANKSignedInteger](Sources/ANKCoreKit/ANKBinaryInteger.swift)
- [ANKUnsignedInteger](Sources/ANKCoreKit/ANKBinaryInteger.swift)

## [ANKFullWidthKit][FUL/D] ([Sources][FUL/S], [Tests][FUL/T], [Benchmarks][FUL/B])

A composable, large, fixed-width, two's complement, binary integer.

<table>
<tr><td>:jigsaw:</td><td>Composable</td></tr>
<tr><td>:two_hearts:</td><td>Two's Complement</td></tr>
<tr><td>:european_castle:</td><td>Fixed Width Integer</td></tr>
<tr><td>:book:</td><td>Trivial UInt Collection</td></tr>
<tr><td>:rocket:</td><td>Single Digit Arithmetic</td></tr>
</table>

```swift
typealias  Int256 = ANKFullWidth< Int128, UInt128>
typealias UInt256 = ANKFullWidth<UInt128, UInt128>
```

## [ANKSignedKit][SIG/D] ([Sources][SIG/S], [Tests][SIG/T], [Benchmarks][SIG/B])

A decorative, width agnostic, sign-and-magnitude, numeric integer.

<table>
<tr><td>:ribbon:</td><td>Decorative</td></tr>
<tr><td>:ringed_planet:</td><td>Sign & Magnitude</td></tr>
<tr><td>:100:</td><td>Numeric</td></tr>
<tr><td>:rocket:</td><td>Single Digit Arithmetic</td></tr>
</table>

```swift
typealias Magnitude = UInt
let min = ANKSigned(Magnitude.max, as: FloatingPointSign.minus)
let max = ANKSigned(Magnitude.max, as: FloatingPointSign.plus )
```

## Check out my other projects

[**Numberick**][Oscar/Numberick] is a more pragmatic solution to the same problem.

<!-- Links -->

[Oscar/Numberick]: https://github.com/oscbyspro/Numberick

[ANK/D]: https://oscbyspro.github.io/AwesomeNumbersKit/documentation/awesomenumberskit
[FUL/D]: https://oscbyspro.github.io/AwesomeNumbersKit/documentation/awesomenumberskit/ankfullwidth
[SIG/D]: https://oscbyspro.github.io/AwesomeNumbersKit/documentation/awesomenumberskit/anksigned

[COR/S]: Sources/ANKCoreKit
[FUL/S]: Sources/ANKFullWidthKit
[SIG/S]: Sources/ANKSignedKit

[COR/T]: Tests/ANKCoreKitTests
[FUL/T]: Tests/ANKFullWidthKitTests
[SIG/T]: Tests/ANKSignedKitTests

[COR/B]: Tests/ANKCoreKitBenchmarks
[FUL/B]: Tests/ANKFullWidthKitBenchmarks
[SIG/B]: Tests/ANKSignedKitBenchmarks
