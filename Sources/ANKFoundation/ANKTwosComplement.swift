//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Two's Complement
//*============================================================================*

public protocol ANKTwosComplement<BitPattern>: ANKBinaryInteger & ANKBitPattern where Magnitude: ANKTwosComplement { }

//=----------------------------------------------------------------------------=
// MARK: + Details x Sign & Magnitude
//=----------------------------------------------------------------------------=

extension ANKTwosComplement where Magnitude.BitPattern == BitPattern {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(asSignMagnitude  magnitude: Magnitude, uncheckedIsLessThanZero: Bool) {
        guard let value = Self(exactlyAsSignMagnitude: magnitude, uncheckedIsLessThanZero: uncheckedIsLessThanZero) else {
            let source = (sign: uncheckedIsLessThanZero, magnitude: magnitude)
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
    @inlinable public init?(exactlyAsSignMagnitude magnitude: Magnitude, uncheckedIsLessThanZero: Bool) {
        assert(!uncheckedIsLessThanZero || !magnitude.isZero, "negative zero is not less than zero")
        //=--------------------------------------=
        if  Self.isSigned {
            self.init(truncatingIfNeededAsSignMagnitude: magnitude, uncheckedIsLessThanZero: uncheckedIsLessThanZero)
            if uncheckedIsLessThanZero != self.isLessThanZero { return nil }
        //=--------------------------------------=
        }   else {
            if uncheckedIsLessThanZero { return nil }; self.init(bitPattern: magnitude)
        }
    }
    
    @inlinable public init(clampingAsSignMagnitude magnitude: Magnitude, uncheckedIsLessThanZero: Bool) where Self: FixedWidthInteger {
        assert(!uncheckedIsLessThanZero || !magnitude.isZero, "negative zero is not less than zero")
        //=--------------------------------------=
        if  Self.isSigned {
            self.init(truncatingIfNeededAsSignMagnitude: magnitude, uncheckedIsLessThanZero: uncheckedIsLessThanZero)
            if uncheckedIsLessThanZero != self.isLessThanZero { self = uncheckedIsLessThanZero ? .min : .max }
        //=--------------------------------------=
        }   else {
            if uncheckedIsLessThanZero { self.init(); return }; self.init(bitPattern: magnitude)
        }
    }
    
    @inlinable public init(truncatingIfNeededAsSignMagnitude magnitude: Magnitude, uncheckedIsLessThanZero: Bool) {
        assert(!uncheckedIsLessThanZero || !magnitude.isZero, "negative zero is not less than zero")
        self.init(bitPattern:  magnitude);  if uncheckedIsLessThanZero { self.formTwosComplement() }
    }
}
