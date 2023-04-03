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
    
    /// The description of this type.
    ///
    /// ```swift
    /// FullWidth< Int128, UInt128>.description //  "Int256"
    /// FullWidth<UInt256, UInt256>.description // "UInt512"
    /// ```
    ///
    @inlinable static var description: String {
        let signedness = !Self.isSigned ? "U" : ""
        let size = String(Self.bitWidth)
        return "\(signedness)Int\(size)"
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent public var description: String {
        String(encoding: self)
    }
    
    @inlinable public var debugDescription: String {
        self.withUnsafeWords { SELF in
            let name = Self.description
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
    
    @inlinable public static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) throws -> Self {
        let components = source._bigEndianTextComponents(radix: radix)
        let root = RadixUIntRoot(components.radix)
        //=--------------------------------------=
        let magnitude: Magnitude; switch root.power.isZero {
        case  true: magnitude = try Magnitude._decodeBigEndianDigitsWhereRadixIsUIntRoot(   components.body, radix: root)
        case false: magnitude = try Magnitude._decodeBigEndianDigitsWhereRadixIsNotUIntRoot(components.body, radix: root) }
        //=--------------------------------------=
        return try Self(exactly: ANKSigned(magnitude, as: components.sign)) ?? ANKError()
    }
    
    @inlinable public static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool) -> String {
        let root  = RadixUIntRoot(radix)
        let sign  = ANKSign(source.isLessThanZero)
        var value = ANKSigned(source.magnitude, as: sign)
        //=--------------------------------------=
        switch root.power.isZero {
        case  true: return Magnitude._encodeBigEndianTextWhereRadixIsUIntRoot(   &value, radix: root, uppercase: uppercase)
        case false: return Magnitude._encodeBigEndianTextWhereRadixIsNotUIntRoot(&value, radix: root, uppercase: uppercase) }
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Decode
    //=------------------------------------------------------------------------=
    
    @inlinable static func _decodeBigEndianDigitsWhereRadixIsUIntRoot(_ source: some StringProtocol, radix: RadixUIntRoot) throws -> Self {
        try Self.fromUnsafeMutableWords { MAGNITUDE in
            assert(radix.power.isZero)
            //=----------------------------------=
            let utf8 = source.utf8
            var chunkEndIndex  = utf8.endIndex as String.Index
            var magnitudeIndex = MAGNITUDE.startIndex as Int
            //=----------------------------------=
            backwards: while chunkEndIndex != utf8.startIndex {
                if  magnitudeIndex == MAGNITUDE.endIndex {
                    return try utf8[..<chunkEndIndex].allSatisfy({ $0 == 48 }) || ANKError()
                }
                //=------------------------------=
                let chunkStartIndex = utf8.index(chunkEndIndex, offsetBy: -radix.exponentInt, limitedBy: utf8.startIndex) ?? utf8.startIndex
                let digit = try UInt(source[chunkStartIndex ..< chunkEndIndex], radix: radix.baseInt) ?? ANKError()
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
    
    @inlinable static func _decodeBigEndianDigitsWhereRadixIsNotUIntRoot(_ source: some StringProtocol, radix: RadixUIntRoot) throws -> Self {
        assert(!radix.power.isZero)
        //=--------------------------------------=
        let utf8 = source.utf8
        var chunkStartIndex = utf8.startIndex as String.Index
        let chunkIndexAlignment = utf8.count % radix.exponentInt
        var magnitude = Magnitude()
        //=--------------------------------------=
        forwards: if !chunkIndexAlignment.isZero {
            //=----------------------------------=
            let chunkEndIndex = utf8.index(chunkStartIndex, offsetBy: chunkIndexAlignment)
            let digit = try UInt(source[chunkStartIndex ..< chunkEndIndex], radix: radix.baseInt) ?? ANKError()
            chunkStartIndex = chunkEndIndex
            //=----------------------------------=
            magnitude[unchecked: Self.startIndex] = digit
        }
        //=--------------------------------------=
        forwards: while chunkStartIndex != utf8.endIndex {
            //=----------------------------------=
            let chunkEndIndex = utf8.index(chunkStartIndex, offsetBy: radix.exponentInt)
            let digit = try UInt(source[chunkStartIndex ..< chunkEndIndex], radix: radix.baseInt) ?? ANKError()
            chunkStartIndex = chunkEndIndex
            //=----------------------------------=
            try !magnitude.multiplyReportingOverflow(by: radix.power as UInt) || ANKError()
            try !magnitude.addReportingOverflow(digit as UInt) || ANKError()
        }
        //=--------------------------------------=
        return magnitude
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Encode
    //=------------------------------------------------------------------------=
    
    @inlinable static func _encodeBigEndianTextWhereRadixIsUIntRoot(_ value: inout ANKSigned<Self>, radix: RadixUIntRoot, uppercase: Bool) -> String {
        assert(radix.power.isZero)
        //=--------------------------------------=
        let minLastIndex: Int = value.magnitude.minLastIndexReportingIsZeroOrMinusOne().minLastIndex
        return value.magnitude.withUnsafeWords {
            String._bigEndianText(chunks: $0[...minLastIndex], sign: value.sign, radix: radix, uppercase: uppercase)
        }
    }
    
    @inlinable static func _encodeBigEndianTextWhereRadixIsNotUIntRoot(_ value: inout ANKSigned<Self>, radix: RadixUIntRoot, uppercase: Bool) -> String {
        assert(!radix.power.isZero)
        //=--------------------------------------=
        let capacity: Int = radix.divisibilityByPowerUpperBound(value.magnitude)
        return withUnsafeTemporaryAllocation(of: UInt.self,  capacity: capacity) { CHUNKS in
            var index = CHUNKS.startIndex
            //=----------------------------------=
            forwards: repeat {
                (value.magnitude, CHUNKS[index]) = value.magnitude.quotientAndRemainder(dividingBy: radix.power as UInt)
                CHUNKS.formIndex(after: &index)
            } while !value.magnitude.isZero
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
    where T: BidirectionalCollection<UInt>, T.Index == Int {
        assert(2 ... 36 ~= radix.base)
        assert(chunks.last != 0 || chunks.count == 1)
        assert(chunks.startIndex.isZero && chunks.endIndex == chunks.count)
        assert(chunks.allSatisfy{ $0 < radix.power } || radix.power.isZero)
        //=--------------------------------------=
        let alphabet = DigitsToText(uppercase:  uppercase)
        var index = chunks.index(before:  chunks.endIndex)
        var first = String(chunks[index], radix: radix.baseInt, uppercase:  uppercase)
        let count = Int(bit: sign.bit) &+ first.utf8.count + radix.exponentInt * index
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
                chunks.formIndex(before: &index)
                
                var chunk = chunks[index] as UInt
                let destination = UTF8.index(utf8Index, offsetBy: radix.exponentInt)
                defer { utf8Index = destination }
                
                var position = destination
                backwards: while position != utf8Index {
                    UTF8.formIndex(before: &position)
                    
                    let digit: UInt
                    (chunk, digit) = chunk.quotientAndRemainder(dividingBy: radix.base)
                    UTF8[position] = alphabet[unchecked: digit]
                }
            }
            //=----------------------------------=
            assert(UTF8.distance(from: UTF8.startIndex, to: utf8Index) == count)
            return count
        }
    }
}
