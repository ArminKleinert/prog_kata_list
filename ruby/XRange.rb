class XRange
  def initialize(min, max, inclusive = false)
    if min > max
      throw ArgumentError.new "Minimum must be less than or equal to maximum."
    end
    @min = min
    @max = max
    @inclusive = inclusive
  end

  attr_reader :min
  attr_reader :max
  attr_reader :inclusive

  def normalize_rg
    if @inclusive
      XRange.new(@min, @max - 1)
    else
      self
    end
  end

  def each(&block)
    unless block_given?
      return self
    end
    
    rg = normalize_rg()
    en = rg.inclusive? 
    (rg.min).upto(rg.max) do |i|
      yield i
    end
  end
  
  def map(&block)
    arr = []
    each do |i|
      arr << block.call i
    end
    arr
  end
  
  def select(&block)
    arr = []
    each do |i|
      arr << i if block.call i
    end
    arr
  end
  
  def reject(&block)
    arr = []
    each do |i|
      arr << i unless block.call i
    end
    arr
  end
  
  def +(o)
    if o.is_a? Integer
      XRange.new(@min + o, @max + o, inclusive)
    elsif o.is_a? XRange
      XRange.new(@min + o.min, @max + o.max, inclusive)
    else
      throw ArgumentError.new "Argument must be integer or XRange"
    end
  end
  
  def -(o)
    if o.is_a? Integer
      XRange.new(@min - o, @max - o, inclusive)
    elsif o.is_a? XRange
      XRange.new(@min - o.min, @max - o.max, inclusive)
    else
      throw ArgumentError.new "Argument must be integer or XRange"
    end
  end
  
  def *(o)
    if o.is_a? Integer
      XRange.new(@min * o, @max * o, inclusive)
    else
      throw ArgumentError.new "Argument must be integer or XRange"
    end
  end

  def to_a
    arr = []
    each do |i|
      arr << i
    end
    arr.
  end
end
