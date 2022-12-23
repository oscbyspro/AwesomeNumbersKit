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
// MARK: * ANK x Full Width x Number x Integer
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
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
        if  self.isLessThanZero == isLessThanZero {
            let index = words.index(words.startIndex, offsetBy: self.count, limitedBy: words.endIndex)
            guard let index else { return }; if words[index...].allSatisfy({ $0 == sign }) { return }
        }
        //=--------------------------------------=
        return nil
    }
    
    @inlinable init(clamping source: some BinaryInteger) {
        let words = source.words
        let isLessThanZero = type(of: source).isSigned && words.last?.mostSignificantBit == true
        let sign = UInt(repeating: isLessThanZero)
        self.init(_copy: words, _extending:  sign)
        //=--------------------------------------=
        if  self.isLessThanZero == isLessThanZero {
            let index = words.index(words.startIndex, offsetBy: self.count, limitedBy: words.endIndex)
            guard let index else { return }; if words[index...].allSatisfy({ $0 == sign }) { return }
        }
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
        self = Self.fromUnsafeTemporaryWords { SELF in
            var index = SELF.startIndex

            for word in words {
                if index == SELF.endIndex { break }
                SELF[unchecked: index] = word
                SELF.formIndex(after: &index)
            }
            
            while index != SELF.endIndex {
                SELF[unchecked: index] = sign
                SELF.formIndex(after: &index)
            }
        }
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Conversion x Number x Digit
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
        
    @inlinable init(integerLiteral source: Int) {
        self.init(digit: source)
    }
    
    @inlinable init(_truncatingBits source: UInt) {
        self.init(digit: source)
    }
    
    @inlinable init(digit source: some AwesomeIntOrUInt) {
        assert(Low.bitWidth >= source.bitWidth)
        let high = High(repeating: source.isLessThanZero)
        //=--------------------------------------=
        if  type(of: source).isSigned {
            let low = Low(truncatingIfNeeded: source)
            self.init(descending:(high, low))
            precondition(isLessThanZero == source.isLessThanZero)
        } else {
            let low = Low(_truncatingBits: UInt(bitPattern: source))
            self.init(descending:(high, low))
        }
    }
}
