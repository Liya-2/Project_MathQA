import numpy as np
import sys

l = { 'a': '0', 'b': '1', 'c': '2', 'd': '3', 'e': '4' }

def process(datafile):     
    with open(datafile) as f:
        lines = f.readlines()
        lines = [line.rstrip() for line in lines]

        for line in lines:
            numbers = []
            tokens = line.split('\t')
            for token in tokens[1].split(','):
                token = token.strip(" ,\"")
                n = [float(s) for s in token.split() if s.isnumeric()]
                if len(n) > 0:
                    numbers.append(n[0])

            if len(numbers) > 0 and sum(numbers)>0 :
                numbers = [float(i)/sum(numbers) for i in numbers] 
                nstr = '\t'.join(str(e) for e in numbers)
                print(tokens[0] + '\t' + nstr + '\t' + l[tokens[-1].strip(" ,\"")])
            

if __name__ == "__main__":
    process(sys.argv[1])

      
