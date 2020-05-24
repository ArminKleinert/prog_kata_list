## 10 xp
# get_duplicates
# get_uniques
# average
# contains?
# index_of
# count_of

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

def count_of(arr, elem)
  cl = elem.class
  arr.select {|e| e == elem}.size
end

