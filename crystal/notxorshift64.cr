def notxorshift64(seed : UInt64) : UInt64
  seed ^= seed >> 12
  seed ^= seed << 25
  seed ^= seed >> 27
  seed ^ 0x2545F4914F6CDD1D_u64
end

