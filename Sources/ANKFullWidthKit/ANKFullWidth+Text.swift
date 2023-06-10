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
    @inlinable public static var description: String {
        let signedness = Self.isSigned ? "" : "U"
        return "\(signedness)Int\(Self.bitWidth)"
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
    
    @inlinable public static func decodeBigEndianText(_ text: some StringProtocol, radix: Int?) throws -> Self {
        let components = ANK.bigEndianTextComponents(text, radix: radix)
        let magnitude  = try AnyRadixUIntRoot(components.radix).switch(
          perfect: { try Magnitude.decodeBigEndianDigits(components.body,  radix: $0) },
        imperfect: { try Magnitude.decodeBigEndianDigits(components.body,  radix: $0) })
        guard let value = Self(exactly: ANKSigned(magnitude, as: components.sign)) else { throw ANKError() }
        return    value
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func decodeBigEndianDigits(_ source: some StringProtocol, radix: PerfectRadixUIntRoot) throws -> Self {
        guard !source.isEmpty else { throw ANKError() }
        //=--------------------------------------=
        return try Self.fromUnsafeMutableWords { MAGNITUDE in
            let utf8  = source.utf8.drop { $0 == 0x30 }
            //=----------------------------------=
            let start = utf8.startIndex as String.Index
            var tail  = utf8.endIndex   as String.Index
            var index = MAGNITUDE.startIndex as Int
            let step  = radix.exponent.twosComplement() as Int
            //=----------------------------------=
            backwards: while tail != start {
                guard index != MAGNITUDE.endIndex else { throw ANKError() }
                let head = utf8.index(tail, offsetBy: step,  limitedBy:  start) ?? start
                guard let word = UInt(source[head ..< tail], radix: radix.base) else { throw ANKError() }
                
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
    
    @inlinable static func decodeBigEndianDigits(_ source: some StringProtocol, radix: ImperfectRadixUIntRoot) throws -> Self {
        guard !source.isEmpty else { throw ANKError() }
        //=--------------------------------------=
        let utf8 = source.utf8.drop { $0 == 0x30 }
        var head = utf8.startIndex as String.Index
        let alignment = utf8.count  % radix.exponent as Int
        var magnitude = Magnitude()
        //=--------------------------------------=
        forwards: if !alignment.isZero {
            let tail = utf8.index(head, offsetBy: alignment/*-*/); defer  { head = tail }
            guard let word = UInt(source[head ..< tail], radix: radix.base) else { throw ANKError() }
            magnitude.first = word
        }
        //=--------------------------------------=
        forwards: while head != utf8.endIndex {
            let tail = utf8.index(head, offsetBy: radix.exponent); defer  { head = tail }
            guard let word = UInt(source[head ..< tail], radix: radix.base) else { throw ANKError() }
            guard !magnitude.multiplyReportingOverflow(by: radix.power)/**/ else { throw ANKError() }
            guard !magnitude.addReportingOverflow(word)/*----------------*/ else { throw ANKError() }
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
        let sign = ANKSign(source.isLessThanZero)
        var magnitude: Magnitude = source.magnitude
        let alphabet = MaxRadixAlphabet(uppercase: uppercase)
        return AnyRadixUIntRoot(radix).switch(
          perfect: { Magnitude.encodeBigEndianText(&magnitude, sign: sign, radix: $0, alphabet: alphabet) },
        imperfect: { Magnitude.encodeBigEndianText(&magnitude, sign: sign, radix: $0, alphabet: alphabet) })
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func encodeBigEndianText(_ magnitude: inout Self, sign: ANKSign,
    radix: PerfectRadixUIntRoot, alphabet: MaxRadixAlphabet) -> String {
        let minLastIndex: Int = magnitude.minLastIndexReportingIsZeroOrMinusOne().minLastIndex
        return magnitude.withUnsafeWords {
            String(chunks: $0[...minLastIndex], sign: sign, radix: radix, alphabet: alphabet)
        }
    }
    
    @inlinable static func encodeBigEndianText(_ magnitude: inout Self, sign: ANKSign,
    radix: ImperfectRadixUIntRoot, alphabet: MaxRadixAlphabet) -> String {
        let capacity: Int = radix.divisibilityByPowerUpperBound(magnitude)
        return withUnsafeTemporaryAllocation(of: UInt.self, capacity: capacity) { CHUNKS in
            var index = CHUNKS.startIndex
            rebasing: repeat {
                CHUNKS[index] = magnitude.formQuotientWithRemainderReportingOverflow(dividingBy: radix.power).partialValue
                CHUNKS.formIndex(after: &index)
            }   while !magnitude.isZero
            return String(chunks: CHUNKS[..<index], sign: sign, radix: radix, alphabet: alphabet)
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
        self = Self.withUTF8(chunk: chunks.last!, radix: radix, alphabet: alphabet) { FIRST in
            let count = Int(bit: sign.bit) &+ FIRST.count + radix.exponent * (chunks.count &- 1)
            return Self(unsafeUninitializedCapacity: count) { UTF8 in
                var index = UTF8.startIndex
                //=------------------------------=
                if  sign.bit {
                    UTF8.initializeElement(at: index, to: 0x2D)
                    UTF8.formIndex(after: &index)
                }
                //=------------------------------=
                index = UTF8[index...].initialize(fromContentsOf: FIRST)
                //=------------------------------=
                for var chunk in chunks.dropLast().reversed() {
                    let destination = UTF8.index(index, offsetBy: radix.exponent)
                    var backtrack = destination
                    defer { index = destination }
                    
                    backwards: while backtrack != index {
                        UTF8.formIndex(before: &backtrack)
                        
                        let digit: UInt
                        (chunk,  digit) = radix.dividing(chunk)
                        let unit: UInt8 = alphabet[unchecked: UInt8(_truncatingBits: digit)]
                        UTF8.initializeElement(at: backtrack, to: unit)
                    }
                }
                //=------------------------------=
                assert(UTF8[..<index].count == count)
                return count
            }
        }
    }
    
    @_transparent @usableFromInline static func withUTF8<T>(chunk: UInt, radix: some RadixUIntRoot,
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
                let unit: UInt8 = alphabet[unchecked: UInt8(_truncatingBits: digit)]
                UTF8.initializeElement(at: backtrack, to: unit)
            }   while !chunk.isZero
            //=----------------------------------=
            let initialized = UTF8[backtrack...]
            defer { initialized.deinitialize() }
            //=----------------------------------=
            return try body(UnsafeBufferPointer(rebasing: initialized))
        }
    }
}
