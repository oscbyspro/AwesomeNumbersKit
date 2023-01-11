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
public protocol ANKBinaryInteger: BinaryInteger, ANKBitPatternConvertible where Magnitude: ANKUnsignedInteger {
    
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

//*============================================================================*
// MARK: * ANK x Binary Integer x Defaults
//*============================================================================*

extension ANKBinaryInteger where Magnitude.BitPattern == BitPattern {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_ source: ANKSigned<Magnitude>) {
        guard let value = Self(exactly: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
    @inlinable public init?(exactly source: ANKSigned<Magnitude>) {
        let sourceIsLessThanZero = source.isLessThanZero
        //=--------------------------------------=
        if  Self.isSigned {
            self.init(bitPattern: source.magnitude)
            if sourceIsLessThanZero {  self.formTwosComplement()  }
            if sourceIsLessThanZero != self.isLessThanZero { return nil }
        //=--------------------------------------=
        }   else {
            if sourceIsLessThanZero {  return nil }
            self.init(bitPattern: source.magnitude)
        }
    }
    
    @inlinable public init(clamping source: ANKSigned<Magnitude>) where Self: FixedWidthInteger {
        let sourceIsLessThanZero = source.isLessThanZero
        //=--------------------------------------=
        if  Self.isSigned {
            self.init(bitPattern: source.magnitude)
            if sourceIsLessThanZero {  self.formTwosComplement()  }
            if sourceIsLessThanZero != self.isLessThanZero { self = sourceIsLessThanZero ? .min : .max }
        //=--------------------------------------=
        }   else {
            if sourceIsLessThanZero {  self.init(); return }
            self.init(bitPattern: source.magnitude)
        }
    }
    
    @inlinable public init(truncatingIfNeeded source: ANKSigned<Magnitude>) {
        let sourceIsLessThanZero = source.isLessThanZero
        self.init(bitPattern: source.magnitude)
        if  sourceIsLessThanZero { self.formTwosComplement() }
    }
}
