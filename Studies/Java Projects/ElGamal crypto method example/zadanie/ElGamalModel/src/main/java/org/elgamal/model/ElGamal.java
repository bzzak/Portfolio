package org.elgamal.model;
import com.google.j2objc.annotations.Property;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Collection;
import java.util.LinkedList;
import java.util.Random;
import java.math.BigInteger;
import java.io.*;
import java.util.Scanner;

public class ElGamal {

    private final int BitLength = 256;
    private OurFirstBigInt p, g; // public (p is modN)
    private OurFirstBigInt a;
    private byte[] encrypted;
    private byte[] decrypted;

    //GETTERS, SETTERS
    public byte[] getEncrypted(){
        return encrypted;
    }

    public byte[] getDecrypted(){return decrypted;}

    public void setEncrypted(byte[] encryptedData) {encrypted = encryptedData;}

    public void setDecrypted(byte[] decryptedData) {decrypted = decryptedData;}

    public OurFirstBigInt getPMinOne() {
        if (p != null) {
            return p.subtract(OurFirstBigInt.one);
        } else {
            return null;
        }
    }

    public int getBitLength() {
        return BitLength;
    }

    public OurFirstBigInt getP() {
        return p;
    }

    public OurFirstBigInt getG() {
        return g;
    }

    public OurFirstBigInt getA() {// nasz klucz prywatny
        return a;
    }

    public OurFirstBigInt getH() {
        if (g != null && a != null && p != null) {
            return g.modPow(a, p);
        }
        return null;
    }

    public void setP(OurFirstBigInt value) {
        this.p = value;
    }

    public void setG(OurFirstBigInt value) {
        this.g = value;
    }

    public void setA(OurFirstBigInt value) {// nasz klucz prywatny
        this.a = value;
    }

    // CONSTRUCTORS

    public ElGamal() {
        p = null;
        g = null;
        a = null;
    }


    //ENCRYPTION

    public OurFirstBigInt getR() {
        return OurFirstBigInt.getRandom(getPMinOne());
    }

    private OurFirstBigInt getC1(OurFirstBigInt r) {
        return g.modPow(r,p);
    }



    public boolean encryptData(byte[] data) {
        if(verifyA() && verifyG()) {
            LinkedList<Byte> cypherFullMessage = new LinkedList<Byte>();
            byte[] cypherFullMessageByte;
            byte[] c1Mag;
            byte[] c2Mag;
            OurFirstBigInt r;
            OurFirstBigInt c1;
            OurFirstBigInt c2;
            int counter = 0;
            byte[] m = new byte[32];
            for (int i = 0; i <= data.length; i++) {

                if (i == data.length && counter == 0) {
                    break;
                }
                if (i == data.length && counter > 0) {
                    byte deleteNumber;
                    byte addNumber;
                    int deleteZeros = 0;
                    int leadingZeros = 0;
                    r = getR();
                    c1 = getC1(r);
                    for (int j = counter; j < 32; j++) {
                        m[j] = 0;
                        deleteZeros++;
                    }
                    for (byte b: m) {
                        if(b == 0) {
                            leadingZeros++;
                        } else{
                            break;
                        }
                    }
                    deleteNumber = (byte) deleteZeros;
                    addNumber = (byte) leadingZeros;
                    byte[] deleteZerosArray = {deleteNumber};
                    byte[] addLeadingZerosArray = {addNumber};
                    OurFirstBigInt message = new OurFirstBigInt(m);

                    c2 = message.multiply(getH().modPow(r, getP())).mod(getP());
                    c1Mag = getNSizedByteArray(33, c1.getMag());
                    c2Mag = getNSizedByteArray(33, c2.getMag());
                    byte[] messageMag = joinArrays(c1Mag,c2Mag,deleteZerosArray, addLeadingZerosArray);
                    for (byte b: messageMag) {
                        cypherFullMessage.add(b);
                    }

                    break;
                }

                if(counter >= 0)
                    m[counter] = data[i];
                //m[i] = data[i];
                counter++;

                if (counter == 32) {
                    byte addNumber;
                    int leadingZeros = 0;
                    byte[] deleteNumber = {0};
                    r = getR();
                    c1 = getC1(r);
                    for (byte b: m) {
                        if(b == 0) {
                            leadingZeros++;
                        } else{
                            break;
                        }
                    }
                    addNumber = (byte) leadingZeros;
                    byte[] addLeadingZerosArray = {addNumber};
                    OurFirstBigInt message = new OurFirstBigInt(m);
                    c2 = message.multiply(getH().modPow(r, getP())).mod(getP());
                    c1Mag = getNSizedByteArray(33, c1.getMag());
                    c2Mag = getNSizedByteArray(33, c2.getMag());
                    byte[] messageMag = joinArrays(c1Mag,c2Mag,deleteNumber, addLeadingZerosArray);
                    for (byte b: messageMag) {
                        cypherFullMessage.add(b);
                    }
                    counter = 0;
                }
            }
            cypherFullMessageByte = new byte[cypherFullMessage.size()];
            int messageByteCounter = 0;
            for (byte b: cypherFullMessage) {
                cypherFullMessageByte[messageByteCounter] = b;
                messageByteCounter++;
            }
            encrypted = cypherFullMessageByte;
            return true;
        }
        encrypted = null;
        return false;
    }

    //DECRYPTION


    public boolean decryptData(byte[] encrypt) {
        if(verifyA()) {
            //byte[] encForTest = getEncrypted();
            OurFirstBigInt c1, c2;
            OurFirstBigInt decryptedPart;
            byte[] decryptedFullMessageByte;
            LinkedList<Byte> c1Mag = new LinkedList<>(), c2Mag = new LinkedList<>();
            LinkedList<Byte> decryptedMessage = new LinkedList<>();
            int counter = 0;
            for (int i = 0; i <= encrypted.length; i++) {
                if (counter == 66) {
                    byte deleteCounter = encrypted[i];
                    byte addCounter = encrypted[i+1];
                    counter = 0;
                    c1 = new OurFirstBigInt(c1Mag);
                    c2 = new OurFirstBigInt(c2Mag);
                    decryptedPart = c2.multiply(c1.modPow(getA(), getP()).modInverse(getP())).mod(getP());

                    for(int j = 0; j < addCounter; j++){
                        decryptedMessage.add((byte) 0);
                    }
                    for (byte b : decryptedPart.getMag()) {
                            decryptedMessage.add(b);
                    }
                    boolean condition = true;
                    while(condition){
                       if(deleteCounter != 0){
                           decryptedMessage.pollLast();
                           deleteCounter--;
                       } else {
                           condition = false;
                       }
                    }
                    c1Mag.clear();
                    c2Mag.clear();
                    i += 2;
                    if(i == encrypted.length) break;
                }
                if (counter < 33) {
                    c1Mag.add(encrypted[i]);
                } else {
                    c2Mag.add(encrypted[i]);
                }
                counter++;
            }

            decryptedFullMessageByte = new byte[decryptedMessage.size()];
            int messageByteCounter = 0;
            for (byte b : decryptedMessage) {
                decryptedFullMessageByte[messageByteCounter] = b;
                messageByteCounter++;
            }
            decrypted = decryptedFullMessageByte;
            return true;
        }
        decrypted = null;
        return false;
    }


// KEYS

    public OurFirstBigInt[] generateKeys() {
        return generateKeys(BitLength + 8);
    }

    public OurFirstBigInt[] generateKeys(int bitLength) {
        OurFirstBigInt prime;
        OurFirstBigInt generator;
        OurFirstBigInt privateKey;

        prime = OurFirstBigInt.probablePrime(bitLength);

        generator = OurFirstBigInt.getRandom(prime.subtract(OurFirstBigInt.one)); // 1 < generator < prime - 1
        while (generator.equals(OurFirstBigInt.one)) {
            generator = OurFirstBigInt.getRandom(prime.subtract(OurFirstBigInt.one));
        }

        privateKey = OurFirstBigInt.getRandom(prime.subtract(OurFirstBigInt.one)); // 1 < privateKey < prime - 1
        while (privateKey.equals(OurFirstBigInt.one)) {
            privateKey = OurFirstBigInt.getRandom(prime.subtract(OurFirstBigInt.one));
        }

        return new OurFirstBigInt[]{prime, generator, privateKey};
    }

    public boolean verifyG() {
        return p != null && g != null && (!OurFirstBigInt.one.geq(g) && !g.geq(getPMinOne()));
    }

    public boolean verifyA() {
        return p != null && a != null && (!OurFirstBigInt.one.geq(a) && !a.geq(getPMinOne()));
    }

//UTILS

    public static byte[] joinArrays(byte[]... args) {
        int byteCount = 0;
        for (byte[] arg : args) { // For all array arguments...
            byteCount += arg.length;
        }
        byte[] returnArray = new byte[byteCount];
        int offset = 0;
        for (byte[] arg : args) { // For all array arguments...
            System.arraycopy(arg, 0, returnArray, offset, arg.length);
            offset += arg.length;
        }
        return returnArray;
    }

    private byte[] getNSizedByteArray(int size, byte[] array){
        byte[] newArray = new byte[size];
        if(array.length < size) {
            int start = size - array.length;
            int counter = 0;
            for (int i = 0; i < size; i++) {
                if (i < start) {
                    newArray[i] = 0;
                } else {
                    newArray[i] = array[counter];
                    counter++;
                }
            }
            return newArray;
        } else if(array.length > size) {
            System.arraycopy(array,0,newArray,0,size);
            return newArray;
        } else {
            return array;
        }
    }

}