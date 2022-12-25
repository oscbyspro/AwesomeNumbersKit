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
    
    @inlinable init(integerLiteral source: Int) {
        assert(Low.bitWidth >= Int.bitWidth)
        let low  = Low(truncatingIfNeeded: source)
        let high = High(repeating: source.isLessThanZero)
        self.init(descending:(high, low))
        precondition(self.isLessThanZero == source.isLessThanZero)
    }
    
    @inlinable init(_truncatingBits source: UInt) {
        assert(Low.bitWidth >= UInt.bitWidth)
        let low  = Low(_truncatingBits: source)
        let high = High(repeating: source.isLessThanZero)
        self.init(descending:(high, low))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init<T>(_ source: T) where T: BinaryInteger {
        guard let value = Self(exactly: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
    @inlinable init?<T>(exactly source: T) where T: BinaryInteger {
        let words: T.Words = source.words
        let isLessThanZero: Bool = T.isSigned && words.last?.mostSignificantBit == true
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
    
    @inlinable init<T>(clamping source: T) where T: BinaryInteger {
        let words: T.Words = source.words
        let isLessThanZero: Bool = T.isSigned && words.last?.mostSignificantBit == true
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
    
    @inlinable init<T>(truncatingIfNeeded source: T) where T: BinaryInteger {
        let words: T.Words = source.words
        let isLessThanZero: Bool = T.isSigned && words.last?.mostSignificantBit == true
        self.init(_copy: words, _extending: UInt(repeating: isLessThanZero))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=

    @inlinable init(_copy words: some Collection<UInt>, _extending sign: UInt) {
        self = Self.fromUnsafeTemporaryWords { SELF in
            var index: Int = SELF.startIndex

            for word: UInt in words {
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
