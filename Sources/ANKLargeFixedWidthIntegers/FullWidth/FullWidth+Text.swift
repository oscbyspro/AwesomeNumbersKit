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
    
    @inlinable static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) -> Self? {
        var bigEndianText = source[...]
        let sign: ANKSign = bigEndianText.removeSignPrefix() ?? ANKSign.plus
        let radix: Int = radix ?? bigEndianText.removeRadixLiteralPrefix() ?? 10
        let magnitude: Magnitude? = Magnitude._decodeBigEndianDigits(bigEndianText, radix: radix)
        //=--------------------------------------=
        guard let magnitude else { return nil }
        let isLessThanZero: Bool = sign == .minus && !magnitude.isZero
        //=--------------------------------------=
        var instance = Self(bitPattern: magnitude)
        if isLessThanZero {  instance.formTwosComplement()  }
        if isLessThanZero != instance.isLessThanZero { return nil }
        return instance
    }
    
    @inlinable static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool = false) -> String {
        var bigEndianText: String = source.isLessThanZero ? "-" : ""
        Magnitude._encode(source.magnitude, radix: radix, uppercase: uppercase, to: &bigEndianText)
        return bigEndianText
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High: AwesomeUnsignedLargeFixedWidthInteger<UInt> {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) -> Self? {
        var bigEndianText = source[...]
        let sign: ANKSign = bigEndianText.removeSignPrefix() ?? ANKSign.plus
        let radix: Int = radix ?? bigEndianText.removeRadixLiteralPrefix() ?? 10
        let magnitude: Self? = Self._decodeBigEndianDigits(bigEndianText, radix: radix)
        guard let magnitude else { return nil }
        guard sign == .plus || magnitude.isZero else { return nil }
        return magnitude
    }
    
    @inlinable static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool = false) -> String {
        var bigEndianText = String()
        Self._encode(source, radix: radix, uppercase: uppercase, to: &bigEndianText)
        return bigEndianText
    }
    
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
        var index = utf8.startIndex
        //=--------------------------------------=
        forwards: if !alignment.isZero {
            let endIndex = utf8.index(index, offsetBy: alignment)
            guard let digit = UInt(source[index ..< endIndex], radix: radix) else { return nil }
            index = endIndex
            magnitude += digit
        }
        //=--------------------------------------=
        forwards: while index != utf8.endIndex {
            let endIndex = utf8.index(index, offsetBy: root.exponent)
            guard let digit = UInt(source[index ..< endIndex], radix: radix) else { return nil }
            index = endIndex
            magnitude *= root.power
            magnitude += digit
        }
        //=--------------------------------------=
        return magnitude
    }
    
    @inlinable static func _decodeBigEndianDigitsWhereRadixIsPowerOf2(_ source: some StringProtocol, radix: Int) -> Self? {
        precondition(2 <= radix && radix <= 36)
        //=--------------------------------------=
        let utf8 = source.utf8
        let root = UInt.root(radix)
        let alignment = utf8.count % root.exponent // still faster than bounds checking alternative
        //=--------------------------------------=
        var magnitude = Self()
        //=--------------------------------------=
        let success = magnitude.withUnsafeMutableWords { MAGNITUDE in
            var sourceIndex = utf8.endIndex
            var magnitudeIndex = MAGNITUDE.startIndex
            //=----------------------------------=
            backwards: if !alignment.isZero {
                assert(magnitudeIndex != MAGNITUDE.endIndex)
                
                let startIndex = utf8.index(sourceIndex, offsetBy: -alignment)
                guard let digit = UInt(source[startIndex ..< sourceIndex], radix: radix) else { return false }
                sourceIndex = startIndex
                
                MAGNITUDE[magnitudeIndex] = digit
                MAGNITUDE.formIndex(after: &magnitudeIndex)
            }
            //=----------------------------------=
            backwards: while sourceIndex != utf8.startIndex {
                #warning("TODO: consider case with many zeros")
                guard magnitudeIndex != MAGNITUDE.endIndex else { return false }
                
                let startIndex = utf8.index(sourceIndex, offsetBy: -root.exponent) // negation is optimizable
                guard  let digit = UInt(source[startIndex ..< sourceIndex], radix: radix) else { return false }
                sourceIndex = startIndex
                
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
        if magnitude.isZero { return text += "0" }
        //=--------------------------------------=
        var (magnitude) = magnitude
        let (exponent, power) = UInt.root(radix)
        //=--------------------------------------=
        let length = magnitude.bitWidth - magnitude.leadingZeroBitCount
        let consumption = UInt.bitWidth - power.leadingZeroBitCount - 1
        let chunks = length / consumption + 1 // is overestimated count
        //=--------------------------------------=
        text.reserveCapacity(text.utf8.count + chunks * exponent)
        withUnsafeTemporaryAllocation(of: UInt.self, capacity: chunks) { CHUNKS in
            //=----------------------------------=
            var index = CHUNKS.startIndex
            while !magnitude.isZero {
                (magnitude, CHUNKS[index]) = magnitude.quotientAndRemainder(dividingBy: power)
                CHUNKS.formIndex(after: &index)
            }
            //=----------------------------------=
            CHUNKS.formIndex(before: &index)
            text += String(CHUNKS[index], radix: radix, uppercase: uppercase)
            //=----------------------------------=
            backwards: while index != CHUNKS.startIndex {
                CHUNKS.formIndex(before:  &index)
                let digits = String(CHUNKS[index], radix: radix, uppercase: uppercase)
                text += repeatElement("0", count:  exponent - digits.utf8.count)
                text += digits
            }
        }
    }
    
    @inlinable static func _encodeWhereRadixIsPowerOf2(_ magnitude: Self, radix: Int, uppercase: Bool, to text: inout String) {
        assert(!Self.isSigned)
        precondition(02 <= radix && radix <= 36)
        //=--------------------------------------=
        let _magnitude = magnitude.minWordCountReportingIsZeroOrMinusOne()
        if  _magnitude.isZeroOrMinusOne { text += "0"; return }
        //=--------------------------------------=
        let exponent = UInt.root(radix).exponent
        //=--------------------------------------=
        text.reserveCapacity(text.utf8.count + _magnitude.minWordCount * exponent)
        magnitude.withUnsafeWords { MAGNITUDE in
            //=----------------------------------=
            var index = MAGNITUDE.index(before: _magnitude.minWordCount)
            text += String(MAGNITUDE[index], radix: radix, uppercase: uppercase)
            //=----------------------------------=
            while index != MAGNITUDE.startIndex {
                MAGNITUDE.formIndex(before: &index)
                let digits = String(MAGNITUDE[index], radix: radix, uppercase: uppercase)
                text += repeatElement("0", count: exponent - digits.utf8.count)
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
