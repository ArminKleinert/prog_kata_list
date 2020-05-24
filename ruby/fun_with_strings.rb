## 10 xp
# pad_left
# pad_right
# lines
# chars

def pad_left(str, target_size, padding = " ")
  new_str = str.dup
  if target_size > str.size
    until new_str.size <= target_size
      new_str = padding + new_str
    end
  end
  new_str
end

def pad_right(str, target_size, padding = " ")
  new_str = str
  if target_size > str.size
    until new_str.size <= target_size
      new_str << padding
    end
  end
  new_str
end

def get_lines(str)
  A = ["\r\n", "\n", "\r"].freeze
  str.split(/(\r\n)|(\n)|(\r)/).reject{|l|A.include? l}
end

def get_chars(str)
  arr = []
  str.each_char { |c| arr << c }
  arr
end
