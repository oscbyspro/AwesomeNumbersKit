//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import AwesomeNumbersKit

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Number
//*============================================================================*
//=----------------------------------------------------------------------------=
// most init methods must be overloaded at the un/signed integer protocol level
//=----------------------------------------------------------------------------=

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_truncatingBits source: UInt) {
        self.init(descending:(High(), Low(_truncatingBits: source))) // Low.bitWidth >= UInt.bitWidth
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_integerLiteral source: some AwesomeFixedWidthInteger) {
        let high = High(repeating: source.isLessThanZero)
        let low  = Self.reinterpret(High(truncatingIfNeeded: source))
        self.init(descending:(high, low))
    }
    
    @inlinable init(_normal source:(words: some Collection<UInt>, isLessThanZero: Bool)) {
        self.init(_exactly: source)!
    }
    
    @inlinable init?(_exactly source:(words: some Collection<UInt>, isLessThanZero: Bool)) {
        let sign  = UInt(repeating: source.isLessThanZero)
        let words = source.words; var index = words.startIndex
        self.init(copy: words, from: &index,  extending: sign)
        if source.isLessThanZero == isLessThanZero, words[index...].allSatisfy({ $0 == sign }) { return }
        return nil
    }
    
    @inlinable init(_clamping source:(words: some Collection<UInt>, isLessThanZero: Bool)) {
        let sign  = UInt(repeating: source.isLessThanZero)
        let words = source.words; var index = words.startIndex
        self.init(copy: words, from: &index,  extending: sign)
        if source.isLessThanZero == isLessThanZero, words[index...].allSatisfy({ $0 == sign }) { return }
        self = source.isLessThanZero ? Self.min : Self.max
    }
    
    @inlinable init(_truncatingIfNeeded source:(words: some Collection<UInt>, isLessThanZero: Bool)) {
        let sign  = UInt(repeating: source.isLessThanZero)
        let words = source.words; var index = words.startIndex
        self.init(copy: words, from: &index,  extending: sign)
    }
    
    @inlinable init<T>(copy words: T, from index: inout T.Index, extending sign: UInt) where T: Collection<UInt> {
        self = Self.fromUnsafeUninitializedTwosComplementWords { NEXT in
            var nextIndex = NEXT.startIndex
            //=----------------------------------=
            //
            //=----------------------------------=
            while nextIndex != NEXT.endIndex, index != words.endIndex {
                NEXT[nextIndex] = words[index]
                words.formIndex(after: &index)
                NEXT .formIndex(after: &nextIndex)
            }
            //=----------------------------------=
            //
            //=----------------------------------=
            while nextIndex != NEXT.endIndex {
                NEXT[nextIndex] = sign
                NEXT.formIndex(after: &nextIndex)
            }
        }
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Number x Signed
//*============================================================================*

extension OBESignedFixedWidthInteger {

    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(integerLiteral source: Int) {
        self.init(_integerLiteral: source)
    }
    
    @inlinable public init(_ source: some BinaryInteger) {
        self.init(_normal:(words: source.words, isLessThanZero: source < 0))
    }

    @inlinable public init?(exactly source: some BinaryInteger) {
        self.init(_exactly:(words: source.words, isLessThanZero: source < 0))
    }

    @inlinable public init(clamping source: some BinaryInteger) {
        self.init(_clamping:(words: source.words, isLessThanZero: source < 0))
    }

    @inlinable public init(truncatingIfNeeded source: some BinaryInteger) {
        self.init(_truncatingIfNeeded:(words: source.words, isLessThanZero: source < 0))
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Number x Unsigned
//*============================================================================*

extension OBEUnsignedFixedWidthInteger {

    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(integerLiteral source: UInt) {
        self.init(_integerLiteral: source)
    }
    
    @inlinable public init(_ source: some BinaryInteger) {
        self.init(_normal:(words: source.words, isLessThanZero: source < 0))
    }
    
    @inlinable public init?(exactly source: some BinaryInteger) {
        self.init(_exactly:(words: source.words, isLessThanZero: source < 0))
    }
    
    @inlinable public init(clamping source: some BinaryInteger) {
        self.init(_clamping:(words: source.words, isLessThanZero: source < 0))
    }
    
    @inlinable public init(truncatingIfNeeded source: some BinaryInteger) {
        self.init(_truncatingIfNeeded:(words: source.words, isLessThanZero: source < 0))
    }
}
