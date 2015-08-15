require 'pry'

class Integer
  def factorial
    self <= 1 ? 1 : self * (self - 1).factorial
  end
end

# Visual representation of puzzle

#   a b c
#  d e f g
# h i j k l
#  m n o p
#   q r s

# Note: na stands for number_assignment

# Visual representation of rows

# def rows
#   [
#     ["a", "b", "c"],
#     ["d", "e", "f", "g"],
#     ["h", "i", "j", "k", "l"],
#     ["m", "n", "o", "p"],
#     ["q", "r", "s"],

#     ["a", "d", "h"],
#     ["b", "e", "i", "m"],
#     ["c", "e", "j", "n", "q"],
#     ["g", "k", "o", "r"],
#     ["l", "p", "s"],

#     ["h", "m", "q"],
#     ["d", "i", "n", "r"],
#     ["a", "e", "j", "o", "s"],
#     ["b", "f", "k", "p"],
#     ["c", "g", "l"]
#   ]
# end

def all_equals_38(na)
  return false unless na["a"] + na["b"] + na["c"]                     == 38
  return false unless na["d"] + na["e"] + na["f"] + na["g"]           == 38
  return false unless na["h"] + na["i"] + na["j"] + na["k"] + na["l"] == 38
  return false unless na["m"] + na["n"] + na["o"] + na["p"]           == 38
  return false unless na["q"] + na["r"] + na["s"]                     == 38
  return false unless na["a"] + na["d"] + na["h"]                     == 38
  return false unless na["b"] + na["e"] + na["i"] + na["m"]           == 38
  return false unless na["c"] + na["e"] + na["j"] + na["n"] + na["q"] == 38
  return false unless na["g"] + na["k"] + na["o"] + na["r"]           == 38
  return false unless na["l"] + na["p"] + na["s"]                     == 38
  return false unless na["h"] + na["m"] + na["q"]                     == 38
  return false unless na["d"] + na["i"] + na["n"] + na["r"]           == 38
  return false unless na["a"] + na["e"] + na["j"] + na["o"] + na["s"] == 38
  return false unless na["b"] + na["f"] + na["k"] + na["p"]           == 38
  return false unless na["c"] + na["g"] + na["l"]                     == 38
  return true
end

# After Gaussian Elimination
# Got some help from this guy: http://hwiechers.blogspot.ca/2013/03/solving-artitotles-number-puzzle.html

# a = 76 - j - k - n - 2o - p - r - s
# b = j + n + o
# c = -38 + k + o + p + r + s
# d = j + k + o
# e = -38 + k + n + o + p + r
# f = 38 - j - k - n - o - p
# g = 38 - k - o - r
# h = -38 + n + o + p + r + s
# i = 38 - j - k - n - o - r
# l = 38 - p - s
# m = 38 - n - o - p
# q = 38 - r - s

# Reduced letters
# ["j", "k", "n", "o", "p", "r", "s"]

def numbers
  (1..19).to_a
end

def set_variables(permutation)
  na = {}
  na["j"] = permutation.to_s[0].to_i
  na["k"] = permutation.to_s[1].to_i
  na["n"] = permutation.to_s[2].to_i
  na["o"] = permutation.to_s[3].to_i
  na["p"] = permutation.to_s[4].to_i
  na["r"] = permutation.to_s[5].to_i
  na["s"] = permutation.to_s[6].to_i
  return na
end

def set_other_letters(permutation, na)
  na["a"] =  76 - na["j"] - na["k"] - na["n"] - 2 * na["o"] - na["p"] - na["r"] - na["s"]
  na["b"] =       na["j"] + na["n"] + na["o"]
  na["c"] = -38 + na["k"] + na["o"] + na["p"] + na["r"] + na["s"]
  na["d"] =       na["j"] + na["k"] + na["o"]
  na["e"] = -38 + na["k"] + na["n"] + na["o"] + na["p"] + na["r"]
  na["f"] =  38 - na["j"] - na["k"] - na["n"] - na["o"] - na["p"]
  na["g"] =  38 - na["k"] - na["o"] - na["r"]
  na["h"] = -38 + na["n"] + na["o"] + na["p"] + na["r"] + na["s"]
  na["i"] =  38 - na["j"] - na["k"] - na["n"] - na["o"] - na["r"]
  na["l"] =  38 - na["p"] - na["s"]
  na["m"] =  38 - na["n"] - na["o"] - na["p"]
  na["q"] =  38 - na["r"] - na["s"]
  return na
end

def solve
  start_time = Time.now
  answers = []
  iterations = 19.factorial / 12.factorial

  numbers.permutation(7).each_with_index do |permutation, i|
    print "\r#{sprintf('%.5f', ((i + 1) / iterations.to_f * 100))}% complete"
    na = set_variables(permutation)
    na = set_other_letters(permutation, na)

    if all_equals_38(na)
      puts "Answer found! #{na}"
      puts "Found after: #{(Time.now - start_time) / 60} minutes"
      answers << na
    end
  end

  puts "Answers:"
  puts answers
  puts "Total time: #{(Time.now - start_time) / 60} minutes"
end

solve