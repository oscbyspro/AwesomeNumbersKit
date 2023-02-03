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
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(stringLiteral source: String) {
        self.init(decoding: source, radix: nil)!
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent public var description: String {
        String(encoding: self)
    }
    
    @inlinable public var debugDescription: String {
        let signedness = !Self.isSigned ? "U" : ""
        let size = String(Self.bitWidth)
        let contents = self.lazy.map(String.init).joined(separator: ", ")
        return "ANK\(signedness)Int\(size)(\(contents))"
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Text x Big Endian Text Codable
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
        Magnitude._encode(ANKSigned(source.magnitude, as: ANKSign(source.isLessThanZero)), radix: radix, uppercase: uppercase)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Decode
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static func _decodeBigEndianDigits(_ source: some StringProtocol, radix: Int) -> Self? {
        precondition(2 <= radix && radix <= 36)
        //=--------------------------------------=
        if  radix.isPowerOf2 {
            return self._decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsPowerOf2(source, radix: radix)
        }
        //=--------------------------------------=
        return  self._decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsNotPowerOf2(source, radix: radix)
    }
    
    @inlinable static func _decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsNotPowerOf2(_ source: some StringProtocol, radix: Int) -> Self? {
        let utf8 = source.utf8
        let root = UInt.maxPlusOneRootReportingUnderestimatedPowerOrZero(radix)
        assert(!root.power.isZero, "radix must not be power of 2")
        //=--------------------------------------=
        var magnitude: Magnitude = Self()
        var chunkStartIndex: String.Index = utf8.startIndex
        let chunkIndexAlignment: Int = utf8.count % root.exponent
        //=--------------------------------------=
        forwards: if !chunkIndexAlignment.isZero {
            //=----------------------------------=
            let chunkEndIndex = utf8.index(chunkStartIndex, offsetBy:  chunkIndexAlignment)
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
    
    @inlinable static func _decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsPowerOf2(_ source: some StringProtocol, radix: Int) -> Self? {
        let utf8 = source.utf8
        let root = UInt.maxPlusOneRootReportingUnderestimatedPowerOrZero(radix)
        assert(root.power.isZero, "radix must be power of 2")
        //=--------------------------------------=
        var magnitude: Magnitude = Self()
        //=--------------------------------------=
        let success = magnitude.withUnsafeMutableWordsPointer { MAGNITUDE in
            //=----------------------------------=
            var chunkEndIndex  = utf8.endIndex
            var magnitudeIndex = MAGNITUDE.startIndex
            //=----------------------------------=
            backwards: while chunkEndIndex != utf8.startIndex {
                //=------------------------------=
                if  magnitudeIndex == MAGNITUDE.endIndex {
                    return source.prefix(upTo: chunkEndIndex).utf8.allSatisfy({ $0 == UInt8(ascii: "0") })
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
    
    @_transparent @usableFromInline static func _encode(_ value: ANKSigned<Self>, radix: Int, uppercase: Bool) -> String {
        precondition(2 <= radix && radix <= 36)
        //=--------------------------------------=
        if  radix.isPowerOf2 {
            return self._encodeWhereRadixIsIn2Through36AndRadixIsPowerOf2(value, radix: radix, uppercase: uppercase)
        }
        //=--------------------------------------=
        return  self._encodeWhereRadixIsIn2Through36AndRadixIsNotPowerOf2(value, radix: radix, uppercase: uppercase)
    }
    
    @inlinable static func _encodeWhereRadixIsIn2Through36AndRadixIsPowerOf2(_ value: ANKSigned<Self>, radix: Int, uppercase: Bool) -> String {
        let magnitude_ = value.magnitude.minWordCountReportingIsZeroOrMinusOne()
        if  magnitude_.isZeroOrMinusOne { return "0" }
        //=--------------------------------------=
        let root = UInt.maxPlusOneRootReportingUnderestimatedPowerOrZero(radix)
        assert(root.power.isZero, "radix must be power of 2")
        //=--------------------------------------=
        var text = value.sign != .plus ? "-" : ""
        text.reserveCapacity(text.utf8.count + magnitude_.minWordCount * root.exponent)
        //=--------------------------------------=
        value.magnitude.withUnsafeWordsPointer { MAGNITUDE in
            //=----------------------------------=
            var index = MAGNITUDE.index(before: magnitude_.minWordCount)
            text += String(MAGNITUDE[index], radix: radix, uppercase: uppercase)
            //=----------------------------------=
            backwards: while index != MAGNITUDE.startIndex {
                MAGNITUDE.formIndex(before: &index)
                let digits  = String(MAGNITUDE[index], radix: radix, uppercase: uppercase)
                let padding = root.exponent &- digits.utf8.count
                if !padding.isZero { text += repeatElement("0", count: padding) }
                text += digits
            }
        }
        //=--------------------------------------=
        return text
    }
    
    @inlinable static func _encodeWhereRadixIsIn2Through36AndRadixIsNotPowerOf2(_ value: ANKSigned<Self>, radix: Int, uppercase: Bool) -> String {
        let magnitudeLeadingZeroBitCount = value.magnitude.leadingZeroBitCount
        if  magnitudeLeadingZeroBitCount == Self.bitWidth { return "0" }
        //=--------------------------------------=
        let root = UInt.maxPlusOneRootReportingUnderestimatedPowerOrZero(radix)
        assert(!root.power.isZero, "radix must not be power of 2")
        //=--------------------------------------=
        var magnitude = value.magnitude
        let magnitudeSignificantBitWidth: Int = magnitude .bitWidth &- magnitudeLeadingZeroBitCount
        let chunkBitWidthConsumptionLowerBound: Int = UInt.bitWidth &- root.power.leadingZeroBitCount &- 1
        let chunkCountUpperBound: Int = magnitudeSignificantBitWidth / chunkBitWidthConsumptionLowerBound &+ 1
        //=--------------------------------------=
        var text = value.sign != .plus ? "-" : ""
        text.reserveCapacity(text.utf8.count + root.exponent * chunkCountUpperBound)
        //=--------------------------------------=
        withUnsafeTemporaryAllocation(of: UInt.self, capacity: chunkCountUpperBound) { CHUNKS in
            //=----------------------------------=
            var index = CHUNKS.startIndex
            //=----------------------------------=
            assert(!magnitude.isZero)
            forwards: repeat {
                (magnitude, CHUNKS[index]) = magnitude.quotientAndRemainder(dividingBy: root.power)
                CHUNKS.formIndex(after: &index)
            } while !magnitude.isZero
            //=----------------------------------=
            CHUNKS.formIndex(before: &index)
            text += String(CHUNKS[index], radix: radix, uppercase: uppercase)
            //=----------------------------------=
            backwards: while index != CHUNKS.startIndex {
                CHUNKS.formIndex(before:  &index)
                let digits  = String(CHUNKS[index], radix: radix, uppercase: uppercase)
                let padding = root.exponent &- digits.utf8.count
                if !padding.isZero { text += repeatElement("0", count: padding) }
                text += digits
            }
        }
        //=--------------------------------------=
        return text
    }
}
