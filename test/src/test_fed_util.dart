/*
  Copyright (c) 2013 Juan Mellado

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/

part of fed_test;

abstract class TestFedUtil {

  static void run() {

    group("fed_util", () {

      test("nextPrime", () {
        expect(nextPrime(-2), equals(2));
        expect(nextPrime(-1), equals(2));

        expect(nextPrime(0), equals(2));
        expect(nextPrime(1), equals(2));
        expect(nextPrime(2), equals(3));
        expect(nextPrime(3), equals(5));
        expect(nextPrime(4), equals(5));
        expect(nextPrime(5), equals(7));
        expect(nextPrime(6), equals(7));
        expect(nextPrime(7), equals(11));
        expect(nextPrime(8), equals(11));
        expect(nextPrime(9), equals(11));
        expect(nextPrime(10), equals(11));
        expect(nextPrime(11), equals(13));
        expect(nextPrime(12), equals(13));
        expect(nextPrime(13), equals(17));

        expect(nextPrime(114), equals(127));
        expect(nextPrime(991), equals(997));
      });

      test("isPrime", () {
        expect(isPrime(-2), isFalse);
        expect(isPrime(-1), isFalse);

        expect(isPrime(0), isFalse);
        expect(isPrime(1), isFalse);
        expect(isPrime(2), isTrue);
        expect(isPrime(3), isTrue);
        expect(isPrime(4), isFalse);
        expect(isPrime(5), isTrue);
        expect(isPrime(6), isFalse);
        expect(isPrime(7), isTrue);
        expect(isPrime(8), isFalse);
        expect(isPrime(9), isFalse);
        expect(isPrime(10), isFalse);
        expect(isPrime(11), isTrue);
        expect(isPrime(12), isFalse);
        expect(isPrime(13), isTrue);

        expect(isPrime(121), isFalse);
        expect(isPrime(997), isTrue);
      });

    });
  }
}
