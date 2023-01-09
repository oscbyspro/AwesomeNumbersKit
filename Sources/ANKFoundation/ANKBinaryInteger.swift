//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Binary Integer
//*============================================================================*

/// A `BinaryInteger` with additional requirements and capabilities.
///
/// All binary integers in `AwesomeNumbersKit` conform to `ANKBinaryInteger`.
///
/// **Two's Complement Semantics**
///
/// Like `BinaryInteger` all bitwise operations have two's complement semantics.
///
public protocol ANKBinaryInteger: BinaryInteger where Magnitude: ANKUnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bit: Bool)
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var isZero: Bool { get }
    
    @inlinable var isLessThanZero: Bool { get }
    
    @inlinable var isMoreThanZero: Bool { get }
    
    @inlinable var mostSignificantBit:  Bool { get }
        
    @inlinable var leastSignificantBit: Bool { get }
    
    @inlinable var isPowerOf2: Bool { get }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func divideReportingOverflow(by divisor: Self) -> Bool
    
    @inlinable func dividedReportingOverflow(by divisor: Self) -> PVO<Self>
    
    @inlinable mutating func formRemainderReportingOverflow(by divisor: Self) -> Bool
    
    @inlinable func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self>
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Two's Complement
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func formTwosComplement()
    
    @inlinable func twosComplement() -> Self
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Sign & Magnitude
    //=------------------------------------------------------------------------=
    
    init(_ source: ANKSigned<Magnitude>)
    
    init?(exactly source: ANKSigned<Magnitude>)
    
    init(clamping source: ANKSigned<Magnitude>)
    
    init(truncatingIfNeeded source: ANKSigned<Magnitude>)
}

//=----------------------------------------------------------------------------=
// MARK: + Details where Self: Fixed Width Integer
//=----------------------------------------------------------------------------=

extension ANKBinaryInteger where Self: FixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var isPowerOf2: Bool {
        self.nonzeroBitCount == 1
    }
}

//*============================================================================*
// MARK: * ANK x Binary Integer x Signed
//*============================================================================*

public protocol ANKSignedInteger: ANKBinaryInteger, SignedInteger { }

//*============================================================================*
// MARK: * ANK x Binary Integer x Unsigned
//*============================================================================*

public protocol ANKUnsignedInteger: ANKBinaryInteger, UnsignedInteger { }
