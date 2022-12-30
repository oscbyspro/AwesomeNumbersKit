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

/// The internal storage model for `ANK(U)Int(128/256/512)`.
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
@frozen @usableFromInline struct _ANKFullWidth<High, Low>: WoRdS, ANKBitPattern,
ANKFullWidthCollection, ANKLargeFixedWidthInteger, ANKTextualizableInteger where
High: ANKLargeFixedWidthInteger, Low: ANKUnsignedLargeFixedWidthInteger<UInt>,
Low == Low.Magnitude, High.Digit: ANKIntOrUInt, High.Magnitude.Digit == UInt {
        
    public typealias Digit = High.Digit
        
    public typealias IntegerLiteralType = Int
    
    public typealias BitPattern = Magnitude
        
    public typealias Magnitude = _ANKFullWidth<High.Magnitude, Low>
    
    @usableFromInline typealias Plus1 = _ANKFullWidth<Digit, Magnitude>
    
    @usableFromInline typealias DoubleWidth = _ANKFullWidth<Self, Magnitude>
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var min: Self {
        Self(descending:(High.min, Low.min))
    }
    
    @inlinable public static var max: Self {
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
    
    @inlinable public init() {
        self.init(descending:(High(), Low()))
    }
    
    @inlinable public init(bit: Bool) {
        self.init(descending:(High(), Low(bit: bit)))
    }
    
    @inlinable public init(repeating bit: Bool) {
        self.init(descending:(High(repeating:  bit), Low(repeating:  bit)))
    }
    
    @inlinable public init(repeating word: UInt) {
        self.init(descending:(High(repeating: word), Low(repeating: word)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Bit Pattern
    //=------------------------------------------------------------------------=
    
    @_transparent public init(bitPattern source: BitPattern) {
        self = unsafeBitCast(source, to: Self.self)
    }
        
    @_transparent public var bitPattern: BitPattern {
        return unsafeBitCast(self, to: BitPattern.self)
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Conditional Conformances
//*============================================================================*

extension _ANKFullWidth:   SignedNumeric where High:   SignedNumeric { }
extension _ANKFullWidth:   SignedInteger where High:   SignedInteger { }
extension _ANKFullWidth: UnsignedInteger where High: UnsignedInteger { }

extension _ANKFullWidth:   ANKSignedInteger where High:   ANKSignedInteger { }
extension _ANKFullWidth: ANKUnsignedInteger where High: ANKUnsignedInteger { }

extension _ANKFullWidth:   ANKSignedFixedWidthInteger where High:   ANKSignedFixedWidthInteger { }
extension _ANKFullWidth: ANKUnsignedFixedWidthInteger where High: ANKUnsignedFixedWidthInteger { }

extension _ANKFullWidth:   ANKSignedLargeBinaryInteger where High:   ANKSignedLargeBinaryInteger< Int> { }
extension _ANKFullWidth: ANKUnsignedLargeBinaryInteger where High: ANKUnsignedLargeBinaryInteger<UInt> { }

extension _ANKFullWidth:   ANKSignedLargeFixedWidthInteger where High:   ANKSignedLargeFixedWidthInteger< Int> { }
extension _ANKFullWidth: ANKUnsignedLargeFixedWidthInteger where High: ANKUnsignedLargeFixedWidthInteger<UInt> { }
