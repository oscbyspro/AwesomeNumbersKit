# AwesomeNumbersKit

Large number arithmetic in Swift.

| Swift | iOS   | iPadOS | Mac Catalyst | macOS | tvOS  | watchOS |
|:-----:|:-----:|:------:|:------------:|:-----:|:-----:|:-------:|
| 5.7   | 13.0  | 13.0   | 13.0         | 10.15 | 13.0  | 6.0     |

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
