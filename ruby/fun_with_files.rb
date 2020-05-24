 ## 10 xp
# read_file_or_nil
# interpret_hello_world

def read_file_or_nil(file)
  begin
    IO.read file
  rescue Errno::EISDIR, Errno::ENOENT
    nil
  end
end

def interpret_hello_world(file)
  s = IO.read(file)
  puts "Hello world!" if s.nil? || s.empty?
end

