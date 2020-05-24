## 10 xp
# sum_of_divisors

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

# Factorial
def fact(n)
  result = 1
  i = 1
  while i <= n
    result *= i
    i += 1
  end
  result
end

# Factorial using (tail-)recursion
def fact_rec(n)
  if n <= 0
    1
  else
    n * fact(n-1)
  end
end

