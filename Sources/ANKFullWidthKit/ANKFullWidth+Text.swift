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
        self.withUnsafeWords { SELF in
            let signedness = !Self.isSigned ? "U" : ""
            let size = String(Self.bitWidth)
            let body = SELF.lazy.map(String.init).joined(separator: ", ")
            return "ANK\(signedness)Int\(size)(\(body))"
        }
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
        let components = source._bigEndianTextComponents(radix: radix)
        guard let magnitude = Magnitude._decodeBigEndianDigits(components.body, radix: components.radix) else { return nil }
        return Self(exactly: ANKSigned(magnitude, as: components.sign))
    }
    
    @inlinable public static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool) -> String {
        let sign = ANKSign(source.isLessThanZero)
        let number = ANKSigned(source.magnitude, as: sign)
        return Magnitude._encodeBigEndianText(number, radix: radix, uppercase: uppercase)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Decode
    //=------------------------------------------------------------------------=
    
    @inlinable static func _decodeBigEndianDigits(_ source: some StringProtocol, radix: Int) -> Self? {
        precondition(2 ... 36 ~=  radix)
        let radix = RadixUIntRoot(radix)
        //=--------------------------------------=
        // Radix == 2, 4, 16
        //=--------------------------------------=
        if  radix.power.isZero {
            return self._decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsUIntRoot(source, radix: radix)
        }
        //=--------------------------------------=
        // Radix != 2, 4, 16
        //=--------------------------------------=
        return  self._decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsNotUIntRoot(source, radix: radix)
    }
    
    @inlinable static func _decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsUIntRoot(
    _ source: some StringProtocol, radix: RadixUIntRoot) -> Self? {
        assert(radix.power.isZero)
        //=--------------------------------------=
        let utf8 = source.utf8
        var magnitude: Magnitude = Self()
        //=--------------------------------------=
        let success = magnitude.withUnsafeMutableWords { MAGNITUDE in
            //=----------------------------------=
            var chunkEndIndex  = utf8.endIndex
            var magnitudeIndex = MAGNITUDE.startIndex
            //=----------------------------------=
            backwards: while chunkEndIndex != utf8.startIndex {
                //=------------------------------=
                if  magnitudeIndex == MAGNITUDE.endIndex {
                    let remainders =  source.prefix(upTo: chunkEndIndex).utf8
                    return remainders.allSatisfy({ $0 == UInt8(ascii: "0") })
                }
                //=------------------------------=
                let chunkStartIndex = utf8.index(chunkEndIndex, offsetBy: -radix.exponent, limitedBy: utf8.startIndex) ?? utf8.startIndex
                guard let  digit = UInt(source[chunkStartIndex ..< chunkEndIndex], radix: radix.base) else { return false }
                chunkEndIndex = chunkStartIndex
                //=------------------------------=
                MAGNITUDE[magnitudeIndex] = digit
                MAGNITUDE.formIndex(after: &magnitudeIndex)
            }
            //=----------------------------------=
            return true
        }
        //=--------------------------------------=
        return success ? magnitude : nil
    }
    
    @inlinable static func _decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsNotUIntRoot(
    _ source: some StringProtocol, radix: RadixUIntRoot) -> Self? {
        assert(!radix.power.isZero)
        //=--------------------------------------=
        let utf8 = source.utf8
        var chunkStartIndex: String.Index = utf8.startIndex
        let chunkIndexAlignment: Int = utf8.count % radix.exponent
        var magnitude: Magnitude = Self()
        //=--------------------------------------=
        forwards: if !chunkIndexAlignment.isZero {
            //=----------------------------------=
            let chunkEndIndex = utf8.index(chunkStartIndex, offsetBy: chunkIndexAlignment)
            guard let digit = UInt(source[chunkStartIndex ..< chunkEndIndex], radix: radix.base) else { return nil }
            chunkStartIndex = chunkEndIndex
            //=----------------------------------=
            magnitude[unchecked: Self.startIndex] = digit
        }
        //=--------------------------------------=
        forwards: while chunkStartIndex != utf8.endIndex {
            //=----------------------------------=
            let chunkEndIndex = utf8.index(chunkStartIndex, offsetBy: radix.exponent)
            guard let digit = UInt(source[chunkStartIndex ..< chunkEndIndex], radix: radix.base) else { return nil }
            chunkStartIndex = chunkEndIndex
            //=----------------------------------=
            guard !magnitude.multiplyReportingOverflow(by: radix.power as UInt) else { return nil }
            guard !magnitude.addReportingOverflow(digit as UInt) else { return nil }
        }
        //=--------------------------------------=
        return magnitude
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Encode
    //=------------------------------------------------------------------------=
    
    @inlinable static func _encodeBigEndianText(_ value: ANKSigned<Self>, radix: Int, uppercase: Bool) -> String {
        precondition(2 ... 36 ~=  radix)
        let radix = RadixUIntRoot(radix)
        //=--------------------------------------=
        // Radix == 2, 4, 16
        //=--------------------------------------=
        if  radix.power.isZero {
            return self._encodeBigEndianTextWhereRadixIsIn2Through36AndRadixIsUIntRoot(value, radix: radix, uppercase: uppercase)
        }
        //=--------------------------------------=
        // Radix != 2, 4, 16
        //=--------------------------------------=
        return  self._encodeBigEndianTextWhereRadixIsIn2Through36AndRadixIsNotUIntRoot(value, radix: radix, uppercase: uppercase)
    }
    
    @inlinable static func _encodeBigEndianTextWhereRadixIsIn2Through36AndRadixIsUIntRoot(
    _ value: ANKSigned<Self>, radix: RadixUIntRoot, uppercase: Bool) -> String {
        assert(radix.power.isZero)
        //=--------------------------------------=
        let magnitude_ = value.magnitude.minLastIndexReportingIsZeroOrMinusOne()
        if  magnitude_.isZeroOrMinusOne { return "0" }
        //=--------------------------------------=
        return value.magnitude.withUnsafeWords { MAGNITUDE in
            var index = magnitude_.minLastIndex
            //=----------------------------------=
            var text = value.sign != .plus ? "-" : ""
            text += String(MAGNITUDE[index], radix: radix.base, uppercase: uppercase)
            let size = text.utf8.count + radix.exponent * index
            text.reserveCapacity(size)
            //=----------------------------------=
            backwards: while index != MAGNITUDE.startIndex {
                MAGNITUDE.formIndex(before: &index)
                let digits  = String(MAGNITUDE[index], radix: radix.base, uppercase: uppercase)
                let padding = radix.exponent &- digits.utf8.count
                if !padding.isZero { text += repeatElement("0", count: padding) }
                text += digits
            }
            //=----------------------------------=
            assert(text.utf8.count == size)
            return text
        }
    }
    
    @inlinable static func _encodeBigEndianTextWhereRadixIsIn2Through36AndRadixIsNotUIntRoot(
    _ value: ANKSigned<Self>, radix: RadixUIntRoot, uppercase: Bool) -> String {
        assert(!radix.power.isZero)
        //=--------------------------------------=
        let magnitudeLeadingZeroBitCount = value.magnitude.leadingZeroBitCount
        if  magnitudeLeadingZeroBitCount == Magnitude.bitWidth { return "0" }
        //=--------------------------------------=
        var magnitude: Magnitude = value.magnitude
        let magnitudeSignificantBitWidth: Int = Magnitude .bitWidth &- magnitudeLeadingZeroBitCount
        let chunkBitWidthConsumptionLowerBound: Int = UInt.bitWidth &- radix.power.leadingZeroBitCount &- 1
        let chunkCountUpperBound = (magnitudeSignificantBitWidth / chunkBitWidthConsumptionLowerBound) &+ 1
        //=--------------------------------------=
        return withUnsafeTemporaryAllocation(of: UInt.self, capacity: chunkCountUpperBound) { CACHE in
            var index = CACHE.startIndex
            //=----------------------------------=
            assert(!magnitude.isZero)
            forwards: while true {
                let division = magnitude.quotientAndRemainder(dividingBy: radix.power as UInt)
                magnitude = division.quotient as Magnitude
                CACHE[index] = division.remainder  as UInt
                if  magnitude.isZero { break }
                CACHE.formIndex(after: &index)
            }
            //=----------------------------------=
            var text = value.sign != .plus ? "-" : ""
            text += String(CACHE[index], radix: radix.base, uppercase: uppercase)
            let size = text.utf8.count + radix.exponent * index
            text.reserveCapacity(size)
            //=----------------------------------=
            backwards: while index != CACHE.startIndex {
                CACHE.formIndex(before: &index)
                let digits  = String(CACHE[index], radix: radix.base, uppercase: uppercase)
                let padding = radix.exponent &- digits.utf8.count
                if !padding.isZero { text += repeatElement("0", count: padding) }
                text += digits
            }
            //=----------------------------------=
            assert(text.utf8.count == size)
            return text
        }
    }
}
