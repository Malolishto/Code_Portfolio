#File: Reducible.py

#Description: A python script that finds all reducible words in a dictionary


import sys


# Input: takes as input a positive integer n
# Output: returns True if n is prime and False otherwise
def is_prime ( n ):
  if (n == 1):
    return False

  limit = int (n ** 0.5) + 1
  div = 2
  while (div < limit):
    if (n % div == 0):
      return False
    div += 1
  return True

# Input: takes as input a string in lower case and the size
#        of the hash table 
# Output: returns the index the string will hash into
def hash_word (s, size):
  hash_idx = 0
  for j in range (len(s)):
    letter = ord (s[j]) - 96
    hash_idx = (hash_idx * 26 + letter) % size
  return hash_idx

# Input: takes as input a string in lower case and the constant
#        for double hashing 
# Output: returns the step size for that string 
def step_size (s, const):
    ##Essentially hash_word, except the step variable (analogous to hash_idx
    ##from hash_word) is subtracted from const, and this difference is
    ##returned.
    const = const // 2
    step = 1
    for i in range(len(s)):
        letter = ord(s[i]) - 96
        step = (step * 26 + letter) % const
    return const - step
        
# Input: takes as input a string and a hash table 
# Output: no output; the function enters the string in the hash table, 
#         it resolves collisions by double hashing
def insert_word (s, hash_table):
##    len_hash = len(hash_table)
##    idx = hash_word(s, len_hash)
##    step = step_size(s, len_hash)
####    err_counter = 0
##    while hash_table[idx] != "":
##        idx += step
##        if idx >= len_hash:
##            idx %= len_hash
####        err_counter += 1
####        if err_counter == 10000:
####            print(hash_table)
####            raise Exception("Cant find a place to insert the word")
##    hash_table[idx] = s

    ##Since a majority of cases involve no collisions, the mere condition of
    ##hash_table[idx] being empty is tested right off the bat.
    len_hash = len(hash_table)
    idx = hash_word(s, len_hash)
    if hash_table[idx] == "":
        hash_table[idx] = s
    ##If there is a collision, a step is calculated and added to idx (which
    ##is then modulo'd by len_hash if necessary).
    else:
        step = step_size(s, len_hash)
        idx += step
        if idx >= len_hash:
            idx %= len_hash
        ##Until hash_table[idx] is empty, the step is added to idx and, if
        ##necessary, modulo'd.
        while hash_table[idx] != "":
            idx += step
            if idx >= len_hash:
                idx %= len_hash
        ##Finally, the string is added to the hash_table at idx.
        hash_table[idx] = s
        
# Input: takes as input a string and a hash table 
# Output: returns True if the string is in the hash table 
#         and False otherwise
def find_word (s, hash_table):

    ##hash_table[idx] is checked for the given s and for if it's empty. If
    ##neither conditions are met, double hashing is utilized.
    len_hash = len(hash_table)
    idx = hash_word(s, len_hash)
    if hash_table[idx] == s:
        return True
    elif hash_table[idx] == "":
        return False
    else:
        step = step_size(s, len_hash)
        idx += step
        if idx >= len_hash:
            idx %= len_hash
        ##Until hash_table[idx] equals s, a step is added to idx. If an
        ##empty string is found, false is returned and the function is
        ##popped.
        while hash_table[idx] != s:
            idx += step
            if idx >= len_hash:
                idx %= len_hash
            if hash_table[idx] == "":
                return False
        ##If the while loop stops running, then s has been found, and True
        ##is returned.
        return True
        
        
        
# Input: string s, a hash table, and a hash_memo 
#        recursively finds if the string is reducible
# Output: if the string is reducible it enters it into the hash memo 
#         and returns True and False otherwise
def is_reducible (s, hash_table, hash_memo):
    
    ##Base case 1: If s is in hash_memo, return True.
    if find_word(s, hash_memo):
##        print("Base Case 1 Reached")
        return True

    ##Base case 0: if s is a, o, or i, return True (I feel like this should
    ##be in words.txt)
    elif s == "a" or s == "i" or s == "o":
##        print("Base Case 0 Reached")
        insert_word(s, hash_memo)
        return True
    
    ##Base case 2: If s is not a word, return False.
    elif not find_word(s, hash_table):
##        print("Base Case 2 Reached")
        return False

    ##Recursive Case: s is not in hash_memo, is not of length 0,
    ##though it is a word.
    else:
        ##Versions of s (sub_s) are made, each one missing a different
        ##letter.
        for i in range(len(s)):
            sub_s = list(s)
            sub_s.pop(i)
            sub_s = "".join(sub_s)
##            print(sub_s)
            ##Recursive Case 0: if sub_s is reducible, add to hash_memo and
            ##return True.
            if is_reducible(sub_s, hash_table, hash_memo):
                insert_word(s, hash_memo)
##                print("Recursive case 0 satisfied.")
                return True
            
        ##Base Case 3: If all versions are checked, then the for loop
        ##will end, and False will be returned.
##        print("Base Case 3 reached.")
        return False
            
        
            
    

# Input: string_list a list of words
# Output: returns a list of words that have the maximum length
def get_longest_words (string_list):
    string_list.sort(key = len)
    string_list.reverse()
    counter = 1
    while len(string_list[counter]) == len(string_list[0]):
        counter += 1
    return string_list[0:counter]

def main():
  # create an empty word_list
    word_list = []
  # read words from words.txt and append to word_list
    for line in sys.stdin:
        line = line.strip()
        word_list.append (line)

  # find length of word_list
    len_list = len(word_list)
    
  # determine prime number N that is greater than twice
  # the length of the word_list
    N = 2 * len_list + 1
    while not is_prime(N):
        N += 1
    
  # create an empty hash_list
    hash_list = []
    
  # populate the hash_list with N blank strings
    for i in range(N):
        hash_list.append("")
        
  # hash each word in word_list into hash_list
  # for collisions use double hashing 
    for word in word_list:
        insert_word(word, hash_list)
        
  # create an empty hash_memo of size M
    hash_memo = []
    
  # we do not know a priori how many words will be reducible
  # let us assume it is 10 percent (fairly safe) of the words
  # then M is a prime number that is slightly greater than 
  # 0.2 * size of word_list
    M = int(len(word_list) * 0.2) + 1
    while not is_prime(M):
        M += 1
  # populate the hash_memo with M blank strings
    for i in range(M):
        hash_memo.append("")

  # create an empty list reducible_words
    reducible_words = []

  # for each word in the word_list recursively determine
  # if it is reducible, if it is, add it to reducible_words
  # as you recursively remove one letter at a time check
  # first if the sub-word exists in the hash_memo. if it does
  # then the word is reducible and you do not have to test
  # any further. add the word to the hash_memo.
    for word in word_list:
        if is_reducible(word, hash_list, hash_memo):
            reducible_words.append(word)
##            print(word)
            
  # find the largest reducible words in reducible_words
    largest = get_longest_words(reducible_words)
    
  # print the reducible words in alphabetical order
  # one word per line
    largest.sort()
    for word in largest:
        print(word)

if __name__ == "__main__":
  main()
