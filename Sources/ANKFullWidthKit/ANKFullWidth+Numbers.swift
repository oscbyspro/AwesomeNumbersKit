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
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(exactlyAsMagnitude: source)
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
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(clampingAsMagnitude: source)
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
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(bitPattern: source)
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
    
    @inlinable init?(exactlyAsIntOrUInt source: some ANKCoreInteger<UInt>) {
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
    
    @inlinable init(clampingAsIntOrUInt source: some ANKCoreInteger<UInt>) {
        self = Self(exactlyAsIntOrUInt: source) ?? Self()
    }
    
    @inlinable init(truncatingIfNeededAsIntOrUInt source: some ANKCoreInteger<UInt>) {
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
    
    @inlinable init?(exactlyAsMagnitude source: Magnitude) {
        //=--------------------------------------=
        if  Self.isSigned, source.mostSignificantBit {
            return nil
        }
        //=--------------------------------------=
        self.init(bitPattern: source)
    }
    
    @inlinable init(clampingAsMagnitude source: Magnitude) {
        self = Self(exactlyAsMagnitude: source) ?? Self.max
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Binary Integer
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init?(exactlyAsBinaryInteger source: some BinaryInteger) {
        let (value, remainders, sign) = Self.truncating(source)
        let isOK = value.isLessThanZero != sign.isZero && remainders.allSatisfy({ $0 == sign })
        if  isOK { self = value } else { return nil }
    }

    @inlinable init(clampingAsBinaryInteger source: some BinaryInteger) {
        let (value, remainders, sign) = Self.truncating(source)
        let isOK = value.isLessThanZero != sign.isZero && remainders.allSatisfy({ $0 == sign })
        self = isOK ? value : sign.isZero ? Self.max : Self.min
    }

    @inlinable init(truncatingIfNeededAsBinaryInteger source: some BinaryInteger) {
        self = Self.truncating(source).value
    }

    @inlinable static func truncating<T>(_ source: T) -> (value: Self, remainders: T.Words.SubSequence, sign: UInt) where T: BinaryInteger {
        let words: T.Words = source.words
        let isLessThanZero: Bool = T.isSigned && words.last?.mostSignificantBit == true
        let sign = UInt(repeating: isLessThanZero)
        //=--------------------------------------=
        let value = Self.fromUnsafeMutableWords { value in
            for index in value.indices {
                value[index] = index < words.count ? words[words.index(words.startIndex, offsetBy: index)] : sign
            }
        }
        //=--------------------------------------=
        return (value: value, remainders: words.dropFirst(value.count), sign: sign)
    }
}
