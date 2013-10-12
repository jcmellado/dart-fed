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

/*
This code is derived from FED/FJ library.

References:
- Fast Explicit Diffusion (FED) and Fast-Jacobi (FJ):
  http://www.mia.uni-saarland.de/Research/SC_FED.shtml

- S. Grewenig, J. Weickert, C. Schroers, A. Bruhn:
  "Cyclic Schemes for PDE-Based Image Analysis"
  Technical Report No. 327, Department of Mathematics, Saarland University, Saarbrücken, Germany, March 2013.

- S. Grewenig, J. Weickert, A. Bruhn:
  "From box filtering to fast explicit diffusion"
  In M. Goesele, S. Roth, A. Kuijper, B. Schiele, K. Schindler (Eds.): Pattern Recognition.
  Lecture Notes in Computer Science, Vol. 6376, 533-542, Springer, Berlin, 2010.
*/

library fed_util;

import "dart:math" as math;

/**
 * Returns the next prime number greater than [number].
 */
int nextPrime(int number) {
  var prime = number + 1;
  while (!isPrime(prime)) {
    ++ prime;
  }
  return prime;
}

/**
 * Checks if the given [number] is prime.
 */
bool isPrime(int number) {
  if (number <= 1) {
    return false;
  }
  if ((number <= 3) || (number == 5) || (number == 7)) {
    return true;
  }
  if (((number % 2) == 0) || ((number % 3) == 0) || ((number % 5) == 0) || ((number % 7) == 0)) {
    return false;
  }

  var divisor = 11;
  var upperLimit = math.sqrt(number + 1).toInt();

  while(divisor <= upperLimit) {
    if ((number % divisor) == 0) {
      return false;
    }
    divisor += 2;
  }

  return true;
}
