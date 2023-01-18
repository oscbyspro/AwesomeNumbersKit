# AwesomeNumbersKit

Large number arithmetic in Swift.

| Swift | iOS   | iPadOS | Mac Catalyst | macOS | tvOS  | watchOS |
|:-----:|:-----:|:------:|:------------:|:-----:|:-----:|:-------:|
| 5.7   | 13.0  | 13.0   | 13.0         | 10.15 | 13.0  | 6.0     |

## ANKFullWidth ([Sources](Sources/ANKFullWidthKit), [Tests](Tests/ANKFullWidthKitTests), [Benchmarks](Tests/ANKFullWidthKitBenchmarks))

👨‍💻🛠️🚧🧱🧱🏗️🧱🧱🚧⏳

A composable, large, fixed-width, two's complement, binary integer.

<table>
<tr>
    <td>:jigsaw:</td>
    <td>Composable</a></td>
</tr>
<tr>
    <td>:two_hearts:</td>
    <td>Two's Complement</a></td>
</tr>
<tr>
    <td>:european_castle:</td>
    <td>Fixed Width Integer</a></td>
</tr>
</table>

```swift
typealias  ANKInt256 = ANKFullWidth< ANKInt128, ANKUInt128>
typealias ANKUInt256 = ANKFullWidth<ANKUInt128, ANKUInt128>
```

## ANKSigned ([Sources](Sources/ANKSignedKit), [Tests](Tests/ANKSignedKitTests), [Benchmarks](Tests/ANKSignedKitBenchmarks))

👨‍💻🛠️🚧🧱🧱🏗️🧱🧱🚧⏳

A decorative, width agnostic, pen-and-paper-sign-magnitude, numeric integer.

<table>
<tr>
    <td>:ribbon:</td>
    <td>Decorative</a></td>
</tr>
<tr>
    <td>:ringed_planet:</td>
    <td>Sign & Magnitude</a></td>
</tr>
<tr>
    <td>:100:</td>
    <td>Numeric</a></td>
</tr>
</table>
