# [AwesomeNumbersKit][ANK/D]

Large number arithmetic in Swift.

| Package | Swift | iOS  | iPadOS | Mac Catalyst | macOS | tvOS | watchOS |
|:-------:|:-----:|:----:|:------:|:------------:|:-----:|:----:|:-------:|
| 0.6.2   | 5.7   | 13.0 | 13.0   | 13.0         | 10.15 | 13.0 | 6.0     |
| 1.0.0   | 5.8   | 16.4 | 16.4   | 16.4         | 13.3  | 16.4 | 9.4     |

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
typealias  Int256 = FullWidth< Int128, UInt128>
typealias UInt256 = FullWidth<UInt128, UInt128>
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
let min = Signed(Magnitude.max, as: Sign.minus)
let max = Signed(Magnitude.max, as: Sign.plus )
```

## ANKFoundation ([Sources][FDN/S], [Tests][FDN/T], [Benchmarks][FDN/B])

Models, protocols, extensions and utilities underpinning this package.

### Models

- [ANKError](Sources/ANKFoundation/Models/ANKError.swift)
- [ANKSign](Sources/ANKFoundation/Models/ANKSign.swift)
- [ANKSigned\<Magnitude\>](Sources/ANKFoundation/Models/ANKSigned.swift)

### Protocols

- [ANKBigEndianTextCodable](Sources/ANKFoundation/ANKBigEndianTextCodable.swift)
- [ANKBinaryInteger](Sources/ANKFoundation/ANKBinaryInteger.swift)
- [ANKBitPatternConvertible\<BitPattern\>](Sources/ANKFoundation/ANKBitPatternConvertible.swift)
- [ANKContiguousBytes](Sources/ANKFoundation/ANKContiguousBytes.swift)
- [ANKCoreInteger](Sources/ANKFoundation/ANKCoreInteger.swift)
- [ANKFixedWidthInteger](Sources/ANKFoundation/ANKFixedWidthInteger.swift)
- [ANKIntOrUInt](Sources/ANKFoundation/ANKIntOrUInt.swift)
- [ANKLargeBinaryInteger\<Digit\>](Sources/ANKFoundation/ANKLargeBinaryInteger.swift)
- [ANKLargeFixedWidthInteger\<Digit\>](Sources/ANKFoundation/ANKLargeFixedWidthInteger.swift)
- [ANKMutableContiguousBytes](Sources/ANKFoundation/ANKContiguousBytes.swift)
- [ANKSignedFixedWidthInteger](Sources/ANKFoundation/ANKFixedWidthInteger.swift)
- [ANKSignedInteger](Sources/ANKFoundation/ANKBinaryInteger.swift)
- [ANKSignedLargeBinaryInteger\<Digit\>](Sources/ANKFoundation/ANKLargeBinaryInteger.swift)
- [ANKSignedLargeFixedWidthInteger\<Digit\>](Sources/ANKFoundation/ANKLargeFixedWidthInteger.swift)
- [ANKTrivialContiguousBytes](Sources/ANKFoundation/ANKContiguousBytes.swift)
- [ANKUnsignedFixedWidthInteger](Sources/ANKFoundation/ANKFixedWidthInteger.swift)
- [ANKUnsignedInteger](Sources/ANKFoundation/ANKBinaryInteger.swift)
- [ANKUnsignedLargeBinaryInteger\<Digit\>](Sources/ANKFoundation/ANKLargeBinaryInteger.swift)
- [ANKUnsignedLargeFixedWidthInteger\<Digit\>](Sources/ANKFoundation/ANKLargeFixedWidthInteger.swift)
- [ANKWords](Sources/ANKFoundation/ANKWords.swift)

<!-- Links -->

[ANK/D]: https://oscbyspro.github.io/AwesomeNumbersKit/documentation/awesomenumberskit
[FUL/D]: https://oscbyspro.github.io/AwesomeNumbersKit/documentation/awesomenumberskit/ankfullwidth
[SIG/D]: https://oscbyspro.github.io/AwesomeNumbersKit/documentation/awesomenumberskit/anksigned

[FDN/S]: Sources/ANKFoundation
[FUL/S]: Sources/ANKFullWidthKit
[SIG/S]: Sources/ANKSignedKit

[FDN/T]: Tests/ANKFoundationTests
[FUL/T]: Tests/ANKFullWidthKitTests
[SIG/T]: Tests/ANKSignedKitTests

[FDN/B]: Tests/ANKFoundationBenchmarks
[FUL/B]: Tests/ANKFullWidthKitBenchmarks
[SIG/B]: Tests/ANKSignedKitBenchmarks
