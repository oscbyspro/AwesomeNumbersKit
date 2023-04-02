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
// MARK: * ANK x Full Width x Numbers x Integer
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(digit source: Digit) {
        self.init(source)
    }
    
    @_transparent public init(_truncatingBits source: UInt) {
        self.init(source)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_ source: some BinaryInteger) {
        guard let value = Self(exactly: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range.")
        }
        
        self = value
    }
    
    @inlinable public init?(exactly source: some BinaryInteger) {
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
        self.init(_exactlyAsBinaryInteger: source)
    }
    
    @inlinable public init(clamping source: some BinaryInteger) {
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
        self.init(_clampingAsBinaryInteger: source)
    }
    
    @inlinable public init(truncatingIfNeeded source: some BinaryInteger) {
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
        self.init(_truncatingIfNeededAsBinaryInteger: source)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Int Or UInt
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init?(_exactlyAsDigit source: some ANKIntOrUInt) {
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
    
    @_transparent @usableFromInline init(_clampingAsDigit source: some ANKIntOrUInt) {
        self = Self(_exactlyAsDigit: source) ?? Self()
    }
    
    @_transparent @usableFromInline init(_truncatingIfNeededAsDigit source: some ANKIntOrUInt) {
        assert(Low.bitWidth >= source.bitWidth)
        //=--------------------------------------=
        let high = High(repeating: source.isLessThanZero)
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            let low = Low(_truncatingBits: source)
            self.init(descending: HL(high, low))
        //=--------------------------------------=
        // Int, some ANKIntOrUInt
        //=--------------------------------------=
        }   else {
            let low = Low(truncatingIfNeeded: source)
            self.init(descending: HL(high, low))
        }
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Magnitude
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init?(_exactlyAsMagnitude source: Magnitude) {
        //=--------------------------------------=
        if  Self.isSigned, source.mostSignificantBit {
            return nil
        }
        //=--------------------------------------=
        self.init(_truncatingIfNeededAsMagnitude: source)
    }
    
    @_transparent @usableFromInline init(_clampingAsMagnitude source: Magnitude) {
        self = Self(_exactlyAsMagnitude: source) ?? Self.max
    }
    
    @_transparent @usableFromInline init(_truncatingIfNeededAsMagnitude source: Magnitude) {
        self.init(bitPattern: source)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Binary Integer
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init?(_exactlyAsBinaryInteger source: some BinaryInteger) {
        let (value, words, index, sign, isLessThanZero) = Self._copy(source)
        let isOK = value.isLessThanZero == isLessThanZero && words[index...].allSatisfy({ $0 == sign })
        if  isOK { self = value } else { return nil }
    }
    
    @_transparent @usableFromInline init(_clampingAsBinaryInteger source: some BinaryInteger) {
        let (value, words, index, sign, isLessThanZero) = Self._copy(source)
        let isOK = value.isLessThanZero == isLessThanZero && words[index...].allSatisfy({ $0 == sign })
        self = isOK ? value : isLessThanZero ? Self.min : Self.max
    }
    
    @_transparent @usableFromInline init(_truncatingIfNeededAsBinaryInteger source: some BinaryInteger) {
        self = Self._copy(source).value
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable static func _copy<T>(_ source: T) -> (value: Self, words: T.Words, index: Int, sign: UInt, isLessThanZero: Bool) where T: BinaryInteger {
        let words: T.Words = source.words
        let isLessThanZero: Bool = T.isSigned && words.last?.mostSignificantBit == true
        let sign = UInt(repeating: isLessThanZero)
        //=--------------------------------------=
        var index = words.startIndex
        let value = Self.fromUnsafeMutableWords { VALUE in
            //=----------------------------------=
            var valueIndex = VALUE.startIndex
            var wordsIndex = words.startIndex
            defer {  index = wordsIndex  }
            //=----------------------------------=
            while wordsIndex != words.endIndex {
                guard valueIndex != VALUE.endIndex else { return }
                VALUE[valueIndex] = words[wordsIndex]
                VALUE.formIndex(after: &valueIndex)
                words.formIndex(after: &wordsIndex)
            }
            //=----------------------------------=
            while valueIndex != VALUE.endIndex {
                VALUE[valueIndex] = sign
                VALUE.formIndex(after: &valueIndex)
            }
        }
        //=--------------------------------------=
        return (value: value, words: words, index: index, sign: sign, isLessThanZero: isLessThanZero)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Literal
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(integerLiteral source: StaticBigInt) {
        guard let value = Self(_exactlyIntegerLiteral: source) else {
            preconditionFailure("Integer literal '\(source)' overflows when stored into '\(Self.description)'.")
        }
        
        self = value
    }
    
    @inlinable init?(_exactlyIntegerLiteral source: StaticBigInt) {
        let   isOK: Bool;  switch Self.isSigned {
        case  true: isOK = source.bitWidth <= Self.bitWidth
        case false: isOK = source.bitWidth <= Self.bitWidth + 1 && source.signum() >= 0 }
        guard isOK  else { return nil }
        self = Self.fromUnsafeMutableWords({ for i in $0.indices { $0[i] = source[i] } })
    }
}
