def printDebug(text,debug=False):
    if debug == True:
        print(text)

    
def findIndexOfBiggestDigitInString(string):
    n = 1
    parts = [int(string[i:i+n]) for i in range(0, len(string), n)]
    index = string.index(str(max(parts)))
    return index

def isSymbol(char,compareChar):
    if char == compareChar:
        return True
    else:
        return False

def isDigit(char):
    if(char == "1" or char == "2" or char == "3" or char == "4" or char == "5" or char == "6" or char == "7" or char == "8" or char == "9" or char == "0"):
        return True
    
    return False