import json
import socket
import os

def readBinaryFile(file_name):
    file = open(file_name + ".bin", 'rb')
    bitString = ""

    byte = file.read(1)
    while(len(byte) > 0):
        byte = ord(byte)
        bits = bin(byte)[2:].rjust(8, '0')
        bitString += bits
        byte = file.read(1)


    return bitString

def readDictionary(file_name):
    file = open(file_name + ".txt", 'r')
    reverse = json.loads(file.read())
    return reverse

def writeFile(file_name, decodedText):
    file = open(file_name + ".txt", 'w')
    file.write(decodedText)

# def removePad(bitString):
#     paddingInfo = bitString[:8]
#     padding = int(paddingInfo, 2)
#     bitString = bitString[8:]
#     encodedText = bitString[:-1*padding]
#     return encodedText

def decode(encodedText, reverse):
    currentCode = ""
    decodedText = ""

    for i in encodedText:
        currentCode += i
        if(currentCode in reverse):
            character = reverse[currentCode]
            decodedText += character
            currentCode = ""

    return decodedText

def connect(IP):
    PORT = 4455
    ADDR = (IP, PORT)
    SIZE = 1024
    FORMAT = "utf-8"
    print("[STARTING] Server is starting.")
    """ Staring a TCP socket. """
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    """ Bind the IP and PORT to the server. """
    server.bind(ADDR)

    """ Server is listening, i.e., server is now waiting for the client to connected. """
    server.listen()
    print("[LISTENING] Server is listening.")


    """ Server has accepted the connection from the client. """
    conn, addr = server.accept()
    print(f"[NEW CONNECTION] {addr} connected.")

    """ Receiving the filename from the client. """
    filename = conn.recv(SIZE).decode(FORMAT)
    print(f"[RECV] Receiving the filename.")
    file = open(filename, "wb")
    conn.send("Filename received.".encode(FORMAT))

    """ Receiving the file data from the client. """
    data = conn.recv(SIZE)
    print(f"[RECV] Receiving the file data.")
    file.write(data)
    conn.send("File data received".encode(FORMAT))

    """ Closing the file. """
    file.close()
    filename = conn.recv(SIZE).decode(FORMAT)
    print(f"[RECV] Receiving the filename.")
    file = open(filename, "w")
    conn.send("Filename received.".encode(FORMAT))

    """ Receiving the file data from the client. """
    data = conn.recv(SIZE).decode(FORMAT)
    print(f"[RECV] Receiving the file data.")
    file.write(data)
    conn.send("File data received".encode(FORMAT))
    """ Closing the connection from the client. """
    file.close()
    conn.close()
    print(f"[DISCONNECTED] {addr} disconnected.")

def huffmanDecode():
    connect("10.20.15.25") #tu wpisujemy IP komputera na ktory jest przesylana wiadomosc
    reverse = readDictionary("dictionary")
    bitString = readBinaryFile("huffmanTekst2")
    # encodedText = removePad(bitString)
    decodedText = decode(bitString, reverse)
    print(decodedText)
    writeFile("decodedHuffman", decodedText)
    input()

huffmanDecode()