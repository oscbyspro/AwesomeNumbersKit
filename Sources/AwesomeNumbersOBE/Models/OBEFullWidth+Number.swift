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
// MARK: * OBE x Full Width x Number
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(integerLiteral source: some AwesomeFixedWidthInteger) {
        let low  = Low(truncatingIfNeeded: source)
        let high = High(repeating: source.isLessThanZero)
        self.init(descending:(high, low))
    }
    
    @inlinable init(_truncatingBits source: UInt) {
        assert(Low.bitWidth >= UInt.bitWidth)
        let word = Low(_truncatingBits: source)
        self.init(descending:(High(),   word))
    }

    @inlinable init(_ source: some BinaryInteger) {
        guard let value = Self(exactly: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
    @inlinable init?(exactly source: some BinaryInteger) {
        let words = source.words
        let isLessThanZero = type(of: source).isSigned && words.last?.mostSignificantBit == true
        let sign = UInt(repeating: isLessThanZero)
        self.init(_copy: words, _extending:  sign)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  self.isLessThanZero == isLessThanZero {
            let index = words.index(words.startIndex, offsetBy: self.count, limitedBy: words.endIndex)
            guard let index else { return }; if words[index...].allSatisfy({ $0 == sign }) { return }
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        return nil
    }
    
    @inlinable init(clamping source: some BinaryInteger) {
        let words = source.words
        let isLessThanZero = type(of: source).isSigned && words.last?.mostSignificantBit == true
        let sign = UInt(repeating: isLessThanZero)
        self.init(_copy: words, _extending:  sign)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  self.isLessThanZero == isLessThanZero {
            let index = words.index(words.startIndex, offsetBy: self.count, limitedBy: words.endIndex)
            guard let index else { return }; if words[index...].allSatisfy({ $0 == sign }) { return }
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        self = isLessThanZero ? Self.min : Self.max
    }
    
    @inlinable init(truncatingIfNeeded source: some BinaryInteger) {
        let words = source.words
        let isLessThanZero = type(of: source).isSigned && words.last?.mostSignificantBit == true
        self.init(_copy: words, _extending: UInt(repeating: isLessThanZero))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_copy words: some Collection<UInt>, _extending sign: UInt) {
        self = Self.uninitialized()
        var index = self.startIndex

        for word in words {
            if index == self.endIndex { break }
            self[unchecked: index] = word
            self.formIndex(after: &index)
        }

        while index != self.endIndex {
            self[unchecked: index] = sign
            self.formIndex(after: &index)
        }
    }
}
