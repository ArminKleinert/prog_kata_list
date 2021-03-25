
import std.datetime.stopwatch;
import std.stdio : writefln, writeln;
import std.algorithm.iteration : uniq;
import std.algorithm : sort;
import std.algorithm.mutation : copy;

uint xorshift32(uint x) {
  x ^= x << 13;
  x ^= x >> 17;
  x ^= x << 5;
  return x;
}

ulong xorshift64(ulong x) {
	x ^= x << 13;
	x ^= x >> 7;
	x ^= x << 17;
	return x;
}

ulong xorshift64s(ulong x) {
	x ^= x >> 12;
	x ^= x << 25;
	x ^= x >> 27;
	return x * 0x2545F4914F6CDD1D;
}

bool binarySearch(T)(T[] arr, size_t l, size_t r, T x) {
    if (r >= l) {
        size_t mid = l + (r - l) / 2;
  
        if (arr[mid] == x)
            return true;
  
        if (arr[mid] > x)
            return binarySearch(arr, l, mid - 1, x);
  
        return binarySearch(arr, mid + 1, r, x);
    }
  
    return false;
}

/*
void test32() {
  uint x = 1;
  size_t numDups = 0;
  uint temp = 0;
  uint[] xs = [];
  StopWatch sw;

  sw.reset();
  sw.start();
  xs ~= xorshift32(x);
  x++;
  while (x < 0x10000) {
    temp = xorshift32(x);
    if (binarySearch(xs, 0, xs.length-1, temp)){
      numDups++;
    } else {
      xs ~= x;
      xs.sort();
    }
    x++;
  }

  xs = null;

  auto total = sw.peek().total!"msecs"();
  writefln("32  ms: %s dups: %s", total, numDups);
}
*/

void test32() {
  uint x = 1;
  StopWatch sw;

  sw.reset();
  sw.start();
  while (x < 0xFFFFFFFF) {
    if (xorshift32(x) == 0) {
      writeln(x);
    }
    x++;
  }
  auto total = sw.peek().total!"msecs"();
  writefln("32  ms: %s", total);
}

void test64() {
  ulong x = 1;
  StopWatch sw;

  sw.reset();
  sw.start();
  while (x < 0xFFFFFFFF) {
    if (xorshift64(x) == 0) {
      writeln(x);
    }
    x++;
  }
  auto total = sw.peek().total!"msecs"();
  writefln("64  ms: %s", total);
}

void test64s() {
  ulong x = 1;
  StopWatch sw;

  sw.reset();
  sw.start();
  while (x < 0xFFFFFFFF) {
    if (xorshift64s(x) == 0) {
      writeln(x);
    }
    x++;
  }
  auto total = sw.peek().total!"msecs"();
  writefln("64* ms: %s", total);
}

int main(string[] argv) {
  test32();
  test64();
  test64s();
  return 0;
}
