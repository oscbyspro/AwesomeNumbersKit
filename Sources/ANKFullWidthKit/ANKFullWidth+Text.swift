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
// MARK: * ANK x Full Width x Text x Decode
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) throws -> Self {
        let components = source._bigEndianTextComponents(radix: radix)
        let magnitude  = try AnyRadixUIntRoot(components.radix).switch(
          perfect: { try Magnitude._decodeBigEndianDigits(components.body,  radix: $0) },
        imperfect: { try Magnitude._decodeBigEndianDigits(components.body,  radix: $0) })
        return try Self(exactly: ANKSigned(magnitude, as: components.sign)) ?? ANKError()
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func _decodeBigEndianDigits(_ source: some StringProtocol, radix: PerfectRadixUIntRoot) throws -> Self {
        try Self.fromUnsafeMutableWords  { MAGNITUDE in
            let utf8  = source.utf8.drop { $0 == 48 }
            let start = utf8.startIndex as String.Index
            var tail  = utf8.endIndex   as String.Index
            var index = MAGNITUDE.startIndex as Int
            let step  = -radix.exponent      as Int
            //=----------------------------------=
            backwards: while tail != start {
                try index < MAGNITUDE.endIndex || ANKError()
                let head  = utf8.index(tail, offsetBy: step,  limitedBy:  start) ?? start
                let word  = try UInt(source[head  ..<  tail], radix: radix.base) ?? ANKError()
                
                tail = head
                MAGNITUDE[index] = word
                MAGNITUDE.formIndex(after: &index)
            }
            //=----------------------------------=
            uninitialized: while index != MAGNITUDE.endIndex {
                MAGNITUDE[index] = UInt()
                MAGNITUDE.formIndex(after: &index)
            }
        }
    }
    
    @inlinable static func _decodeBigEndianDigits(_ source: some StringProtocol, radix: ImperfectRadixUIntRoot) throws -> Self {
        let utf8 = source.utf8.drop { $0 == 48 }
        var head = utf8.startIndex as String.Index
        let alignment = utf8.count  % radix.exponent
        var magnitude = Magnitude()
        //=--------------------------------------=
        forwards: if !alignment.isZero {
            let tail = utf8.index(head, offsetBy: alignment/*-*/); defer  { head = tail }
            let word = try UInt(source[head  ..<  tail], radix: radix.base) ?? ANKError()
            magnitude[unchecked:  magnitude.startIndex] = word
        }
        //=--------------------------------------=
        forwards: while head != utf8.endIndex {
            let tail = utf8.index(head, offsetBy: radix.exponent); defer  { head = tail }
            let word = try UInt(source[head  ..<  tail], radix: radix.base) ?? ANKError()
            try !magnitude.multiplyReportingOverflow(by: radix.power)/*--*/ || ANKError()
            try !magnitude.addReportingOverflow(word)/*------------------*/ || ANKError()
        }
        //=--------------------------------------=
        return magnitude
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Text x Encode
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool) -> String {
        let alphabet = MaxRadixAlphabet(uppercase: uppercase)
        var value = ANKSigned(source.magnitude,as: ANKSign(source.isLessThanZero))
        return AnyRadixUIntRoot(radix).switch(
          perfect: { Magnitude._encodeBigEndianText(&value, radix: $0, alphabet: alphabet) },
        imperfect: { Magnitude._encodeBigEndianText(&value, radix: $0, alphabet: alphabet) })
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func _encodeBigEndianText(_ value: inout ANKSigned<Self>,
    radix: PerfectRadixUIntRoot, alphabet: MaxRadixAlphabet) -> String {
        let minLastIndex: Int = value.magnitude.minLastIndexReportingIsZeroOrMinusOne().minLastIndex
        return value.magnitude.withUnsafeWords {
            String(chunks: $0[...minLastIndex], sign: value.sign, radix: radix, alphabet: alphabet)
        }
    }
    
    @inlinable static func _encodeBigEndianText(_ value: inout ANKSigned<Self>,
    radix: ImperfectRadixUIntRoot, alphabet: MaxRadixAlphabet) -> String {
        let capacity: Int = radix.divisibilityByPowerUpperBound(value.magnitude)
        return withUnsafeTemporaryAllocation(of: UInt.self,  capacity: capacity) { CHUNKS in
            var index = CHUNKS.startIndex
            rebasing: repeat {
                (value.magnitude,CHUNKS[index]) = value.magnitude.quotientAndRemainder(dividingBy: radix.power)
                CHUNKS.formIndex(after: &index)
            }   while !(value.magnitude.isZero)
            return String(chunks:CHUNKS[..<index], sign: value.sign, radix: radix, alphabet: alphabet)
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
    
    @inlinable init(chunks: some BidirectionalCollection<UInt>, sign: ANKSign,
    radix: some RadixUIntRoot, alphabet: MaxRadixAlphabet) {
        assert(chunks.last! != 0 || chunks.count == 1)
        assert(chunks.allSatisfy({ $0 < radix.power }) || radix.power.isZero)
        //=--------------------------------------=
        self = Self._withUTF8(chunk: chunks.last!, radix: radix, alphabet: alphabet) { FIRST in
            let count = Int(bit: sign.bit) &+ FIRST.count + radix.exponent * (chunks.count &- 1)
            return Self(unsafeUninitializedCapacity: count) { UTF8 in
                var index = UTF8.startIndex
                //=------------------------------=
                if  sign.bit {
                    UTF8[index] = 45
                    UTF8.formIndex(after: &index)
                }
                //=------------------------------=
                index = UTF8[index...].update(fromContentsOf: FIRST)
                //=------------------------------=
                for var chunk in chunks.dropLast().reversed() {
                    let destination = UTF8.index(index, offsetBy: radix.exponent)
                    var backtrack = destination
                    defer { index = destination }
                    
                    backwards: while backtrack != index {
                        UTF8.formIndex(before: &backtrack)
                        
                        let digit: UInt
                        (chunk,  digit) = radix.dividing(chunk)
                        UTF8[backtrack] = alphabet[unchecked: UInt8(_truncatingBits: digit)]
                    }
                }
                //=------------------------------=
                assert(UTF8.distance(from: UTF8.startIndex, to: index) == count)
                return count
            }
        }
    }
    
    @_transparent @usableFromInline static func _withUTF8<T>(chunk: UInt, radix: some RadixUIntRoot,
    alphabet: MaxRadixAlphabet, body: (UnsafeBufferPointer<UInt8>) throws -> T) rethrows -> T {
        try withUnsafeTemporaryAllocation(of: UInt8.self, capacity: radix.exponent) { UTF8 in
            assert(chunk < radix.power || radix.power.isZero)
            //=----------------------------------=
            var chunk = chunk as UInt
            var backtrack = radix.exponent as Int
            //=----------------------------------=
            backwards: repeat {
                UTF8.formIndex(before: &backtrack)
                
                let digit: UInt
                (chunk,  digit) = radix.dividing(chunk)
                UTF8[backtrack] = alphabet[unchecked: UInt8(_truncatingBits: digit)]
            }   while !chunk.isZero
            //=----------------------------------=
            return try body(UnsafeBufferPointer(rebasing: UTF8[backtrack...]))
        }
    }
}
