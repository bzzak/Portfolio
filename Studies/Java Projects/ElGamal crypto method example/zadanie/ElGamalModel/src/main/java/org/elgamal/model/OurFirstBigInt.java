package org.elgamal.model;

import java.util.*;

import static java.lang.Math.*;

public class OurFirstBigInt {
    public static OurFirstBigInt zero = new OurFirstBigInt(0);
    public static OurFirstBigInt one = new OurFirstBigInt(1);
    public static OurFirstBigInt two = new OurFirstBigInt(2);
    public static OurFirstBigInt NaN = null;
    public static Random rng = new Random();

    private byte[] mag;
    private boolean sign; // true = +, false = -
    // zero is positive
    public int getMagLength(){
        return mag.length;
    }
    public byte[] getMag(){
        return mag;
    }


    // ------------------------------ CONSTRUCTORS ---------- //

    public OurFirstBigInt(String s) {
        int idxStr = 0;
        if(s.charAt(0) == 45) { // 45: -
            sign = false;
            idxStr++;
        } else {
            sign = true;
        }
        // Skip leading zeros and compute number of digits in magnitude
        while (idxStr < s.length() && Character.digit(s.charAt(idxStr), 16) == 0) {
            idxStr++;
        }
        if(idxStr == s.length()) { // given string is a zero
            mag = new byte[0];
            sign = true;
            return;
        }
        // cursor = number of zeros
        int magLength = (int)Math.ceil((s.length() - idxStr) / 2.0f); // two chars on each byte
        mag = new byte[magLength];
        int idxMag = 0;
        if((s.length() - idxStr) % 2 == 1) {
            String byteStr = s.substring(idxStr, idxStr + 1);
            byte val = (byte)Integer.parseInt(byteStr, 16);
            mag[idxMag] = (val); // why shifting causes casting from byte to int???
            idxMag++;
            idxStr++;
        }
        // idxStr is always even at this point
        while(true) {
            if(idxStr + 2 <= s.length()) {
                String byteStr = s.substring(idxStr, idxStr + 2);
                int i = Integer.parseInt(byteStr, 16);
                mag[idxMag] = (byte) (i);
                idxMag++;
                idxStr += 2;
            } else {
                break;
            }
        }
        if(idxMag != magLength) {
            System.out.println("something bad had happened");
        }
    }

    // sets sign = true
    public OurFirstBigInt(byte[] mag) {
        this.mag = deleteLeadingZeros(mag);
        sign = true;
    }

    public OurFirstBigInt(byte[] mag, boolean sign) {
        this.mag = deleteLeadingZeros(mag);
        this.sign = sign;
    }

    public OurFirstBigInt(OurFirstBigInt b) {
        this.mag = new byte[b.mag.length];
        System.arraycopy(b.mag, 0, this.mag, 0, b.mag.length);
        this.sign = b.sign;
    }

    public OurFirstBigInt(LinkedList<Byte> nmag) {
        if(nmag.size() == 0) {
            mag = new byte[0];
            return;
        }
        int zeroIdx = 0;
        while(nmag.get(zeroIdx) == 0) {
            zeroIdx++;
            if(zeroIdx == nmag.size()) {
                mag = new byte[0];
                return; // one case???
            }
        }
        mag = new byte[nmag.size() - zeroIdx];
        sign = true;

        for (int i = 0; i < mag.length; i++, zeroIdx++) {
            mag[i] = nmag.get(zeroIdx); // O(nlogn) fix!!
        }
    }

    // long is treated as unsigned
    public OurFirstBigInt(long number) {
        if(number == 0) {
            mag = new byte[0];
            sign = true;
            return;
        }
        int byteLen = 0;
        while(number >= (1L << (byteLen * 8))) {
            byteLen++;
        }
        mag = new byte[byteLen];
        sign = true;
        for(int i = byteLen - 1; i >= 0; i--) {
            mag[i] = (byte) (number >>> ((mag.length - i - 1) * 8));
        }
    }

    // ------------------------------ RANDOM ---------- //
    // NOTE: random functions always return positive
    //
    // getRandom(int) and getRandomOdd returns number from range
    //      2^(bitlength - 1) <= r < 2^(bitlength)
    // getRandom(bound) returns number from range
    //      1 <= r < bound

    public static OurFirstBigInt getRandom(int bitLength) {
        int length = (int) ceil(bitLength / 8.f);
        byte[] newMag = getExactLengthRandMag(length);
        newMag[0] = getRandByte(bitLength);
        return new OurFirstBigInt(newMag);
    }

    public static OurFirstBigInt getRandomOdd(int bitLength) {
        int length = (int) ceil(bitLength / 8.f);
        byte[] newMag = getExactLengthRandMag(length);
        while(newMag[length-1] % 2 == 0) {
            newMag[length-1] = (byte) (rng.nextInt());
        }
        newMag[0] = getRandByte(bitLength);
        return new OurFirstBigInt(newMag);
    }

    private static byte getRandByte(int bitLength) {
        int byteBound = 0;
        for(int i = 0; i < bitLength % 8; i++) {
            byteBound += 1 << i;
        }
        if(byteBound == 0) {
            byteBound = 0xff;
        }
        return (byte) rng.nextInt(byteBound);
    }

    public static OurFirstBigInt getRandom(OurFirstBigInt bound) {
        byte[] new_mag = getRandMag(bound.mag.length);
        while(true) {
            for(int idx = 0; idx < bound.mag.length; idx++) {
                int a = toInt(new_mag[idx]), b = toInt(bound.mag[idx]); // a = 21, b = 00
                if(a > b) {
                    if(b != 0) {
                        new_mag[idx] = (byte) (rng.nextInt(b));
                        return new OurFirstBigInt(new_mag);
                    } else {
                        new_mag[idx] = 0;
                    }
                } else if (a < b) {
                    return new OurFirstBigInt(new_mag);
                }
            }
            // drawn same number as n
            new_mag = getRandMag(bound.mag.length);
        }
    }

    private static byte[] getExactLengthRandMag(int length) {
        byte[] newMag = new byte[length];
        rng.nextBytes(newMag);
        while(newMag[0] == 0) { // ensure that returned number does not have leading zeros
            newMag[0] = (byte) (rng.nextInt());
        }
        return newMag;
    }

    private static byte[] getRandMag(int length) {
        byte[] newMag = new byte[length];
        rng.nextBytes(newMag);
        while(true) { // check if new number != 0
            for(int i = 0; i < newMag.length; i++) {
                if(newMag[i] != 0)
                    return newMag;
            }
            rng.nextBytes(newMag);
        }

    }

    // ------------------------------ PRIMES ---------- //

    // https://www.geeksforgeeks.org/how-to-generate-large-prime-numbers-for-rsa-algorithm/
    public static OurFirstBigInt probablePrime(int bitLength) {
        if(bitLength < 16) {
            int byteBound = 0;
            for(int i = 0; i < bitLength; i++) {
                byteBound += 1 << i;
            }
            int rand = rng.nextInt(byteBound);
            while(!isIntPrime(rand)) {
                rand = rng.nextInt(byteBound);
            }
            return new OurFirstBigInt(rand);
        }
        OurFirstBigInt p = getLowLevelPrime(bitLength);
        while(!millerRabinPassed(p, 5)) {
            p = getLowLevelPrime(bitLength);
        }
        return p;
    }

    private static final int[] firstPrimes = {
            3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67,
            71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139,
            149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223,
            227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293,
            307, 311, 313, 317, 331, 337, 347, 349,
    };

    public static OurFirstBigInt getLowLevelPrime(int bitLength) {
        OurFirstBigInt p = null;
        boolean generated = false;
        while (!generated) {
            p = getRandomOdd(bitLength);
            generated = true;
            for (int q : firstPrimes) {
                if (p.mod(new OurFirstBigInt(q)).equals(zero)) {
                    generated = false;
                }
            }
        }
        return p;
    }

    public static boolean millerRabinPassed(OurFirstBigInt n, int iterations) {
        OurFirstBigInt d = n.subtract(one); // d = n - 1

        while (!d.isOdd())          //  while d % 2 == 0
            d = d.shiftRight(1);    //      d /= 2

        for(int i = 0; i < iterations; i++) {
            if(!millerTest(n, d))
                return false;
        }
        return true;
    }

    private static boolean millerTest(OurFirstBigInt n, OurFirstBigInt d) {
        // https://www.geeksforgeeks.org/how-to-generate-large-prime-numbers-for-rsa-algorithm/
        // https://www.geeksforgeeks.org/primality-test-set-3-miller-rabin/
        OurFirstBigInt a = getRandom( n.subtract(two) ); // a = random(0, n-2)
        while(!a.geq(two))                      // while a < 2
            a = getRandom( n.subtract(two) );   //     a = random(0, n-2)


        OurFirstBigInt x = a.modPow(d, n); // x = a^d % n
        OurFirstBigInt nMinOne = n.subtract(one);
        if (x.equals(one) || x.equals(nMinOne)) // if (x == 1 || x == n - 1)
            return true;

        while (!d.equals(nMinOne)) {
            x = x.multiply(x).mod(n);   // x = x^2 % n
            d = d.multiply(two);        // d *= 2

            if (x.equals(one)) // if (x == 1)
                return false;
            if (x.equals(nMinOne)) // if (x == n - 1)
                return true;
        }
        return false;
    }

    // ------------------------------ MATH OPERATIONS ---------- //

    public OurFirstBigInt add(OurFirstBigInt val) {
        if(mag.length == 0) {
            return val;
        }
        if(val.mag.length == 0) {
            return this;
        }
        if(!this.sign && val.sign) { // this negative
            return val.subtract(new OurFirstBigInt(this.mag, true));
        }
        if(this.sign && !val.sign) { // val negative
            return this.subtract(new OurFirstBigInt(val.mag, true));
        }
        // both positive - standard
        // both negative - add same as positive, sign stays the same
        boolean retSign = this.sign;

        byte[] x = this.mag;
        byte[] y = val.mag;
        if(x.length < y.length) {
            byte[] tmp = x;
            x = y;
            y = tmp;
        }
        // x > y
        int xIdx = x.length - 1;
        int yIdx = y.length - 1;
        byte[] result = new byte[x.length];
        boolean carry = false;
        int sum;
        while(xIdx >= 0) {
            if(carry) {
                sum = 1;
                carry = false;
            } else {
                sum = 0;
            }
            sum += toInt(x[xIdx]);
            if(yIdx >= 0) {
                sum += toInt(y[yIdx]);
            }

            if(sum >= (1 << 8)) {
                carry = true;
            }
            result[xIdx] = (byte) (sum & 0b11111111);

            xIdx--;
            yIdx--;
        }
        if(carry) { // rewrite if out of index
            byte[] resized = new byte[x.length + 1];
            System.arraycopy(result, 0, resized, 1, result.length);
            resized[0] = 1;
            return new OurFirstBigInt(resized, retSign);
        }
        return new OurFirstBigInt(result, retSign);
    }

    public OurFirstBigInt subtract(OurFirstBigInt val) {
        if(val.equals(this)) {
            return zero;
        }
        if(!val.sign) {
            return this.add(new OurFirstBigInt(val.mag, true));
        }
        if(!this.sign) {
            return this.add(new OurFirstBigInt(val.mag, false));
        }
        // this and val positive
        if(val.gt(this)) {
            OurFirstBigInt temp = val.subtract(this);
            temp.sign = false;
            return temp;
        }
        int i = this.mag.length - 1;
        int iVal = val.mag.length - 1;
        byte[] result = new byte[this.mag.length];
        boolean carry = false;
        int toResult;
        while(i >= 0) {
            toResult = toInt(mag[i]);
            if(carry) {
                toResult -= 1;
                carry = false;
            }
            if(toResult < 0) {
                carry = true;
                toResult += 0x100;
            }
            if(iVal >= 0) {
                if(toResult < toInt(val.mag[iVal])) {
                    carry = true;
                    toResult += 0x100;
                }
                toResult -= toInt(val.mag[iVal]);
                iVal--;
            }
            result[i] = (byte) (toResult);
            i--;
        }
        return new OurFirstBigInt(result);
    }

    public OurFirstBigInt multiply(OurFirstBigInt val) {
        if(mag.length == 0 || val.mag.length == 0) {
            return zero;
        }
        byte[] x = this.mag;
        byte[] y = val.mag;
        if(x.length < y.length) {
            byte[] tmp = x;
            x = y;
            y = tmp;
        }
        int xIdx = x.length - 1;
        int yIdx = y.length - 1;
        int[][] temp = new int[y.length][];
        int tIdx = 0;
        int tiIdx;
        // fill temp
        while(yIdx >= 0) {
            int yInt = toInt(y[yIdx]);
            temp[tIdx] = new int[x.length];
            tiIdx = 0;
            while(xIdx >= 0) {
                int xInt = toInt(x[xIdx]);
                temp[tIdx][tiIdx] = xInt * yInt;
                tiIdx++;
                xIdx--;
            }
            tIdx++;
            xIdx = x.length - 1;
            yIdx--;
        }

        // temp to result
        int carry = 0;
        byte[] result = new byte[x.length + y.length];
        int toResult;
        int rIdx = result.length - 1;
        for(int i = 0; i < result.length; i++) {
            toResult = carry;
            int j = i;
            for(int k = 0; k < x.length; j--, k++) {
                if(j < y.length && j >= 0) {
                    toResult += temp[j][k];
                }
            }
            if(toResult > 0xff) {
                carry = (toResult >>> 8);
            } else {
                carry = 0;
            }
            result[rIdx - i] = (byte) (toResult);
        }
        // if signs are the same result will be positive
        return new OurFirstBigInt(result, this.sign == val.sign);
    }

    public OurFirstBigInt divide(OurFirstBigInt val, OurFirstBigInt reminder) {
        if(val.mag.length == 0) {
            throw new ArithmeticException("Division by zero!");
        }
        if(this.absEq(val)) {
            reminder.mag = new byte[0];
            reminder.sign = false;
            return new OurFirstBigInt(one.mag, this.sign == val.sign);
        }
        if(val.absGt(this)) {
            if(!this.sign) { // this negative
                reminder.mag = val.add(this).mag;
            } else {
                reminder.mag = this.mag;
            }
            reminder.sign = true;
            return zero;
        }
        OurFirstBigInt absVal = new OurFirstBigInt(val.mag, true);
        LinkedList<Byte> current = new LinkedList<>();
        LinkedList<Byte> result = new LinkedList<>();
        byte toResult;

        for(byte value : this.mag) {
            current.addLast(value);
            toResult = 0;
            if(current.size() >= val.mag.length) {
                OurFirstBigInt temp = new OurFirstBigInt(current);

                while(temp.geq(absVal)) {
                    temp = temp.subtract(absVal);
                    toResult += 1;
                }
                if(toResult != 0) {
                    current.clear();
                    for (int i = 0; i < temp.mag.length; i++) {
                        current.add(temp.mag[i]);
                    }
                }
            }
            result.add(toResult);
        }
        OurFirstBigInt newReminder = new OurFirstBigInt(current);
        if(!this.sign) {
            newReminder = val.subtract(newReminder);
        }
        reminder.mag = newReminder.mag;
        reminder.sign = true;

        byte[] ret = new byte[this.mag.length];
        int retIdx = 0;
        for (Byte b: result) {
            ret[retIdx] = b;
            retIdx++;
        }
        return new OurFirstBigInt(ret, this.sign == val.sign);
    }

    public OurFirstBigInt divide(OurFirstBigInt val) {
        return divide(val, new OurFirstBigInt(1));
    }

    public OurFirstBigInt mod(OurFirstBigInt mod) {
        if(mod.equals(one)) {
            return zero;
        }
        if(!mod.gt(zero)) { // mod < 0
            return NaN;
        }
        OurFirstBigInt reminder = new OurFirstBigInt(1);
        divide(mod, reminder);
        return reminder;
    }

    // this ^ (-1) % mod
    // this.gcd(mod) must equals 1!!!
    public OurFirstBigInt modInverse(OurFirstBigInt mod) {
        if(mod.equals(one))
            return zero;
        if(!mod.sign) {
            return NaN;
        }
        // val, modVal are mutable
        OurFirstBigInt val = new OurFirstBigInt(this);
        if(mod.geq(this)) {
            val = this.mod(mod);
        }
        OurFirstBigInt modVal = new OurFirstBigInt(mod);
        OurFirstBigInt x = new OurFirstBigInt(one);
        OurFirstBigInt y = new OurFirstBigInt(zero);
        while(val.gt(one)) {
            OurFirstBigInt reminder = new OurFirstBigInt(1);
            OurFirstBigInt q = val.divide(modVal, reminder); // reminder goes to modVal
            OurFirstBigInt t1 = modVal;
            modVal = reminder;
            val = t1;
            OurFirstBigInt t2 = y;
            y  = x.subtract(q.multiply(y));
            x = t2;
        }
        if(!x.geq(zero)) // x < 0
            x = x.add(mod);
        return x;
    }

    public OurFirstBigInt modPow(OurFirstBigInt exp, OurFirstBigInt mod) {
        // https://www.geeksforgeeks.org/modular-exponentiation-power-in-modular-arithmetic/
        if(this.equals(zero)) {
            return zero;
        }
        OurFirstBigInt ret = new OurFirstBigInt(1);
        OurFirstBigInt val = new OurFirstBigInt(this);
        OurFirstBigInt expVal = new OurFirstBigInt(exp);
        if(val.gt(mod)) {
            val = val.mod(mod);
        }
        while(expVal.gt(zero)) {
            if(expVal.isOdd()) {
                ret = ret.multiply(val).mod(mod);
            }
            expVal = expVal.shiftRight(1); // exp /= 2
            val = val.multiply(val).mod(mod);
        }
        return ret;
    }

    // this^exp % 2^p
    private OurFirstBigInt modPow2(OurFirstBigInt exp, int p) {
        OurFirstBigInt result = one;
        OurFirstBigInt baseToPow2 = this.mod2(p);
        int expOffset = 0;

        int limit = exp.bitLength();

        if(this.testBit(0))
            limit = Math.min((p - 1), limit);

        while (expOffset < limit) {
            if (exp.testBit(expOffset))
                result = result.multiply(baseToPow2).mod2(p);
            expOffset++;
            if (expOffset < limit)
                baseToPow2 = baseToPow2.multiply(baseToPow2).mod2(p);
        }

        return result;
    }

    // this % 2^p
    private OurFirstBigInt mod2(int p) {
        if (bitLength() <= p)
            return this;

        byte[] newMag = new byte[mag.length];
        System.arraycopy(mag, 0, newMag, 0, mag.length);
        int idx = floorDiv(p, 8);
        for(int i = p % 8; i < 8; i++) {
            newMag[idx] &= ~(1 << i);
        }
        for(int i = idx -1; idx >= 0; idx--) {
            newMag[i] = 0;
        }
        return new OurFirstBigInt(newMag);
    }

    // greatest common divisor
    public OurFirstBigInt gcd(OurFirstBigInt val) {
        if(this == zero) {
            return val;
        }
        if(val == zero) {
            return this;
        }
        OurFirstBigInt a = new OurFirstBigInt((mag));
        OurFirstBigInt b = new OurFirstBigInt(val.mag);
        OurFirstBigInt r = a.mod(b);
        while(r.gt(zero)) {
            a.mag = b.mag;
            b.mag = r.mag;
            r = a.mod(b);
        }
        return b;
    }

    // ------------------------------ BITWISE OPERATORS ---------- //

    public OurFirstBigInt shiftRight(int n) {
        int retLen = mag.length - floorDiv(n, 8);
        byte[] newMag = new byte[retLen];
        int mod8 = n % 8;
        int negMod8 = (8 - mod8) % 8;

        for(int i = 0; i < retLen; i++) {
            newMag[i] = (byte) (toInt(mag[i]) >> mod8);
            if(i > 0 && mod8 != 0) {
                newMag[i] ^= (byte) (toInt(mag[i - 1]) << negMod8);
            }
        }
        return new OurFirstBigInt(newMag);
    }

    public OurFirstBigInt shiftLeft(int n) {
        int retLen = mag.length + (int) ceil(n / 8.f);
        byte[] newMag = new byte[retLen];
        int mod8 = n % 8;
        int negMod8 = (8 - mod8) % 8;

        for(int i = 0; i < retLen; i++) {
            if(i < mag.length) {
                newMag[i] = (byte) (toInt(mag[i]) >> negMod8);
            }
            if(i > 0 && (i - 1) < mag.length && mod8 != 0) {
                newMag[i] ^= (byte) (toInt(mag[i - 1]) << mod8);
            }
        }
        return new OurFirstBigInt(newMag);
    }

    // from less significant bit(from RIGHT to LEFT)
    public boolean testBit(int n) {
        int idx = mag.length - floorDiv(n, 8) - 1;
        if(idx < 0)
            return false; // mb throw
        byte b = mag[idx];
        return ((b & (1 << (n % 8))) != 0);
    }

    public int getLowestSetBit() {
        int ret = 0;
        for(int i = mag.length - 1; i >= 0; i--) {
            byte b = mag[i];
            for(int j = 0; j < 8; j++) {
                if(((b >>> j) & 1) == 1) {
                    return ret;
                }
                ret++;
            }
        }
        return ret; // mag == 0
    }

    private boolean testBitFromLeft(int n) {
        int leadingZeros = 0;
        while((mag[0] & (1 << 7 - leadingZeros)) == 0 && leadingZeros < 8) {
            leadingZeros++;
        }
        n += leadingZeros;
        byte b = mag[floorDiv(n, 8)];
//        System.out.println(toInt(b) + " n mod 8" + (n % 8));
        return ((b & (0b10000000L >> (n % 8))) != 0);
    }

    public int bitLength() {
        int ret = (mag.length - 1) * 8;
        for(int i = 7; i >= 0; i--) {
            if((mag[0] & (1 << i)) != 0) {
                return ret + i + 1;
            }
        }
        return ret;
    }

    // ------------------------------ CONDITIONS ---------- //

    public boolean isOdd() {
        return toInt(this.mag[this.mag.length - 1]) % 2 == 1;
    }

    public boolean equals(Object o) {
        if(o instanceof OurFirstBigInt val) {
            return Arrays.equals(mag, val.mag) && (this.sign == val.sign);
        }
        return false;
    }

    public boolean gt(OurFirstBigInt val) {
        Boolean ret = greater(val);
        return Objects.requireNonNullElse(ret, false);
    }

    public boolean geq(OurFirstBigInt val) {
        Boolean ret = greater(val);
        return Objects.requireNonNullElse(ret, true);
    }

    // if equals returns null
    private Boolean greater(OurFirstBigInt val){
        if(this.sign && !val.sign) {
            return true;
        }
        if(!this.sign && val.sign) {
            return false;
        }
        boolean ret = this.sign; // inverse if both negative
        if(this.mag.length > val.mag.length) {
            return ret;
        }
        if(this.mag.length < val.mag.length) {
            return !ret;
        }
        for(int i = 0; i < this.mag.length; i++) {
            if(toInt(this.mag[i]) > toInt(val.mag[i])) {
                return ret;
            } else if(toInt(this.mag[i]) < toInt(val.mag[i])) {
                return !ret;
            }
        }
        return null; // equals
    }

    private boolean absGeq(OurFirstBigInt val) {
        OurFirstBigInt t = new OurFirstBigInt(this.mag, true);
        OurFirstBigInt v = new OurFirstBigInt(val.mag, true);
        return t.geq(v);
    }

    private boolean absGt(OurFirstBigInt val) {
        OurFirstBigInt t = new OurFirstBigInt(this.mag, true);
        OurFirstBigInt v = new OurFirstBigInt(val.mag, true);
        return t.gt(v);
    }

    private boolean absEq(OurFirstBigInt val) {
        return Arrays.equals(this.mag, val.mag);
    }

    // ------------------------------ DISPLAYING ---------- //

    public String toString() {
        if(mag.length == 0) {
            return "0";
        }
        StringBuilder ret = new StringBuilder();
        if(!sign) {
            ret.append("-");
        }
        for(int i = 0; i < mag.length; i++) {
            int uns = toInt(mag[i]);
            if(uns == 0) {
                ret.append("00");
            } else if(i != 0 && uns < 0x10) {
                ret.append("0");
                ret.append(Integer.toString(uns, 16));
            } else {
                ret.append(Integer.toString(uns, 16));
            }
        }
        return ret.toString();
    }

    // ------------------------------ VARIOUS COMMON FUNCTIONS ---------- //

    private byte[] deleteLeadingZeros(byte[] arr) {
        if(arr.length == 0) {
            return arr;
        }
        int idxNotZero = 0;
        while(arr[idxNotZero] == 0) {
            idxNotZero++;
            if(idxNotZero == arr.length) {
                return new byte[0];
            }
        }
        if(idxNotZero != 0) {
            byte[] resized = new byte[arr.length - idxNotZero];
            System.arraycopy(arr, idxNotZero, resized, 0, resized.length);
            return resized;
        }
        return arr;
    }

    private static int toInt(byte b) {
        return Byte.toUnsignedInt(b);
    }

    private static boolean isIntPrime(int x) {
        double bound = sqrt(x);
        for(int i = 2; i < bound; i++) {
            if(x % i == 0) return false;
        }
        return true;
    }
}
