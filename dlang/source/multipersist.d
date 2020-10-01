module multipersist;

import std.datetime.stopwatch;
import std.stdio;

// SECTION Multiplication persistance calculator 1

int multiplicationPersistance(ulong n) {
    int score = 0;
    ulong temp;

    while (true) {
        if (n < 10)
            return score;
        score++;
        temp = 1;
        while (n >= 10) {
            temp *= n % 10;
            n /= 10;
        }
        n *= temp;
    }
}

// SECTION Version 1

ulong version1(int stopat) {
    ulong record = 0;
    int persistance = 0;
    while (persistance < stopat) {
        record++;
        persistance = multiplicationPersistance(record);
    }
    return record;
}

// SECTION Version 2

ulong version2(int stopat) {
    ulong record = 0;
    int persistance = 0;
    while (persistance < stopat) {
        record++;
        if (record & 1) {
            persistance = multiplicationPersistance(record);
        }
    }
    return record;
}

// SECTION Version 3

ulong version3(int stopat) {
    ulong record = 0;
    ulong expo = 10;
    int persistance = 0;
    while (persistance < stopat) {
        record++;
        if (record & 1 && record > expo) {
            persistance = multiplicationPersistance(record);
        }
        if (record > (expo * 10)) {
            expo *= 10;
        }
    }
    return record;
}

// SECTION Version 4

ulong version4(int stopat) {
    ulong record = 0;
    ulong expo = 10;
    ulong expo1 = 100;
    int persistance = 0;
    while (persistance < stopat) {
        record++;
        if (record & 1 && record > expo) {
            persistance = multiplicationPersistance(record);
        }
        if (record > expo1) {
            expo *= 10;
            expo1 *= 10;
        }
    }
    return record;
}

// SECTION Version 5

ulong version5(int stopat) {
    ulong record = 0;
    ulong expo = 20;
    ulong expo1 = 100;
    int persistance = 0;
    while (persistance < stopat) {
        record++;
        if (record & 1 && record > expo) {
            persistance = multiplicationPersistance(record);
        }
        if (record > expo1) {
            expo *= 10;
            expo1 *= 10;
        }
    }
    return record;
}

// SECTION Version 6

ulong version6(int stopat) {
    ulong record = 0;
    ulong expo = 20;
    ulong expo1 = 100;
    int persistance = 0;
    while (persistance < stopat) {
        record++;
        if (record & 1 && record > expo) {
            persistance = multiplicationPersistance(record);
        }
        if (record > expo1) {
            expo *= 10;
            expo1 *= 10;
            record = expo + 1;
        }
    }
    return record;
}

// SECTION Multiplication persistance calculator 2

int multiplicationPersistance2(ulong n) {
    int score = 0;
    ulong temp;

start:

    if (n < 10)
        return score;
    score++;
    temp = 1;
    while (n >= 10) {
        temp *= n % 10;
        n /= 10;
    }
    n *= temp;

    goto start;
}

// SECTION Version 7

ulong version7(int stopat) {
    ulong record = 0;
    ulong expo = 20;
    ulong expo1 = 100;
    int persistance = 0;
    while (persistance < stopat) {
        record++;
        if (record & 1 && record > expo) {
            persistance = multiplicationPersistance2(record);
        }
        if (record > expo1) {
            expo *= 10;
            expo1 *= 10;
            record = expo + 1;
        }
    }
    return record;
}

//////// Using multiplicationPersistance instead of version 2 again!

// SECTION Version 8

ulong version8(int stopat) {
    ulong record = 0;
    ulong expo = 20;
    ulong expo1 = 100;
    int persistance = 0;

    while (true) {
        if (record & 1 && record > expo) {
            persistance = multiplicationPersistance(record);
            if (persistance >= stopat)
                break;
        }
        record++;
        if (record > expo1) {
            expo *= 10;
            expo1 *= 10;
            record = expo + 1;
        }
    }

    return record;
}

// SECTION Version 9

ulong version9(int stopat) {
    ulong record = 0;
    ulong expo = 20;
    ulong expo1 = 100;
    int persistance = 0;

    while (true) {
        if (record & 1 && record > expo) {
            persistance = multiplicationPersistance(record);
            if (persistance >= stopat)
                return record;
        }
        record++;
        if (record > expo1) {
            expo *= 10;
            expo1 *= 10;
            record = expo + 1;
        }
    }
}

// SECTION Multiplication persistance calculator 3

int multiplicationPersistance3(ulong n) {
    int score = 0;
    ulong temp;

    while (true) {
        if (n < 10)
            return score;
        score++;
        temp = 1;
        while (n >= 10 && temp > 0) {
            temp *= n % 10;
            n /= 10;
        }
        n *= temp;
    }
}

// SECTION Version 10

ulong version10(int stopat) {
    ulong record = 0;
    ulong expo = 20;
    ulong expo1 = 100;
    int persistance = 0;

    while (true) {
        if (record & 1 && record > expo) {
            persistance = multiplicationPersistance3(record);
            if (persistance >= stopat) {
                break;
            }
        }
        record++;
        if (record > expo1) {
            expo *= 10;
            expo1 *= 10;
            record = expo + 1;
        }
    }
    return record;
}

// SECTION Version 11

ulong[ulong] nextNumLookup;
ulong maxInLookup;

void v11prepareLookup() {
    ulong record = 21;
    ulong expo = 20;
    ulong expo1 = 100;

    while (nextNumLookup.length < 500) {
        if (record & 1) {
            ulong n = record;
            ulong key = record;
            ulong value = 1;

            while (n >= 10 && value > 0) {
                value *= n % 10;
                n /= 10;
            }
            n *= value;
            nextNumLookup[key] = value;
            maxInLookup = key;
        }

        record++;
        if (record > expo1) {
            //expo *= 10;
            expo = expo1 << 1;
            expo1 *= 10;
            record = expo + 1;
        }
    }
}

// SECTION Multiplication persistance calculator 4

int multiplicationPersistance4(ulong n) {
    int score = 0;
    ulong temp;

    while (true) {
        if (n < 10)
            return score;
        score++;
        if (n < maxInLookup && n in nextNumLookup) {
            n = nextNumLookup[n];
            continue;
        }
        temp = 1;
        while (n >= 10 && temp > 0) {
            temp *= n % 10;
            n /= 10;
        }
        n *= temp;
    }
}

ulong version11(int stopat) {
    ulong expo = 20;
    ulong record = expo + 1;
    ulong expo1 = 100;
    int persistance = 0;

    while (true) {
        record++;
        if (record & 1) {
            persistance = multiplicationPersistance4(record);
            //writefln("%d %d", record, persistance);
            if (persistance >= stopat) {
                break;
            }
        }
        if (record > expo1) {
            expo *= 10;
            expo1 *= 10;
            record = expo + 1;
        }
    }
    return record;
}

// SECTION Multiplication persistance calculator 5

int multiplicationPersistance5(ulong n) {
    int score = 0;
    ulong temp;

    while (true) {
        if (n < 10)
            return score;
        score++;
        temp = 1;
        while (n >= 10 && temp > 0) {
            temp *= n % 10;
            n /= 10;
        }
        n *= temp;
    }
}

// SECTION Version 12

ulong version12(int stopat) {
    ulong record = 0;
    ulong expo = 20;
    ulong expo1 = 100;
    int persistance = 0;

    while (true) {
        if (record & 1 && record > expo) {
            persistance = multiplicationPersistance5(record);
            if (persistance >= stopat) {
                break;
            }
        }

        record++;
        if (record > expo1) {
            expo *= 10;
            expo1 *= 10;
            record = expo + 1;
        }
    }
    return record;
}

// SECTION Version 13

ulong version13(int stopat) {
    ulong record = 0;
    ulong expo = 21;
    ulong expo1 = 100;
    int persistance = 0;

    while (true) {
        if (record & 1 && record > expo) {
            persistance = multiplicationPersistance5(record);
            if (persistance >= stopat) {
                break;
            }
        }

        record++;
        if (record > expo1) {
            expo *= 10;
            expo1 *= 10;
            record = expo + 1;
        }
    }
    return record;
}

// SECTION Version 14

// SECTION Multiplication persistance calculator 6

pure int multiplicationPersistance6(ulong n) @safe @nogc {
    int score = 0;
    ulong temp;

    while (true) {
        if (n < 10)
            return score;
        score++;
        temp = 1;
        while (n >= 10 && temp > 0) {
            temp *= n % 10;
            n /= 10;
        }
        n *= temp;
    }
}

pure ulong version14(int stopat) @safe @nogc {
    ulong record = 0;
    ulong expo = 21;
    ulong expo1 = 100;
    int persistance = 0;

    while (true) {
        if (record & 1 && record > expo) {
            persistance = multiplicationPersistance6(record);
            if (persistance >= stopat) {
                break;
            }
        }

        record++;
        if (record > expo1) {
            expo *= 10;
            expo1 *= 10;
            record = expo + 1;
        }
    }
    return record;
}

    /*
void main() {
    ulong total;
    const int targetPersist = 11;
    ulong res;
    StopWatch sw;

    sw.reset();
    sw.start();
    res = version1(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V1 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version2(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V2 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version3(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V3 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version4(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V4 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version5(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V5 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version6(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V6 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version7(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V7 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version8(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V8 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version9(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V9 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version10(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V10 %s %s", total, res);

    sw.reset();
    sw.start();
    v11prepareLookup();
    total = sw.peek().total!"msecs"();
    writefln("Lookup: %s", total);
    res = version11(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V11 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version11(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V11 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version12(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V12 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version13(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V13 %s %s", total, res);

    sw.reset();
    sw.start();
    res = version14(targetPersist);
    total = sw.peek().total!"msecs"();
    writefln("V14 %s %s", total, res);
}
    */

/*
With release option:
V1 59306
V2 31628
V3 33915
V4 36570
V5 26848
V6 27028
V7 26395
V8 26073
V9 25276
V10 22109
V11 24946
V12 21342
V13 20895
V14 20765
*/
