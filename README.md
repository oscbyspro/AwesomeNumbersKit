# AwesomeNumbersKit

Large number arithmetic in Swift.

| Swift | iOS   | iPadOS | Mac Catalyst | macOS | tvOS  | watchOS |
|:-----:|:-----:|:------:|:------------:|:-----:|:-----:|:-------:|
| 5.7   | 13.0  | 13.0   | 13.0         | 10.15 | 13.0  | 6.0     |

[![Supported Language Version Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Foscbyspro%2FAwesomeNumbersKit%2Fbadge%3Ftype%3Dswift-versions&color=blue)](https://swiftpackageindex.com/oscbyspro/AwesomeNumbersKit) [![Supported Platforms Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Foscbyspro%2FAwesomeNumbersKit%2Fbadge%3Ftype%3Dplatforms&color=blue)](https://swiftpackageindex.com/oscbyspro/AwesomeNumbersKit)

## ANKFullWidth ([Sources](Sources/ANKFullWidthKit), [Tests](Tests/ANKFullWidthKitTests), [Benchmarks](Tests/ANKFullWidthKitBenchmarks))

A composable, large, fixed-width, two's complement, binary integer.

<table>
<tr>
    <td>:jigsaw:</td>
    <td>Composable</td>
</tr>
<tr>
    <td>:two_hearts:</td>
    <td>Two's Complement</td>
</tr>
<tr>
    <td>:european_castle:</td>
    <td>Fixed Width Integer</td>
</tr>
<tr>
    <td>:rocket:</td>
    <td>Fast Digit Arithmetic</td>
</tr>
</table>

```swift
typealias  ANKInt256 = ANKFullWidth< ANKInt128, ANKUInt128>
typealias ANKUInt256 = ANKFullWidth<ANKUInt128, ANKUInt128>
```

## ANKSigned ([Sources](Sources/ANKSignedKit), [Tests](Tests/ANKSignedKitTests), [Benchmarks](Tests/ANKSignedKitBenchmarks))

A decorative, width agnostic, sign-and-magnitude, numeric integer.

<table>
<tr>
    <td>:ribbon:</td>
    <td>Decorative</td>
</tr>
<tr>
    <td>:ringed_planet:</td>
    <td>Sign & Magnitude</td>
</tr>
<tr>
    <td>:100:</td>
    <td>Numeric</td>
</tr>
<tr>
    <td>:rocket:</td>
    <td>Fast Digit Arithmetic</td>
</tr>
</table>
