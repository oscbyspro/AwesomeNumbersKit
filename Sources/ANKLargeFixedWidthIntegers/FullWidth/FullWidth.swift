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
// MARK: * ANK x Full Width
//*============================================================================*

/// The internal storage model for `(U)Int(128/256/512)`.
///
/// ```
/// High.bitWidth / UInt.bitWidth >= 1
/// Low .bitWidth / UInt.bitWidth >= 1
/// Self.bitWidth / UInt.bitWidth >= 2
/// ```
///
/// ```
/// High.bitWidth % UInt.bitWidth == 0
/// Low .bitWidth % UInt.bitWidth == 0
/// Self.bitWidth % UInt.bitWidth == 0
/// ```
///
@frozen @usableFromInline struct ANKFullWidth<High, Low>: WoRdS, AwesomeTextualizableInteger,
ANKFullWidthCollection, AwesomeLargeFixedWidthInteger, CustomDebugStringConvertible where
High: AwesomeLargeFixedWidthInteger, Low: AwesomeUnsignedLargeFixedWidthInteger<UInt>,
Low == Low.Magnitude, High.Digit: AwesomeIntOrUInt, High.Magnitude.Digit == UInt {
    
    public typealias Digit = High.Digit
    
    @usableFromInline typealias IntegerLiteralType = Int
        
    @usableFromInline typealias Magnitude = ANKFullWidth<High.Magnitude, Low>
    
    @usableFromInline typealias Plus1 = ANKFullWidth<Digit, Magnitude>
    
    @usableFromInline typealias DoubleWidth = ANKFullWidth<Self, Magnitude>
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable static var min: Self {
        Self(descending:(High.min, Low.min))
    }
    
    @inlinable static var max: Self {
        Self(descending:(High.max, Low.max))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    #if _endian(big)
    public var high: High
    public var low:  Low
    #else
    public var low:  Low
    public var high: High
    #endif
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(ascending  digits: LH<Low, High>) {
        (self.low, self.high) = digits
    }
    
    @_transparent public init(descending digits: HL<High, Low>) {
        (self.high, self.low) = digits
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init() {
        self.init(descending:(High(), Low()))
    }
    
    @inlinable init(bit: Bool) {
        self.init(descending:(High(), Low(bit: bit)))
    }
    
    @inlinable init(repeating bit: Bool) {
        self.init(descending:(High(repeating:  bit), Low(repeating:  bit)))
    }
    
    @inlinable init(repeating word: UInt) {
        self.init(descending:(High(repeating: word), Low(repeating: word)))
    }
    
    @inlinable init(digit: Digit) {
        self.init(descending:(High(repeating: digit.isLessThanZero), Low(digit: UInt(bitPattern: digit))))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init<T>(bitPattern: ANKFullWidth<T, Low>) where T.Magnitude == High.Magnitude {
        self = unsafeBitCast(bitPattern, to: Self.self) // signitude or magnitude
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Conditional Conformances
//*============================================================================*

extension ANKFullWidth:   SignedNumeric where High:   SignedNumeric { }
extension ANKFullWidth:   SignedInteger where High:   SignedInteger { }
extension ANKFullWidth: UnsignedInteger where High: UnsignedInteger { }

extension ANKFullWidth:   AwesomeSignedInteger where High:   AwesomeSignedInteger { }
extension ANKFullWidth: AwesomeUnsignedInteger where High: AwesomeUnsignedInteger { }

extension ANKFullWidth:   AwesomeSignedFixedWidthInteger where High:   AwesomeSignedFixedWidthInteger { }
extension ANKFullWidth: AwesomeUnsignedFixedWidthInteger where High: AwesomeUnsignedFixedWidthInteger { }

extension ANKFullWidth:   AwesomeSignedLargeBinaryInteger where High:   AwesomeSignedLargeBinaryInteger< Int> { }
extension ANKFullWidth: AwesomeUnsignedLargeBinaryInteger where High: AwesomeUnsignedLargeBinaryInteger<UInt> { }

extension ANKFullWidth:   AwesomeSignedLargeFixedWidthInteger where High:   AwesomeSignedLargeFixedWidthInteger< Int> { }
extension ANKFullWidth: AwesomeUnsignedLargeFixedWidthInteger where High: AwesomeUnsignedLargeFixedWidthInteger<UInt> { }
