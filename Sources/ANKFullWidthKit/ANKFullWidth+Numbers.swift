//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit

//*============================================================================*
// MARK: * ANK x Full Width x Numbers
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public static var min: Self {
        Self(high: High.min, low: Low.min)
    }
    
    @inlinable public static var max: Self {
        Self(high: High.max, low: Low.max)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(integerLiteral source: StaticBigInt) {
        guard let value = Self(exactlyIntegerLiteral: source) else {
            preconditionFailure("\(Self.description) cannot represent \(source)")
        }
        
        self = value
    }
    
    @inlinable init?(exactlyIntegerLiteral source: StaticBigInt) {
        guard  Self.isSigned
        ? source.bitWidth <= Self.bitWidth
        : source.bitWidth <= Self.bitWidth + 1 && source.signum() >= 0
        else { return nil  }
        self = Self.fromUnsafeMutableWords({ for i in $0.indices { $0[i] = source[i] } })
    }
    
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
            preconditionFailure("\(Self.description) cannot represent \(source)")
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
            self.init(exactlyAsIntOrUInt: source)
            return
        }
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            self.init(exactlyAsIntOrUInt: source)
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
        self.init(exactlyAsBinaryInteger: source)
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
            self.init(clampingAsIntOrUInt: source)
            return
        }
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            self.init(clampingAsIntOrUInt: source)
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
        self.init(clampingAsBinaryInteger: source)
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
            self.init(truncatingIfNeededAsIntOrUInt: source)
            return
        }
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            self.init(truncatingIfNeededAsIntOrUInt: source)
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
        self.init(truncatingIfNeededAsBinaryInteger: source)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Int Or UInt
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init?(exactlyAsIntOrUInt source: some ANKCoreInteger<UInt>) {
        //=--------------------------------------=
        // Int
        //=--------------------------------------=
        if !Self.isSigned, source.isLessThanZero {
            return nil
        }
        //=--------------------------------------=
        // some ANKCoreInteger<UInt>
        //=--------------------------------------=
        self.init(truncatingIfNeededAsIntOrUInt: source)
    }
    
    @_transparent @usableFromInline init(clampingAsIntOrUInt source: some ANKCoreInteger<UInt>) {
        self = Self(exactlyAsIntOrUInt: source) ?? Self()
    }
    
    @_transparent @usableFromInline init(truncatingIfNeededAsIntOrUInt source: some ANKCoreInteger<UInt>) {
        assert(Low.bitWidth >= source.bitWidth)
        //=--------------------------------------=
        let high = High(repeating: source.isLessThanZero)
        //=--------------------------------------=
        // UInt
        //=--------------------------------------=
        if  let source = source as? UInt {
            let low = Low(_truncatingBits: source)
            self.init(high: high, low: low)
        //=--------------------------------------=
        // Int, some ANKCoreInteger<UInt>
        //=--------------------------------------=
        }   else {
            let low = Low(truncatingIfNeeded: source)
            self.init(high: high, low: low)
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
    
    @_transparent @usableFromInline init?(exactlyAsMagnitude source: Magnitude) {
        //=--------------------------------------=
        if  Self.isSigned, source.mostSignificantBit {
            return nil
        }
        //=--------------------------------------=
        self.init(truncatingIfNeededAsMagnitude: source)
    }
    
    @_transparent @usableFromInline init(clampingAsMagnitude source: Magnitude) {
        self = Self(exactlyAsMagnitude: source) ?? Self.max
    }
    
    @_transparent @usableFromInline init(truncatingIfNeededAsMagnitude source: Magnitude) {
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
    
    @_transparent @usableFromInline init?(exactlyAsBinaryInteger source: some BinaryInteger) {
        let (value, remainders, sign) = Self.truncating(source)
        let isOK = value.isLessThanZero != sign.isZero && remainders.allSatisfy({ $0 == sign })
        if  isOK { self = value } else { return nil }
    }

    @_transparent @usableFromInline init(clampingAsBinaryInteger source: some BinaryInteger) {
        let (value, remainders, sign) = Self.truncating(source)
        let isOK = value.isLessThanZero != sign.isZero && remainders.allSatisfy({ $0 == sign })
        self = isOK ? value : sign.isZero ? Self.max : Self.min
    }

    @_transparent @usableFromInline init(truncatingIfNeededAsBinaryInteger source: some BinaryInteger) {
        self = Self.truncating(source).value
    }

    @inlinable static func truncating<T>(_ source: T) -> (value: Self, remainders: T.Words.SubSequence, sign: UInt) where T: BinaryInteger {
        let words: T.Words = source.words
        var wordsIndex = words.startIndex
        let sign  = UInt(repeating: T.isSigned && words.last?.mostSignificantBit == true)
        let value = Self.fromUnsafeMutableWords { VALUE in
            var valueIndex = VALUE.startIndex
            
            while wordsIndex != words.endIndex {
                guard valueIndex != VALUE.endIndex else { return }
                VALUE[valueIndex] = words[wordsIndex]
                VALUE.formIndex(after: &valueIndex)
                words.formIndex(after: &wordsIndex)
            }
            
            while valueIndex != VALUE.endIndex {
                VALUE[valueIndex] = sign
                VALUE.formIndex(after: &valueIndex)
            }
        }
        //=--------------------------------------=
        return (value: value, remainders: words[wordsIndex...], sign: sign)
    }
}
