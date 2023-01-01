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
        let sign: ANKSign = bigEndianText.removeSignPrefix() ?? .plus
        let radix: Int = radix ?? bigEndianText.removeRadixLiteralPrefix() ?? 10
        let magnitude: Magnitude? = Magnitude._decodeBigEndianDigits(bigEndianText, radix: radix)
        //=--------------------------------------=
        guard let magnitude else { return nil }
        let isLessThanZero: Bool = sign == .minus && !magnitude.isZero
        var instance = Self(bitPattern: magnitude)
        //=--------------------------------------=
        if  isLessThanZero {
            instance.formTwosComplement()
        }
        //=--------------------------------------=
        return isLessThanZero != instance.isLessThanZero ? nil : instance
    }
    
    @inlinable public static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool = false) -> String {
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
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable static func _decodeBigEndianDigits(_ source: some StringProtocol, radix: Int) -> Self? {
        switch radix.nonzeroBitCount == 1 {
        case  true: return self._decodeBigEndianDigitsWhereRadixIsPowerOf2(source, radix: radix)
        case false: return self._decodeBigEndianDigitsWhereRadixIsWhatever(source, radix: radix) }
    }
    
    @inlinable static func _decodeBigEndianDigitsWhereRadixIsWhatever(_ source: some StringProtocol, radix: Int) -> Self? {
        precondition(2 <= radix && radix <= 36)
        //=--------------------------------------=
        let utf8 = source.utf8
        let root = UInt.root(radix)
        let alignment = utf8.count % root.exponent
        //=--------------------------------------=
        var magnitude = Self()
        var chunkStartIndex = utf8.startIndex
        //=--------------------------------------=
        forwards: if !alignment.isZero {
            //=----------------------------------=
            let chunkEndIndex = utf8.index(chunkStartIndex, offsetBy: alignment)
            guard let digit = UInt(source[chunkStartIndex ..< chunkEndIndex], radix: radix) else { return nil }
            chunkStartIndex = chunkEndIndex
            //=----------------------------------=
            magnitude += digit as UInt
        }
        //=--------------------------------------=
        forwards: while chunkStartIndex != utf8.endIndex {
            //=----------------------------------=
            let chunkEndIndex = utf8.index(chunkStartIndex, offsetBy: root.exponent)
            guard let digit = UInt(source[chunkStartIndex ..< chunkEndIndex], radix: radix) else { return nil }
            chunkStartIndex = chunkEndIndex
            //=----------------------------------=
            magnitude *= root.power as UInt
            magnitude += digit as UInt
        }
        //=--------------------------------------=
        return magnitude
    }
    
    @inlinable static func _decodeBigEndianDigitsWhereRadixIsPowerOf2(_ source: some StringProtocol, radix: Int) -> Self? {
        precondition(2 <= radix && radix <= 36)
        //=--------------------------------------=
        let utf8 = source.utf8
        let root = UInt.root(radix)
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
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func _encode(_ magnitude: Self, radix: Int, uppercase: Bool, to text: inout String) {
        switch radix.nonzeroBitCount == 1 {
        case  true: _encodeWhereRadixIsPowerOf2(magnitude, radix: radix, uppercase: uppercase, to: &text)
        case false: _encodeWhereRadixIsWhatever(magnitude, radix: radix, uppercase: uppercase, to: &text) }
    }
    
    @inlinable static func _encodeWhereRadixIsWhatever(_ magnitude: Self, radix: Int, uppercase: Bool, to text: inout String) {
        precondition(02 <= radix && radix <= 36)
        //=--------------------------------------=
        let magnitudeLeadingZeroBitCount = magnitude.leadingZeroBitCount
        if  magnitudeLeadingZeroBitCount == Self.bitWidth { return text += "0" }
        //=--------------------------------------=
        var magnitude = magnitude
        let root = UInt.root(radix)
        //=--------------------------------------=
        let amount: Int = magnitude.bitWidth - magnitudeLeadingZeroBitCount
        let consumption: Int = UInt.bitWidth - root.power.leadingZeroBitCount &- 1
        let chunks: Int = 1 &+ (amount / consumption) // >= count
        //=--------------------------------------=
        text.reserveCapacity(text.utf8.count + chunks * root.exponent)
        //=--------------------------------------=
        withUnsafeTemporaryAllocation(of: UInt.self, capacity: chunks) { CHUNKS in
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
    
    @inlinable static func _encodeWhereRadixIsPowerOf2(_ magnitude: Self, radix: Int, uppercase: Bool, to text: inout String) {
        precondition(02 <= radix && radix <= 36)
        //=--------------------------------------=
        let _magnitude = magnitude.minWordCountReportingIsZeroOrMinusOne()
        if  _magnitude.isZeroOrMinusOne { text += "0"; return }
        //=--------------------------------------=
        let root = UInt.root(radix)
        //=--------------------------------------=
        text.reserveCapacity(text.utf8.count + _magnitude.minWordCount * root.exponent)
        //=--------------------------------------=
        magnitude.withUnsafeWordsPointer { MAGNITUDE in
            //=----------------------------------=
            var index = MAGNITUDE.index(before: _magnitude.minWordCount)
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
}

//*============================================================================*
// MARK: * ANK x Full Width x Text x Description
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var debugDescription: String {
        "\(Self.self)(\(self.lazy.map(String.init).joined(separator: ", ")))"
    }
}
