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
    
    /// The name of this type.
    ///
    /// ```swift
    /// FullWidth< Int128, UInt128>.description //  "Int256"
    /// FullWidth<UInt256, UInt256>.description // "UInt512"
    /// ```
    ///
    @inlinable static var name: String {
        let signedness = !Self.isSigned ? "U" : ""
        let size = String(Self.bitWidth)
        return "ANK\(signedness)Int\(size)"
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent public var description: String {
        String(encoding: self)
    }
    
    @inlinable public var debugDescription: String {
        self.withUnsafeWords { SELF in
            let name = Self.name
            let body = SELF.lazy.map(String.init).joined(separator: ", ")
            return "\(name)(\(body))"
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
        return try? Self.fromUnsafeMutableWords { MAGNITUDE in
            //=----------------------------------=
            let utf8 = source.utf8
            var chunkEndIndex  = utf8.endIndex as String.Index
            var magnitudeIndex = MAGNITUDE.startIndex as Int
            //=----------------------------------=
            backwards: while chunkEndIndex != utf8.startIndex {
                //=------------------------------=
                guard magnitudeIndex != MAGNITUDE.endIndex else {
                    let remainders = source[..<chunkEndIndex].utf8
                    let isOK = remainders.allSatisfy({ $0 == 48 })
                    if  isOK { return } else { throw ANKError() }
                }
                //=------------------------------=
                let chunkStartIndex = utf8.index(chunkEndIndex, offsetBy: -radix.exponent, limitedBy: utf8.startIndex) ?? utf8.startIndex
                guard let digit = UInt(source[chunkStartIndex ..< chunkEndIndex], radix: radix.base) else { throw ANKError() }
                chunkEndIndex = chunkStartIndex
                //=------------------------------=
                MAGNITUDE[magnitudeIndex] = digit
                MAGNITUDE.formIndex(after: &magnitudeIndex)
            }
            //=----------------------------------=
            while magnitudeIndex != MAGNITUDE.endIndex {
                MAGNITUDE[magnitudeIndex] = 0 as UInt
                MAGNITUDE.formIndex(after: &magnitudeIndex)
            }
        }
    }
    
    @inlinable static func _decodeBigEndianDigitsWhereRadixIsIn2Through36AndRadixIsNotUIntRoot(
    _ source: some StringProtocol, radix: RadixUIntRoot) -> Self? {
        assert(!radix.power.isZero)
        //=--------------------------------------=
        let utf8 = source.utf8
        var chunkStartIndex = utf8.startIndex as String.Index
        let chunkIndexAlignment = utf8.count % radix.exponent
        var magnitude = Magnitude()
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
        return value.magnitude.withUnsafeWords {
            String._bigEndianText(chunks: $0[...magnitude_.minLastIndex], sign: value.sign, radix: radix, uppercase: uppercase)
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
        return withUnsafeTemporaryAllocation(of: UInt.self, capacity: chunkCountUpperBound) { CHUNKS in
            var index = CHUNKS.startIndex
            //=----------------------------------=
            assert(!magnitude.isZero)
            forwards: repeat {
                let division = magnitude.quotientAndRemainder(dividingBy: radix.power as UInt)
                magnitude = division.quotient as Magnitude
                CHUNKS[index] = division.remainder as UInt
                CHUNKS.formIndex(after: &index)
            } while !magnitude.isZero
            //=----------------------------------=
            return String._bigEndianText(chunks: CHUNKS[..<index], sign: value.sign, radix: radix, uppercase: uppercase)
        }
    }
}

//=----------------------------------------------------------------------------=
// MARK: + String
//=----------------------------------------------------------------------------=

extension String {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable static func _bigEndianText<T>(chunks: T, sign: ANKSign, radix: RadixUIntRoot, uppercase: Bool) -> Self
    where T: RandomAccessCollection, T.Element == UInt, T.Index == Int {
        //=--------------------------------------=
        assert(chunks.isEmpty == false)
        assert(chunks.startIndex.isZero && chunks.endIndex == chunks.count)
        assert(chunks.allSatisfy{ $0 < radix.power } || radix.power.isZero)
        //=--------------------------------------=
        var index = chunks.index(before:  chunks.endIndex)
        var first = String(chunks[index], radix: radix.base, uppercase:  uppercase)
        let count = Int(bit: sign.bit) +  first.utf8.count + radix.exponent * index
        //=--------------------------------------=
        return String(unsafeUninitializedCapacity: count) { UTF8 in
            var utf8Index = UTF8.startIndex
            //=----------------------------------=
            if  sign.bit {
                UTF8.write(45, from: &utf8Index)
            }
            //=----------------------------------=
            UTF8.write(&first, from: &utf8Index)
            //=----------------------------------=
            backwards: while index != chunks.startIndex {
                chunks.formIndex(before:   &index)
                var content = String(chunks[index], radix: radix.base, uppercase: uppercase)
                content.withUTF8 { CONTENT in
                    let padding = repeatElement(UInt8(48), count: radix.exponent &- CONTENT.count)
                    UTF8.write(padding, from: &utf8Index)
                    UTF8.write(CONTENT, from: &utf8Index)
                }
            }
            //=----------------------------------=
            assert(UTF8.distance(from: UTF8.startIndex, to: utf8Index) == count)
            return count
        }
    }
}
