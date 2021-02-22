## 10 xp
# get_duplicates
# get_uniques
# average
# contains?
# index_of
# count_of
# last_index_of
# min
# max
# sum

def get_duplicates(arr)
	arr.select { |e| arr.count(e) > 1 }
end

def get_uniques(arr)
  arr.select { |e| arr.count(e) == 1 }
end

def average(num_arr)
  arr.inject(0.0) { |sum, el| sum + el } / arr.size
end

def contains?(arr, elem)
  arr.inject(false) do |result, current|
    if result
      result
    else
      current == elem
    end
  end
end

def index_of(arr, elem)
  arr.each_indexed do |idx, current|
    return idx if current == elem
  end
  -1
end

# TODO: Test
def last_index_of(arr, elem)
  i = arr.size
  until i == 0
    i -= 1
    return i if arr[i] == elem
  end
  -1
end

def count_of(arr, elem)
  cl = elem.class
  arr.select {|e| e == elem}.size
end

# TODO: Test
def max(arr)
  if arr.empty?
    nil
  else
    m = arr[0]
    arr.each do |v|
      m = v if v > m
    end
    m
  end
end

# TODO: Test
def min(arr)
  if arr.empty?
    nil
  else
    m = arr[0]
    arr.each do |v|
      m = v if v < m
    end
    m
  end
end

def sum(arr)
  arr.inject(&:+)
end


# TODO: Test
# Fisher-Yates shuffle (inside out)
def fy_shuffle(coll, random = Random.new)
  target = []
  
  coll.each do |v|
    j = random.rand(0 .. (target.size))
    if (j >= target.size)
      target << v
    else
      target << target[j]
      target[j] = v
    end
  end
  
  target
end

# Fisher-Yates shuffle (inside out)
def fy_shuffle!(coll, random = Random.new)
  fy_shuffle(coll, random).each_indexed do |i, v|
    coll[i] = v
  end
  coll
end


# TODO: Test
def any?(coll, &block)
  coll.each do |e|
    return true if (yield e)
  end
  false
end

# TODO: Test
def none?(coll, &block)
  coll.each do |e|
    return false if (yield e)
  end
  true
end

# TODO: Test
def all?(coll, &block)
  coll.each do |e|
    return false unless (yield e)
  end
  true
end


# TODO: Test
def foldl(coll, init, &block)
  res = init
  coll.each do |e|
    res = yield res, e
  end
  res
end

def filter(coll, &block)
  res = []
  coll.each do |e|
    res << e if yield(e)
  end
  res
end











