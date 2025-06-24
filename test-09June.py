from collections import defaultdict

def group_anagrams(words):
    # Dictionary to hold lists of anagrams keyed by sorted word
    anagram_dict = defaultdict(list)

    for word in words:
        # Sort the characters of the word and join back to string to form the key
        key = ''.join(sorted(word))
        # Append the original word to the list of its anagram group
        anagram_dict[key].append(word)

    # Return the grouped anagrams as a list of lists
    return list(anagram_dict.values())

# Example usage:
words = ["eat", "tea", "tan", "ate", "nat", "bat"]
print(group_anagrams(words))

def length_of_longest_substring(s):
    char_set = set()
    left = 0
    max_len = 0

    for right in range(len(s)):
        # If character already in set, move left pointer to remove duplicates
        while s[right] in char_set:
            char_set.remove(s[left])
            left += 1
        # Add the new character
        char_set.add(s[right])
        # Update the max length
        max_len = max(max_len, right - left + 1)

    return max_len
print(length_of_longest_substring("abcabcbb"))

def is_isomorphic(s, t):
    if len(s) != len(t):
        return False

    s_to_t = {}
    t_to_s = {}

    for c1, c2 in zip(s, t):
        # Check s → t mapping
        if c1 in s_to_t:
            if s_to_t[c1] != c2:
                return False
        else:
            s_to_t[c1] = c2

        # Check t → s mapping
        if c2 in t_to_s:
            if t_to_s[c2] != c1:
                return False
        else:
            t_to_s[c2] = c1

    return True
print(is_isomorphic("egg", "add"))
print(is_isomorphic("foo", "bar"))
print(is_isomorphic("paper", "title"))


s1=input()
s2=input()
temp1=list(set(s1))
temp2=list(set(s2))
if len(temp1)==len(temp2):
    print(True)
else:
    print(False)