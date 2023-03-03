# [AwesomeNumbersKit](https://oscbyspro.github.io/AwesomeNumbersKit/documentation/awesomenumberskit)

Large number arithmetic in Swift.

| Swift | iOS   | iPadOS | Mac Catalyst | macOS | tvOS  | watchOS |
|:-----:|:-----:|:------:|:------------:|:-----:|:-----:|:-------:|
| 5.7   | 13.0  | 13.0   | 13.0         | 10.15 | 13.0  | 6.0     |

## ANKFullWidthKit ([Sources](Sources/ANKFullWidthKit), [Tests](Tests/ANKFullWidthKitTests), [Benchmarks](Tests/ANKFullWidthKitBenchmarks))

A composable, large, fixed-width, two's complement, binary integer.

<table>
<tr><td>:jigsaw:</td><td>Composable</td></tr>
<tr><td>:two_hearts:</td><td>Two's Complement</td></tr>
<tr><td>:european_castle:</td><td>Fixed Width Integer</td></tr>
<tr><td>:rocket:</td><td>Single Digit Arithmetic</td></tr>
</table>

```swift
typealias  Int256 = ANKFullWidth< Int128, UInt128>
typealias UInt256 = ANKFullWidth<UInt128, UInt128>
```

## ANKSignedKit ([Sources](Sources/ANKSignedKit), [Tests](Tests/ANKSignedKitTests), [Benchmarks](Tests/ANKSignedKitBenchmarks))

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

## ANKFoundation ([Sources](Sources/ANKFoundation), [Tests](Tests/ANKFoundationTests), [Benchmarks](Tests/ANKFoundationBenchmarks))

Models, protocols, extensions and utilities underpinning this package.

### Models

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
