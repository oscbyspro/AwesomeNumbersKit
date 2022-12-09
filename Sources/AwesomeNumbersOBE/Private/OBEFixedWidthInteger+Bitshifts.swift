//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Bitshifts
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, rhs: Self) {
        if  rhs.isLessThanZero { lhs >>= 0 - rhs; return }
        if !rhs.high.isZero || rhs.low >= Self.bitWidth { lhs = 0; return }
        lhs &<<= rhs
    }
    
    @inlinable public static func >>=(lhs: inout Self, rhs: Self) {
        if  rhs.isLessThanZero { lhs <<= 0 - rhs; return }
        if !rhs.high.isZero || rhs.low >= Self.bitWidth { lhs = Self(repeating: lhs.isLessThanZero); return }
        lhs &>>= rhs
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Bitrotations
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: Self) {
        let rhs = rhs & Self(Self.bitWidth &- 1)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        guard rhs.low < Low.bitWidth else {
            lhs.high = High(truncatingIfNeeded: lhs.low &<< (rhs.low &- Low(Low.bitWidth)))
            lhs.low = 0
            return
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        guard !rhs.low.isZero else { return }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        lhs.high &<<= High(rhs.low)
        lhs.high   |= High(truncatingIfNeeded: lhs.low &>> (Low(Low.bitWidth) &- rhs.low))
        lhs.low  &<<= rhs.low
    }
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: Self) {
        let rhs = rhs & Self(Self.bitWidth &- 1)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        guard rhs.low < Low.bitWidth else {
            lhs.low  = Low(truncatingIfNeeded: lhs.high &>> High(rhs.low &- Low(Low.bitWidth)))
            lhs.high = High(repeating: lhs.high.isLessThanZero)
            return
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        guard !rhs.low.isZero else { return }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        lhs.low  &>>= rhs.low
        lhs.low    |= Low(truncatingIfNeeded: lhs.high &<< High(Low(Low.bitWidth) &- rhs.low))
        lhs.high &>>= High(rhs.low)
    }
}
