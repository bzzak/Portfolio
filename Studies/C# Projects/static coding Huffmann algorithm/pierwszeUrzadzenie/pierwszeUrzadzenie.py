import os
import heapq
import json
import socket

class Node():
    def __init__(self, char, freq):
        self.char = char
        self.freq = freq
        self.left = None
        self.right = None

    def __lt__(self, other):
        return self.freq < other.freq

    def __eq__(self, other):
        if (other == None):
            return False
        if (not isinstance(other, Node)):
            return False
        return self.freq == other.freq

def readFile(file_name):
    file = open(file_name + ".txt", 'r')

    text = file.read()
    text = text.rstrip()

    return text

def writeFile(file_name, barray):
    file = open(file_name + ".bin", 'wb')
    file.write(barray)

def writeDictionary(file_name, reverse):
    file = open(file_name + ".txt", 'w+')
    file.write(json.dumps(reverse))

def createDictionry(text):
    frequency = {}
    for i in text:
        if not i in frequency:
            frequency[i] = 0
        frequency[i] += 1
    return frequency

def makeHeap(heap, frequency):
    for i in frequency:
        node = Node(i, frequency[i])
        heapq.heappush(heap, node)


def mergeNodes(heap):
    while(len(heap) > 1):
        node1 = heapq.heappop(heap)
        node2 = heapq.heappop(heap)

        merged = Node(None, node1.freq + node2.freq)
        merged.left = node1
        merged.right = node2

        heapq.heappush(heap, merged)

def codeNumbers(node, currentCode, codes, reverse):
    if (node == None):
        return

    if(node.char != None):
        codes[node.char] = currentCode
        reverse[currentCode] = node.char

    codeNumbers(node.left, currentCode + "0", codes, reverse)
    codeNumbers(node.right, currentCode + "1", codes, reverse)



def code(heap, codes, reverse):
    root = heapq.heappop(heap)
    currentCode = ""
    codeNumbers(root, currentCode, codes, reverse)



def showEncodedText(text, codes):
    encodedText = ""
    for i in text:
        encodedText += codes[i]
    return encodedText

# def pad(encodedText):
#     padding = 8 - len(encodedText) % 8
#     for i in range(padding):
#         encodedText += "0"
#     paddingInfo = "{0:08b}".format(padding)
#     encodedText = encodedText + paddingInfo
#     return encodedText

def showByteArray(paddedText):
    barray = bytearray()
    for i in range(0, len(paddedText), 8):
        byte = paddedText[i:i+8]
        barray.append(int(byte, 2))
    return barray

def connect(IP):
    PORT = 4455
    ADDR = (IP, PORT)
    FORMAT = "utf-8"
    SIZE = 1024

    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM) # gniazdo TPC
    client.connect(ADDR) # łączenie z serwerem
    file = open("huffmanTekst2.bin", "rb")
    data = file.read()       # odczytanie zawartości pliku
    client.send("huffmanTekst2.bin".encode(FORMAT))  # wysłanie nazwy pliku do serwera
    msg = client.recv(SIZE).decode(FORMAT)
    print(f"[SERVER]: {msg}")
    client.send(data)     # wysłanie zawartości pliku do serwera
    msg = client.recv(SIZE)
    print(f"[SERVER]: {msg}")
    file.close()
    file = open("dictionary.txt", "r")
    data = file.read()  # odczytanie zawartości pliku
    client.send("dictionary.txt".encode(FORMAT))  # wysłanie nazwy pliku do serwera
    msg = client.recv(SIZE).decode(FORMAT)
    print(f"[SERVER]: {msg}")
    client.send(data.encode(FORMAT))  # wysłanie zawartości pliku do serwera
    msg = client.recv(SIZE).decode(FORMAT)
    print(f"[SERVER]: {msg}")
    file.close()
    client.close() # zamknięcie połączenia

def huffman():
    heap = []
    codes = {}
    reverse = {}
    text = readFile("tekst")
    print(text)
    frequency = createDictionry(text)
    print(frequency)
    makeHeap(heap, frequency)
    mergeNodes(heap)
    code(heap, codes, reverse)
    print(codes)
    encodedText = showEncodedText(text, codes)
    # paddedEncodedText = pad(encodedText)
    byteArray = showByteArray(encodedText)
    writeFile("huffmanTekst2", byteArray)
    writeDictionary("dictionary", reverse)
    connect("192.168.1.113") #tu wpisujemy IP komputera na ktory jest przesylana wiadomosc
    input()

huffman()