import java.nio.file.Files;
import java.nio.file.Paths;
import java.io.IOException;

class Main {

  // Test helper
  private static String readLineByLineJava8(String filePath) {
    try {
      String s = new String(Files.readAllBytes(Paths.get(filePath)));
      return s;
    } catch (IOException ex) {
      return "";
    }
  }

  // Slightly slower but more readable method.
  // Uses less memory.
  // Uses String#contains and String#substring a lot.
  // https://stackoverflow.com/a/37199853
  String lcs0(String str1, String str2) {
    int longest = 0;
    String longestSubstring = "";

    for (int i=0; i < str1.length(); ++i) {
      for (int j=i+1; j <= str1.length(); ++j) {
        String substring = str1.substring(i, j);
        if (str2.contains(substring) && substring.length() > longest) {
          longest = substring.length();
          longestSubstring = substring;
        }
      }
    }

    return longestSubstring;
  }

  // The faster but less readable method.
  // Uses a big 2d-Array of ints to safe the codepoits, which uses more memory.
  // In the end the String is constructed by inserting the substring in reverse order.
  // I modified the official way to use a StringBuilder with a starting capacity 
  // in order to not use repeated allocation in a loop.
  // Unmodified version: https://www.geeksforgeeks.org/print-longest-common-substring/
  String lcs1(String X, String Y) {
    int m = X.length();
    int n = Y.length();
    int[][] LCSuff = new int[m + 1][n + 1]; 

    int len = 0; 
    int row = 0, col = 0; 

    for (int i = 0; i <= m; i++) { 
      for (int j = 0; j <= n; j++) { 
        if (i == 0 || j == 0) {
          LCSuff[i][j] = 0; 
        } else if (X.charAt(i - 1) == Y.charAt(j - 1)) {
          LCSuff[i][j] = LCSuff[i - 1][j - 1] + 1; 
          if (len < LCSuff[i][j]) { 
            len = LCSuff[i][j]; 
            row = i; 
            col = j; 
          } 
        } else {
          LCSuff[i][j] = 0; 
        }
      }
    } 

    // Nothing found
    if (len == 0) { 
      return ""; 
    }

    // Initialize builder and fill with some spaces to avoid OutOfIndex in the while-loop
    StringBuilder resultStr = new StringBuilder(len);
    for (int i = 0; i < len; i++) {
      resultStr.append(' ');
    }

    while (LCSuff[row][col] != 0) {
      --len;
      resultStr.setCharAt(len, X.charAt(row - 1));
      row--; 
      col--; 
    }

    return resultStr.toString(); 
  } 
  
  // Taken directly from https://www.geeksforgeeks.org/print-longest-common-substring/
  // Changed only the formatting and initialized m and n in the method
  String lcs2(String X, String Y) {
    int m = X.length();
    int n = Y.length();
    int[][] LCSuff = new int[m + 1][n + 1]; 

    int len = 0; 
    int row = 0, col = 0; 

    for (int i = 0; i <= m; i++) { 
      for (int j = 0; j <= n; j++) { 
        if (i == 0 || j == 0) 
          LCSuff[i][j] = 0; 

        else if (X.charAt(i - 1) == Y.charAt(j - 1)) { 
          LCSuff[i][j] = LCSuff[i - 1][j - 1] + 1; 
          if (len < LCSuff[i][j]) { 
            len = LCSuff[i][j]; 
            row = i; 
            col = j; 
          }
        }
        else
          LCSuff[i][j] = 0; 
      } 
    } 

    if (len == 0) {
      return null; 
    } 

    String resultStr = ""; 

    while (LCSuff[row][col] != 0) { 
      resultStr = X.charAt(row - 1) + resultStr; // or Y[col-1] 
      --len; 
      row--; 
      col--; 
    } 

    return resultStr; 
} 


  // Main method for testing purposes.
  public static void main(String[] args) {
    Main m = new Main();
    int times = 1000;
    String s0 = readLineByLineJava8("./lcs_example.java");
    String s1 = readLineByLineJava8("./lcs_example.java");

    String temp0 = null;
    String temp1 = null;

    long t0 = 0;
    long t1 = 0;

    System.out.println("Prepared");

    t0 = System.currentTimeMillis();
    for (int i = 0; i < 1; i++) {
      temp0 = m.lcs0(s0, s1);
      temp1 = m.lcs0(s1, s0);
    }
    t1 = System.currentTimeMillis();
    System.out.println(t0);
    System.out.println(t1);
    System.out.println(t1 - t0);
    //System.out.println(temp0);
    //System.out.println(temp1);

    t0 = System.currentTimeMillis();
    for (int i = 0; i < times; i++) {
      temp0 = m.lcs1(s0, s1);
      temp1 = m.lcs1(s1, s0);
    }
    t1 = System.currentTimeMillis();
    System.out.println(t0);
    System.out.println(t1);
    System.out.println(t1 - t0);
    //System.out.println(temp0);
    //System.out.println(temp1);

    t0 = System.currentTimeMillis();
    for (int i = 0; i < times; i++) {
      temp0 = m.lcs2(s0, s1);
      temp1 = m.lcs2(s1, s0);
    }
    t1 = System.currentTimeMillis();
    System.out.println(t0);
    System.out.println(t1);
    System.out.println(t1 - t0);
    //System.out.println(temp0);
    //System.out.println(temp1);
  }
}
