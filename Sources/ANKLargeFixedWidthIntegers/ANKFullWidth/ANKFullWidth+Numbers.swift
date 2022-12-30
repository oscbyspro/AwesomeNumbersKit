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
    
    @_transparent public init(digit source: Digit) {
        self.init(source)
    }
    
    @_transparent public init(integerLiteral source: Int) {
        self.init(source)
    }
    
    @_transparent public init(_truncatingBits source: UInt) {
        self.init(source)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent public init(_ source: some BinaryInteger) {
        guard let value = Self(exactly: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent public init?(exactly source: some BinaryInteger) {
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
            self.init(_exactlyAsDigit: source)
            return
        }
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            self.init(_exactlyAsDigit: source)
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(_exactlyAsMagnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(_exactlyAsGeneric: source)
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent public init(clamping source: some BinaryInteger) {
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
            self.init(_clampingAsDigit: source)
            return
        }
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            self.init(_clampingAsDigit: source)
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(_clampingAsMagnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(_clampingAsGeneric: source)
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent public init(truncatingIfNeeded source: some BinaryInteger) {
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
            self.init(_truncatingIfNeededAsDigit: source)
            return
        }
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            self.init(_truncatingIfNeededAsDigit: source)
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(_truncatingIfNeededAsMagnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(_truncatingIfNeededAsGeneric: source)
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
    @inlinable init?(_exactlyAsDigit source: some ANKIntOrUInt) {
        //=--------------------------------------=
        // Int
        //=--------------------------------------=
        if !Self.isSigned, source.isLessThanZero {
            return nil
        }
        //=--------------------------------------=
        // some ANKIntOrUInt
        //=--------------------------------------=
        self.init(_truncatingIfNeededAsDigit: source)
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init(_clampingAsDigit source: some ANKIntOrUInt) {
        self = Self(_exactlyAsDigit: source) ?? Self()
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @inlinable init(_truncatingIfNeededAsDigit source: some ANKIntOrUInt) {
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
    @inlinable init?(_exactlyAsMagnitude source: Magnitude) {
        //=--------------------------------------=
        if  Self.isSigned, source.mostSignificantBit {
            return nil
        }
        //=--------------------------------------=
        self.init(_truncatingIfNeededAsMagnitude: source)
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent @usableFromInline init(_clampingAsMagnitude source: Magnitude) {
        self = Self(_exactlyAsMagnitude: source) ?? Self.max
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent @usableFromInline init(_truncatingIfNeededAsMagnitude source: Magnitude) {
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
    
    @inlinable init?<T>(_exactlyAsGeneric source: T) where T: BinaryInteger {
        let (value, words, index, sign, isLessThanZero) = Self._copy(source)
        //=--------------------------------------=
        if value.isLessThanZero == isLessThanZero && words[index...].allSatisfy({ $0 == sign }) { self = value; return }
        //=--------------------------------------=
        return nil
    }
    
    @inlinable init<T>(_clampingAsGeneric source: T) where T: BinaryInteger {
        let (value, words, index, sign, isLessThanZero) = Self._copy(source)
        //=--------------------------------------=
        if value.isLessThanZero == isLessThanZero && words[index...].allSatisfy({ $0 == sign }) { self = value; return }
        //=--------------------------------------=
        self = isLessThanZero ? Self.min : Self.max
    }
    
    @inlinable init<T>(_truncatingIfNeededAsGeneric source: T) where T: BinaryInteger {
        (self, _, _, _, _) = Self._copy(source)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
        
    @inlinable static func _copy<T>(_ source: T) -> (Self, T.Words, Int, UInt, Bool) where T: BinaryInteger {
        let words: T.Words = source.words
        let isLessThanZero: Bool = T.isSigned && words.last?.mostSignificantBit == true
        let sign = UInt(repeating: isLessThanZero)
        //=--------------------------------------=
        let (value, index) = Self._copy(words, _extending: sign) as (Self, Int)
        //=--------------------------------------=
        return (value, words, index, sign, isLessThanZero)
    }
    
    @inlinable static func _copy<T>(_ words: T, _extending sign: UInt) -> (Self, Int) where T: Collection<UInt>, T.Index == Int {
        assert(sign == UInt.min || sign == UInt.max)
        //=--------------------------------------=
        var index = words.startIndex
        //=--------------------------------------=
        let value = Self.fromUnsafeTemporaryWords { VALUE in
            //=----------------------------------=
            var valueIndex = VALUE.startIndex
            var wordsIndex = words.startIndex
            defer { index = wordsIndex }
            //=----------------------------------=
            while wordsIndex != words.endIndex {
                guard valueIndex != VALUE.endIndex else { return }
                
                let word = words[wordsIndex]
                words.formIndex(after: &wordsIndex)
                VALUE[unchecked: valueIndex] = word
                VALUE.formIndex(after: &valueIndex)
            }
            //=----------------------------------=
            while valueIndex != VALUE.endIndex {
                VALUE[unchecked: valueIndex] = sign
                VALUE.formIndex(after: &valueIndex)
            }
        }
        //=--------------------------------------=
        return (value, index)
    }
}
