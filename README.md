# [AwesomeNumbersKit][MAIN/D]

Large number arithmetic in Swift.

| Package | Swift | iOS  | iPadOS | Mac Catalyst | macOS | tvOS | watchOS |
|:-------:|:-----:|:----:|:------:|:------------:|:-----:|:----:|:-------:|
| 0.6.2   | 5.7   | 13.0 | 13.0   | 13.0         | 10.15 | 13.0 | 6.0     |
| 2.2.0   | 5.8   | 16.4 | 16.4   | 16.4         | 13.3  | 16.4 | 9.4     |

## [ANKFullWidthKit][FULL/D] ([Sources][FULL/S], [Tests][FULL/T], [Benchmarks][FULL/B])

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

## [ANKSignedKit][SIGN/D] ([Sources][SIGN/S], [Tests][SIGN/T], [Benchmarks][SIGN/B])

A decorative, width agnostic, sign-and-magnitude, numeric integer.

<table>
<tr><td>:ribbon:</td><td>Decorative</td></tr>
<tr><td>:ringed_planet:</td><td>Sign & Magnitude</td></tr>
<tr><td>:100:</td><td>Numeric</td></tr>
<tr><td>:rocket:</td><td>Single Digit Arithmetic</td></tr>
</table>

```swift
typealias Magnitude = UInt
let min = ANKSigned(Magnitude.max, as: ANKSign.minus)
let max = ANKSigned(Magnitude.max, as: ANKSign.plus )
```

## ANKCoreKit ([Sources][CORE/S], [Tests][CORE/T], [Benchmarks][CORE/B])

Models, protocols, extensions and utilities underpinning this package.

### Models

- [ANKError](Sources/ANKCoreKit/Models/ANKError.swift)
- [ANKSign](Sources/ANKCoreKit/Models/ANKSign.swift)
- [ANKSigned\<Magnitude\>](Sources/ANKCoreKit/Models/ANKSigned.swift)

### Protocols

- [ANKBigEndianTextCodable](Sources/ANKCoreKit/ANKBigEndianTextCodable.swift)
- [ANKBinaryInteger](Sources/ANKCoreKit/ANKBinaryInteger.swift)
- [ANKBitPatternConvertible\<BitPattern\>](Sources/ANKCoreKit/ANKBitPatternConvertible.swift)
- [ANKCoreInteger\<Magnitude\>](Sources/ANKCoreKit/ANKCoreInteger.swift)
- [ANKFixedWidthInteger](Sources/ANKCoreKit/ANKFixedWidthInteger.swift)
- [ANKSignedInteger](Sources/ANKCoreKit/ANKBinaryInteger.swift)
- [ANKUnsignedInteger](Sources/ANKCoreKit/ANKBinaryInteger.swift)

## Check out my other projects

[**Numberick**][Oscar/Numberick] is a more pragmatic solution to the same problem.

<!-- Links -->

[Oscar/Numberick]: https://github.com/oscbyspro/Numberick

[MAIN/D]: https://oscbyspro.github.io/AwesomeNumbersKit/documentation/awesomenumberskit
[FULL/D]: https://oscbyspro.github.io/AwesomeNumbersKit/documentation/awesomenumberskit/ankfullwidth
[SIGN/D]: https://oscbyspro.github.io/AwesomeNumbersKit/documentation/awesomenumberskit/anksigned

[CORE/S]: Sources/ANKCoreKit
[FULL/S]: Sources/ANKFullWidthKit
[SIGN/S]: Sources/ANKSignedKit

[CORE/T]: Tests/ANKCoreKitTests
[FULL/T]: Tests/ANKFullWidthKitTests
[SIGN/T]: Tests/ANKSignedKitTests

[CORE/B]: Tests/ANKCoreKitBenchmarks
[FULL/B]: Tests/ANKFullWidthKitBenchmarks
[SIGN/B]: Tests/ANKSignedKitBenchmarks
