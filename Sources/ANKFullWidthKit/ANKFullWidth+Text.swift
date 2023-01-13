//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation

//*============================================================================*
// MARK: * ANK x Full Width x Text
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) -> Self? {
        var bigEndianText = source[...]
        let sign  = bigEndianText._removeSignPrefix() ?? ANKSign.plus
        let radix = radix ?? bigEndianText._removeRadixLiteralPrefix() ?? 10
        let magnitude = Magnitude._decodeBigEndianDigits(bigEndianText, radix: radix)
        guard  let magnitude else { return nil }
        return Self(exactly: ANKSigned(magnitude, as: sign))
    }
    
    @inlinable public static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool) -> String {
        var bigEndianText: String = source.isLessThanZero ? "-" : ""
        Magnitude._encode(source.magnitude, radix: radix, uppercase: uppercase, to: &bigEndianText)
        return bigEndianText
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High: ANKUnsignedLargeFixedWidthInteger<UInt> {
    
    //=------------------------------------------------------------------------=
    // MARK: Decode
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static func _decodeBigEndianDigits(
    _ source: some StringProtocol, radix: Int) -> Self? {
        precondition(2 <= radix && radix <= 36)
        //=--------------------------------------=
        // Fast, Radix Is Power Of 2
        //=--------------------------------------=
        if  radix.isPowerOf2 {
            return self._decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsPowerOf2(source, radix: radix)
        }
        //=--------------------------------------=
        // Slow, Radix Is * Not * Power Of 2
        //=--------------------------------------=
        return  self._decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsNotPowerOf2(source, radix: radix)
    }
    
    @inlinable static func _decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsNotPowerOf2(
    _ source: some StringProtocol, radix: Int) -> Self? {
        //=--------------------------------------=
        let utf8 = source.utf8
        let root = UInt.maxPlusOneRootReportingUnderestimatedPowerOrZero(radix)
        assert(!root.power.isZero, "radix must not be power of 2")
        //=--------------------------------------=
        var magnitude = Self()
        var chunkStartIndex = utf8.startIndex
        let alignment = utf8.count % root.exponent
        //=--------------------------------------=
        forwards: if !alignment.isZero {
            //=----------------------------------=
            let chunkEndIndex = utf8.index(chunkStartIndex, offsetBy: alignment)
            guard let digit = UInt(source[chunkStartIndex ..< chunkEndIndex], radix: radix) else { return nil }
            chunkStartIndex = chunkEndIndex
            //=----------------------------------=
            guard !magnitude.addReportingOverflow(digit as UInt) else { return nil }
        }
        //=--------------------------------------=
        forwards: while chunkStartIndex != utf8.endIndex {
            //=----------------------------------=
            let chunkEndIndex = utf8.index(chunkStartIndex, offsetBy: root.exponent)
            guard let digit = UInt(source[chunkStartIndex ..< chunkEndIndex], radix: radix) else { return nil }
            chunkStartIndex = chunkEndIndex
            //=----------------------------------=
            guard !magnitude.multiplyReportingOverflow(by: root.power as UInt) else { return nil }
            guard !magnitude.addReportingOverflow(digit as UInt) else { return nil }
        }
        //=--------------------------------------=
        return magnitude
    }
    
    @inlinable static func _decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsPowerOf2(
    _ source: some StringProtocol, radix: Int) -> Self? {
        //=--------------------------------------=
        let utf8 = source.utf8
        let root = UInt.maxPlusOneRootReportingUnderestimatedPowerOrZero(radix)
        assert(root.power.isZero, "radix must be power of 2")
        //=--------------------------------------=
        var magnitude = Self()
        //=--------------------------------------=
        let success = magnitude.withUnsafeMutableWordsPointer { MAGNITUDE in
            //=----------------------------------=
            var chunkEndIndex  = utf8.endIndex
            var magnitudeIndex = MAGNITUDE.startIndex
            //=----------------------------------=
            backwards: while chunkEndIndex != utf8.startIndex {
                //=------------------------------=
                if  magnitudeIndex == MAGNITUDE.endIndex {
                    return source[..<chunkEndIndex].allSatisfy({ $0 == "0" })
                }
                //=------------------------------=
                let chunkStartIndex = utf8.index(chunkEndIndex, offsetBy: -root.exponent, limitedBy: utf8.startIndex) ?? utf8.startIndex
                guard let digit = UInt(source[chunkStartIndex ..< chunkEndIndex], radix: radix) else { return false }
                //=------------------------------=
                chunkEndIndex = chunkStartIndex
                MAGNITUDE[magnitudeIndex] = digit
                MAGNITUDE.formIndex(after: &magnitudeIndex)
            }
            //=----------------------------------=
            return true
        }
        //=--------------------------------------=
        return success ? magnitude : nil
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Encode
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static func _encode(
    _ magnitude: Self, radix: Int, uppercase: Bool, to text: inout String) {
        precondition(2 <= radix && radix <= 36)
        //=--------------------------------------=
        // Fast, Radix Is Power Of 2
        //=--------------------------------------=
        if  radix.isPowerOf2 {
            return self._encodeWhereRadixIsIn2Through36AndRadixIsPowerOf2(magnitude, radix: radix, uppercase: uppercase, to: &text)
        }
        //=--------------------------------------=
        // Slow, Radix Is * Not * Power Of 2
        //=--------------------------------------=
        return  self._encodeWhereRadixIsIn2Through36AndRadixIsNotPowerOf2(magnitude, radix: radix, uppercase: uppercase, to: &text)
    }
    
    @inlinable static func _encodeWhereRadixIsIn2Through36AndRadixIsPowerOf2(
    _ magnitude: Self, radix: Int, uppercase: Bool, to text: inout String) {
        //=--------------------------------------=
        let magnitude_ = magnitude.minWordCountReportingIsZeroOrMinusOne()
        if  magnitude_.isZeroOrMinusOne { text += "0"; return }
        //=--------------------------------------=
        let root = UInt.maxPlusOneRootReportingUnderestimatedPowerOrZero(radix)
        assert(root.power.isZero, "radix must be power of 2")
        //=--------------------------------------=
        text.reserveCapacity(text.utf8.count + magnitude_.minWordCount * root.exponent)
        //=--------------------------------------=
        magnitude.withUnsafeWordsPointer { MAGNITUDE in
            //=----------------------------------=
            var index = MAGNITUDE.index(before: magnitude_.minWordCount)
            text += String(MAGNITUDE[index], radix: radix, uppercase: uppercase)
            //=----------------------------------=
            backwards: while index != MAGNITUDE.startIndex {
                MAGNITUDE.formIndex(before: &index)
                let digits = String(MAGNITUDE[index], radix: radix, uppercase: uppercase)
                text += repeatElement("0", count: root.exponent - digits.utf8.count)
                text += digits
            }
        }
    }
    
    @inlinable static func _encodeWhereRadixIsIn2Through36AndRadixIsNotPowerOf2(
    _ magnitude: Self, radix: Int, uppercase: Bool, to text: inout String) {
        //=--------------------------------------=
        let magnitudeLeadingZeroBitCount = magnitude.leadingZeroBitCount
        if  magnitudeLeadingZeroBitCount == Self.bitWidth { return text += "0" }
        //=--------------------------------------=
        var magnitude = magnitude
        let root = UInt.maxPlusOneRootReportingUnderestimatedPowerOrZero(radix)
        assert(!root.power.isZero, "radix must not be power of 2")
        //=--------------------------------------=
        let amount: Int = magnitude.bitWidth - magnitudeLeadingZeroBitCount
        let consumption: Int = UInt.bitWidth - root.power.leadingZeroBitCount &- 1
        let chunksCount: Int = 1 &+ (amount / consumption) // overestimated
        //=--------------------------------------=
        text.reserveCapacity(text.utf8.count + chunksCount * root.exponent)
        //=--------------------------------------=
        withUnsafeTemporaryAllocation(of: UInt.self, capacity: chunksCount) { CHUNKS in
            //=----------------------------------=
            var index = CHUNKS.startIndex
            //=----------------------------------=
            assert(!magnitude.isZero)
            forwards: repeat {
                let qr: QR<Self, UInt> = magnitude.quotientAndRemainder(dividingBy: root.power)
                (magnitude, CHUNKS[index]) = qr
                CHUNKS.formIndex(after: &index)
            } while !magnitude.isZero
            //=----------------------------------=
            CHUNKS.formIndex(before: &index)
            text += String(CHUNKS[index], radix: radix, uppercase: uppercase)
            //=----------------------------------=
            backwards: while index != CHUNKS.startIndex {
                CHUNKS.formIndex(before:  &index)
                let digits = String(CHUNKS[index], radix: radix, uppercase: uppercase)
                text += repeatElement("0", count:  root.exponent &- digits.utf8.count)
                text += digits
            }
        }
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Text x Literal
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(stringLiteral source: String) {
        self.init(decoding: source, radix: nil)!
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Text x Description
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var description: String {
        String(encoding: self)
    }
    
    @inlinable public var debugDescription: String {
        "\(Self.self)(\(self.lazy.map(String.init).joined(separator: ", ")))"
    }
}
