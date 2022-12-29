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

extension _ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(integerLiteral source: Int) {
        self.init(source)
    }
    
    @inlinable init(_truncatingBits source: UInt) {
        self.init(source)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init<T>(_ source: T) where T: BinaryInteger {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self = source
            return
        }
        //=--------------------------------------=
        // Int
        //=--------------------------------------=
        if  let source = source as? Int {
            self.init(digit: source)
            return
        }
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            self.init(digit: source)
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(magnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(generic: source)
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init?<T>(exactly source: T) where T: BinaryInteger {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self = source
            return
        }
        //=--------------------------------------=
        // Int
        //=--------------------------------------=
        if  let source = source as? Int {
            self.init(exactlyAsDigit: source)
            return
        }
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            self.init(exactlyAsDigit: source)
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(exactlyAsMagnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(exactlyAsGeneric: source)
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init<T>(clamping source: T) where T: BinaryInteger {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self = source
            return
        }
        //=--------------------------------------=
        // Int
        //=--------------------------------------=
        if  let source = source as? Int {
            self.init(clampingAsDigit: source)
            return
        }
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            self.init(clampingAsDigit: source)
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(clampingAsMagnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(clampingAsGeneric: source)
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init<T>(truncatingIfNeeded source: T) where T: BinaryInteger {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self = source
            return
        }
        //=--------------------------------------=
        // Int
        //=--------------------------------------=
        if  let source = source as? Int {
            self.init(truncatingIfNeededAsDigit: source)
            return
        }
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            self.init(truncatingIfNeededAsDigit: source)
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(truncatingIfNeededAsMagnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(truncatingIfNeededAsGeneric: source)
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Number x Integer x Digit
//*============================================================================*

extension _ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init(digit source: some ANKIntOrUInt) {
        guard let value = Self(exactlyAsDigit: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init?(exactlyAsDigit source: some ANKIntOrUInt) {
        //=--------------------------------------=
        // Int
        //=--------------------------------------=
        if !Self.isSigned, source.isLessThanZero {
            return nil
        }
        //=--------------------------------------=
        // some ANKIntOrUInt
        //=--------------------------------------=
        self.init(truncatingIfNeededAsDigit: source)
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init(clampingAsDigit source: some ANKIntOrUInt) {
        //=--------------------------------------=
        // Int
        //=--------------------------------------=
        if !Self.isSigned, source.isLessThanZero {
            self.init()
            return
        }
        //=--------------------------------------=
        // some ANKIntOrUInt
        //=--------------------------------------=
        self.init(truncatingIfNeededAsDigit: source)
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init(truncatingIfNeededAsDigit source: some ANKIntOrUInt) {
        assert(Low.bitWidth >= source.bitWidth)
        //=--------------------------------------=
        let high = High(repeating: source.isLessThanZero)
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            let low = Low(_truncatingBits: source)
            self.init(descending:(high, low))
        //=--------------------------------------=
        // Int, some ANKIntOrUInt
        //=--------------------------------------=
        }   else {
            let low = Low(truncatingIfNeeded: source)
            self.init(descending:(high, low))
        }
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Number x Integer x Magnitude
//*============================================================================*

extension _ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init(magnitude source: Magnitude) {
        guard let value = Self(exactlyAsMagnitude: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init?(exactlyAsMagnitude source: Magnitude) {
        //=--------------------------------------=
        if  Self.isSigned, source.mostSignificantBit {
            return nil
        }
        //=--------------------------------------=
        self.init(truncatingIfNeededAsMagnitude: source)
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init(clampingAsMagnitude source: Magnitude) {
        //=--------------------------------------=
        if  Self.isSigned, source.mostSignificantBit {
            self = Self.max
            return
        }
        //=--------------------------------------=
        self.init(truncatingIfNeededAsMagnitude: source)
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init(truncatingIfNeededAsMagnitude source: Magnitude) {
        self.init(bitPattern: source)
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Number x Integer x Generic
//*============================================================================*

extension _ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init<T>(generic source: T) where T: BinaryInteger {
        guard let value = Self(exactlyAsGeneric: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
    @inlinable init?<T>(exactlyAsGeneric source: T) where T: BinaryInteger {
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
    
    @inlinable init<T>(clampingAsGeneric source: T) where T: BinaryInteger {
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
    
    @inlinable init<T>(truncatingIfNeededAsGeneric source: T) where T: BinaryInteger {
        let words: T.Words = source.words
        let isLessThanZero: Bool = T.isSigned && words.last?.mostSignificantBit == true
        let sign = UInt(repeating: isLessThanZero)
        //=--------------------------------------=
        (self, _) = Self._copy(words, _extending: sign) as (Self, Int)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
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
