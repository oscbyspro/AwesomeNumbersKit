# ``ANKFullWidthKit``

A composable, large, fixed-width, two's complement, binary integer.

## Overview

``ANKFullWidth`` is a generic model for working with fixed-width integers larger than 64
bits. Its bit width is the combined bit width of its ``ANKFullWidth/High-swift.typealias``
and ``ANKFullWidth/Low-swift.typealias`` parts. In this way, you may construct any integer
size that is a multiple of `UInt.bitWidth`.

```swift
typealias  Int256 = ANKFullWidth< Int128, UInt128>
typealias UInt256 = ANKFullWidth<UInt128, UInt128>
```

#### Trivial UInt Collection

``ANKFullWidth`` models a `UInt` collection with inline storage. The bit widths of 
its ``ANKFullWidth/High-swift.typealias`` and ``ANKFullWidth/Low-swift.typealias`` 
parts must therefore be multiplies of `UInt.bitWidth`. This requirement makes it possible
to operate on its words directly. While ``ANKFullWidth`` conforms to the `Collection` 
protocol, the best way to access these words is by using the following methods — based on 
custom, endian-sensitive, pointers:

- ``ANKFullWidth/withUnsafeWords(_:)``
- ``ANKFullWidth/withUnsafeMutableWords(_:)``
- ``ANKFullWidth/fromUnsafeMutableWords(_:)``

#### Single Digit Arithmetic

Alongside its ordinary arithmetic operations, ``ANKFullWidth`` also offers single digit 
operations. These methods are more efficient, but they can only be used on operands that 
fit in a machine word. See the following for more details:

- ``ANKBinaryInteger``
- ``ANKFixedWidthInteger``
- ``ANKSignedInteger``
- ``ANKSignedFixedWidthInteger``
- ``ANKUnsignedInteger``
- ``ANKUnsignedFixedWidthInteger``

- Note: The `Digit` type is `Int` when `Self` is signed, and `UInt` otherwise.

## Topics

### Models

- ``ANKFullWidth``
- ``ANKUnsafeWordsPointer``
- ``ANKUnsafeMutableWordsPointer``

### Aliases

- ``Int128``
- ``Int192``
- ``Int256``
- ``Int384``
- ``Int512``
- ``Int1024``
- ``Int2048``
- ``Int4096``

- ``UInt128``
- ``UInt192``
- ``UInt256``
- ``UInt384``
- ``UInt512``
- ``UInt1024``
- ``UInt2048``
- ``UInt4096``
