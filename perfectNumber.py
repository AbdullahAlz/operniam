#highly inefficient way of finding even perfect numbers 
#between 1 and a given number of iterations (see last line)

import math

def main(numberOfIterations):
 for i in range(1, numberOfIterations):
    if isPrime((2**i) - 1):
        result = ((2**i) - 1) * (2**(i - 1))
        print("{}): {}".format(i, result))
 
def isPrime(num):
    if num <= 1: 
        return False
    if num == 2: 
        return True
    if num % 2 == 0: 
        return False
    for i in range(3, int(math.sqrt(num) + 1), 2):
        if num % i == 0: 
            return False
    return True

if __name__ == "__main__":
    main(1000)