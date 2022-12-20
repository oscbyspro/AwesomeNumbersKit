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
@frozen @usableFromInline struct ANKFullWidth<High, Low>: WoRdS, ANKFullWidthCollection,
AwesomeLargeFixedWidthInteger, CustomDebugStringConvertible where High: AwesomeFixedWidthInteger,
Low: AwesomeUnsignedFixedWidthInteger, Low == Low.Magnitude {
    
    @usableFromInline typealias IntegerLiteralType = Int
    
    @usableFromInline typealias DoubleWidth = ANKFullWidth<Self, Magnitude>
    
    @usableFromInline typealias Magnitude = ANKFullWidth<High.Magnitude, Low.Magnitude>
        
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
    
    @inlinable public init(ascending digits: (low: Low, high: High)) {
        (self.low, self.high) = digits
    }
    
    @inlinable public init(descending digits: (high: High, low: Low)) {
        (self.high, self.low) = digits
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init() {
        self.init(descending:(High(), Low()))
    }
    
    @inlinable init(_ bit: Bool) {
        self.init(descending:(High(), Low(bit)))
    }
    
    @inlinable init(repeating bit: Bool) {
        self.init(descending:(High(repeating: bit), Low(repeating: bit)))
    }
    
    @inlinable init(repeating word: UInt) {
        self = Self.fromUnsafeTemporaryWords({ for index in $0.indices { $0[unchecked: index] = word } })
    }
    
    @inlinable static func uninitialized() -> Self {
        self.fromUnsafeTemporaryWords({  _ in  })
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init<T>(bitPattern: ANKFullWidth<T, Low>) where T.Magnitude == High.Magnitude {
        self = unsafeBitCast(bitPattern,  to: Self.self) // signitude or magnitude
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var ascending: LH<Low, High> {
        LH(low, high)
    }
    
    @inlinable var descending: HL<High, Low> {
        HL(high, low)
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

extension ANKFullWidth:   AwesomeSignedLargeBinaryInteger where High:   AwesomeSignedFixedWidthInteger { }
extension ANKFullWidth: AwesomeUnsignedLargeBinaryInteger where High: AwesomeUnsignedFixedWidthInteger { }

extension ANKFullWidth:   AwesomeSignedLargeFixedWidthInteger where High:   AwesomeSignedFixedWidthInteger { }
extension ANKFullWidth: AwesomeUnsignedLargeFixedWidthInteger where High: AwesomeUnsignedFixedWidthInteger { }