## 10 xp
# sum_of_divisors
# Fibonacci (iterative, big numbers, recursive, tail-recursive)
# Factorial (iterative, big numbers, recursive, tail-recursive)

def sum_of_divisors(n)
  neg = n < 0
  res = 0
  (n.abs-1).downto(2) do |i|
    if n % i == 0
      res += i
    end
  end
  neg ? res * -1 : res 
end

# Fibonacci
def fib(n)
  a = 1
  b = 0
  temp = 0
  
  until n == 0
    temp = a
    n -= 1
    a += b
    b = temp
  end

  b
end

# Fibonacci using recursion
def fib_rec(n)
  if n < 2
    n
  else
    fib_rec(n-2) + fib_rec(n-1)
  end
end

# Fibonacci using tail recursion
def fib_trec_sub(n, a, b)
  if n == 0
    b
  else
    fib_trec_sub(n-1, a+b, a)
  end
end
def fib_trec(n)
  fib_trec_sub n, 1, 0
end

# Iterative factorial with big numbers (default in ruby)
def fact(n)
  result = 1
  i = 1
  while i <= n
    result *= i
    i += 1
  end
  result
end

# Factorial using recursion
def fact_rec(n)
  if n <= 0
    1
  else
    n * fact(n-1)
  end
end

# Factorial (tail-recursion)
def fact_trec_sub(n, acc)
  if n <= 0
    1
  else
    fact_trec_sub n-1, acc * n
  end
end
def fact_trec(n)
  fact_trec_sub n, 1
end

# Reverse integer digits (tail-recursion)
def rev_digits_sub(n, res)
  if n < 10
    n + (res * 10)
  else
    rev_digits_sub n / 10, n % 10 + (res * 10)
  end
end
def rev_digits(n)
  n < 0 ? -rev_digits_sub(n, 0) : rev_digits_sub(n, 0)
end

# Reverse integer digits iterative
def rev_digits_iter(n)
  res = 0
  until n == 0
    res = n % 10 + (res * 10)
    n = n / 10
  end
  res
end

# Calculate multiplication_persistance using strings
def multiplication_persistance_s(n)
  pers = 0
  n = n.to_s
  res = 1
  while n.size > 1
    pers += 1
    n = n.chars.reduce(1) { |r, c0| r * c0.to_i }.to_s
  end
  pers
end

# Calculate multiplication persistance
def multiplication_persistance(n)
  score = 0
  temp = 0
  
  loop do
    return score if n < 10
    
    score += 1
    temp = 1
    while n >= 10
      temp *= n % 10
      n /= 10
    end
    n *= temp
  end
end

# Optimized multiplication persistance function
def multiplication_persistance_opt(n)
  score = 0
  temp = 0
  
  loop do
    return score if n < 10
    
    score += 1
    temp = 1
    while n >= 10 && temp > 0
      temp *= n % 10
      n /= 10
    end
    n *= temp
  end
end

# Calculate multiplication persistance of numbers up to 10
# Takes 3130.66 seconds (about 52 minutes) on my machine (ruby 2.7.0 on ubuntu x85_64-linux-gnu)
def mult_pers_upto_10
  num = 0
  persistance = 0
  while persistance < 10
    persistance = multiplication_persistance num
    num += 1
  end
  num
end

# Calculate multiplication persistance of numbers up to 10 (optimized)
# Some optimizations are:
# - Not checking any even numbers (all numbers with a persistance > 6 are odd)
# - Not checking any numbers starting with a 1
# - Using an optimized version of the multiplication_persistance function
# Potential optimizations are:
# - Using memoization (but it always failed me when using numbers this big)
# - Using mutable big numbers (but I would have to implement those myself in Ruby and I am lazy)
# - Just starting at the first known number with the multiplication persistance we are looking for.
#   This would be missing the point however.
#
# All the implemented optimizations essentially mean that only 45% (90% because all numbers with a 1 at the start are ignored; divided by 2 because even numbers are ignored of the work needs to be done
# even though it looks more complicated.
#
# Takes 1107.54 seconds (or 18.46 minutes) on my machine (ruby 2.7.0 on ubuntu x85_64-linux-gnu)
def mult_pers_upto_10_opt
  num = 0
  expo = 20 # Start at number 21; Sets a range of numbers to be tested together with expo1. 
  expo1 = 100 # When this number is reached, set a new minimum number to check
  persistance = 0
  
  loop do
    # (num&1)>0 ensures that only odd numbers are tested. Any number with a persistance > 6 is odd.
    if (num & 1) > 0 && num > expo
      persistance = multiplication_persistance_opt num
      break if persistance >= 10
    end
    
    num += 1
    if num > expo1
      expo *= 10
      expo1 *= 10
      num = expo + 1
    end
  end
  
  num
end

t1 = Time.new
mult_pers_upto_10
t2 = Time.new
puts t1
puts t2
puts t2 - t1
