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
        let atLestOneWord = Low(_truncatingBits: source)
        self.init(descending:(High(),    atLestOneWord))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_integerLiteral source: some AwesomeFixedWidthInteger) {
        let low  = Low(truncatingIfNeeded: source)
        let high = High(repeating: source.isLessThanZero)
        self.init(descending:(high, low))
    }
    
    @inlinable init(_normal source: some BinaryInteger) {
        self.init(_exactly: source)!
    }
    
    @inlinable init?(_exactly source: some BinaryInteger) {
        let words = source.words
        let isLessThanZero = type(of: source).isSigned && words.last?.mostSignificantBit == true
        let sign = UInt(repeating: isLessThanZero)
        self.init(_copy: words, _extending:  sign)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  self.isLessThanZero == isLessThanZero {
            let index = words.index(words.startIndex, offsetBy: body.count, limitedBy: words.endIndex)
            guard let index else { return }; if words[index...].allSatisfy({ $0 == sign }) { return }
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        return nil
    }
    
    @inlinable init(_clamping source: some BinaryInteger) {
        let words = source.words
        let isLessThanZero = type(of: source).isSigned && words.last?.mostSignificantBit == true
        let sign = UInt(repeating: isLessThanZero)
        self.init(_copy: words, _extending:  sign)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  self.isLessThanZero == isLessThanZero {
            let index = words.index(words.startIndex, offsetBy: body.count, limitedBy: words.endIndex)
            guard let index else { return }; if words[index...].allSatisfy({ $0 == sign }) { return }
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        self = isLessThanZero ? Self.min : Self.max
    }
    
    @inlinable init(_truncatingIfNeeded source: some BinaryInteger) {
        let words = source.words
        let isLessThanZero = type(of: source).isSigned && words.last?.mostSignificantBit == true
        self.init(_copy: words, _extending: UInt(repeating: isLessThanZero))
    }
    
    @inlinable init(_copy words: some Collection<UInt>, _extending sign: UInt) {
        self = Self.uninitialized()
        var index = body.startIndex

        for word in words {
            if index == body.endIndex { break }
            body[unchecked: index] = word
            body.formIndex(after: &index)
        }

        while index != body.endIndex {
            body[unchecked: index] = sign
            body.formIndex(after: &index)
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
        self.init(_normal: source)
    }

    @inlinable public init?(exactly source: some BinaryInteger) {
        self.init(_exactly: source)
    }

    @inlinable public init(clamping source: some BinaryInteger) {
        self.init(_clamping: source)
    }

    @inlinable public init(truncatingIfNeeded source: some BinaryInteger) {
        self.init(_truncatingIfNeeded: source)
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
        self.init(_normal: source)
    }

    @inlinable public init?(exactly source: some BinaryInteger) {
        self.init(_exactly: source)
    }

    @inlinable public init(clamping source: some BinaryInteger) {
        self.init(_clamping: source)
    }

    @inlinable public init(truncatingIfNeeded source: some BinaryInteger) {
        self.init(_truncatingIfNeeded: source)
    }
}
