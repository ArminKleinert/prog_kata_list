require 'io/console'

$_MEM = [0] # Memory
$mpos = 0 # Memory index

$CODE = "" # Code
$cpos = 0 # Code index

def rewind(pos)
  n = 1
  begin
    $cpos -= 1
    if $CODE[$cpos] == ']'
      n += 1
    elsif $CODE[$cpos] == '['
      n -= 1
    end
  end while $cpos >= 0 && ($CODE[$cpos] != '[' || n != 0)
end

def run_bf
  while $cpos < $CODE.size
    
    case $CODE[$cpos]
    when '+' # Add 1
      $_MEM[$mpos] += 1
      $_MEM[$mpos] = 0 if $_MEM[$mpos] == 256
    when '-' # Subtract 1 
      $_MEM[$mpos] -= 1
      $_MEM[$mpos] = 255 if $_MEM[$mpos] == -1
    when ',' # Read char
      $_MEM[$mpos] = STDIN.getch.ord
    when '.' # Print to STDOUT
      print $_MEM[$mpos].chr
    when '>' # Shift reg right
      $mpos += 1
      # Append cell if necessary
      $_MEM += [0] if $mpos == $_MEM.size
    when '<' # Shift reg left
      if $mpos == 0 # Prepend cell if necessary
        $_MEM = [0] + $_MEM
      else
        $mpos -= 1 # Otherwise, just decrement the index
      end
    when '[' # Open loop (no-op)
      nil
    when ']' # Rewind
      rewind($cpos) if $_MEM[$mpos] != 0
    #when 'm' # Print memory
    #  print $_MEM
    #  puts
    #when 'c' # Print code
    #  print $CODE
    #  puts
    #when '!' # Print to STDERR
    #  STDERR.print $_MEM[$mpos]
    #when '$' # Print info about current state
    #  puts "#{$CODE[$cpos]} #{$cpos.to_s} #{$CODE.size.to_s} #{$_MEM} #{$mpos}"
    end
    
    $cpos += 1
  end
end

$CODE = "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."
run_bf()
