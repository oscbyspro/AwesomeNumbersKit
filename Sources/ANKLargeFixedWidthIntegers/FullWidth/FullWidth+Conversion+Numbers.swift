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
        let words: T.Words = source.words; let index: T.Words.Index
        let isLessThanZero: Bool = T.isSigned && words.last?.mostSignificantBit == true
        let sign = UInt(repeating: isLessThanZero)
        //=--------------------------------------=
        (self, index) = Self._copy(words, _extending: sign) as (Self, Int)
        //=--------------------------------------=
        if self.isLessThanZero == isLessThanZero, words[index...].allSatisfy({ $0 == sign }) { return }
        //=--------------------------------------=
        return nil
    }
    
    @inlinable init<T>(clamping source: T) where T: BinaryInteger {
        let words: T.Words = source.words; let index: T.Words.Index
        let isLessThanZero: Bool = T.isSigned && words.last?.mostSignificantBit == true
        let sign = UInt(repeating: isLessThanZero)
        //=--------------------------------------=
        (self, index) = Self._copy(words, _extending: sign) as (Self, Int)
        //=--------------------------------------=
        if self.isLessThanZero == isLessThanZero && words[index...].allSatisfy({ $0 == sign }) { return }
        //=--------------------------------------=
        self = isLessThanZero ? Self.min : Self.max
    }
    
    @inlinable init<T>(truncatingIfNeeded source: T) where T: BinaryInteger {
        let words: T.Words = source.words
        let isLessThanZero: Bool = T.isSigned && words.last?.mostSignificantBit == true
        let sign = UInt(repeating: isLessThanZero)
        //=--------------------------------------=
        (self, _) = Self._copy(words, _extending: sign) as (Self, Int)
    }
    
    @inlinable static func _copy<T>(_ source: T, _extending sign: UInt) -> (Self, T.Index) where T: Collection<UInt>, T.Index == Int {
        assert(sign == UInt.min || sign == UInt.max)
        //=--------------------------------------=
        var index = source.startIndex
        //=--------------------------------------=
        let value = Self.fromUnsafeTemporaryWords { SELF in
            //=----------------------------------=
            var bodyIndex = SELF.startIndex
            var sourceIndex = source.startIndex
            defer { index = sourceIndex }
            //=----------------------------------=
            while sourceIndex != source.endIndex {
                guard bodyIndex != SELF.endIndex else { return }
                
                let word = source[sourceIndex]
                source.formIndex(after: &sourceIndex)
                
                SELF[unchecked: bodyIndex] = word
                SELF.formIndex(after: &bodyIndex)
            }
            //=----------------------------------=
            while bodyIndex != SELF.endIndex {
                SELF[unchecked: bodyIndex] = sign
                SELF.formIndex(after: &bodyIndex)
            }
        }
        //=--------------------------------------=
        return (value, index)
    }
}
