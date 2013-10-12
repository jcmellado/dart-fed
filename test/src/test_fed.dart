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

_unordererEquals(int n, double tauMax) {
  var tau = tauBySteps(n, tauMax, ReorderingMode.NONE);
  var leja = tauBySteps(n, tauMax, ReorderingMode.LEJA);

  expect(leja, isNot(orderedEquals(tau)));
  expect(leja, unorderedEquals(tau));
}

abstract class TestFed {

  static void run() {

    group("fed", () {

      test("tauBySteps - 10", () {
        var tau = tauBySteps(10, 0.5, ReorderingMode.NONE);
        expect(tau, hasLength(10));
        expect(tau[0], closeTo(0.251404, 0.000001));
        expect(tau[1], closeTo(0.263024, 0.000001));
        expect(tau[2], closeTo(0.288508, 0.000001));
        expect(tau[7], closeTo(1.33, 0.01));
        expect(tau[8], closeTo(2.88, 0.01));
        expect(tau[9], closeTo(11.25, 0.01));
        expect(tau.reduce((v, e) => v + e), closeTo(18.33, 0.01));
      });

      test("tauBySteps - 25", () {
        var tau = tauBySteps(25, 0.5, ReorderingMode.NONE);
        expect(tau, hasLength(25));
        expect(tau[0], closeTo(0.250237, 0.000001));
        expect(tau[1], closeTo(0.252147, 0.000001));
        expect(tau[2], closeTo(0.256024, 0.000001));
        expect(tau[22], closeTo(7.40, 0.01));
        expect(tau[23], closeTo(16.55, 0.01));
        expect(tau[24], closeTo(65.97, 0.01));
        expect(tau.reduce((v, e) => v + e), closeTo(108.33, 0.01));
      });

      test("tauBySteps - 50", () {
        var tau = tauBySteps(50, 0.5, ReorderingMode.NONE);
        expect(tau, hasLength(50));
        expect(tau[0], closeTo(0.250060, 0.000001));
        expect(tau[1], closeTo(0.250545, 0.000001));
        expect(tau[2], closeTo(0.251518, 0.000001));
        expect(tau[47], closeTo(28.79, 0.01));
        expect(tau[48], closeTo(64.68, 0.01));
        expect(tau[49], closeTo(258.48, 0.01));
        expect(tau.reduce((v, e) => v + e), closeTo(425.00, 0.01));
      });

      test("tauBySteps - 100", () {
        var tau = tauBySteps(100, 0.5, ReorderingMode.NONE);
        expect(tau, hasLength(100));
        expect(tau[0], closeTo(0.250015, 0.000001));
        expect(tau[1], closeTo(0.250137, 0.000001));
        expect(tau[2], closeTo(0.250382, 0.000001));
        expect(tau[97], closeTo(113.79, 0.01));
        expect(tau[98], closeTo(255.93, 0.01));
        expect(tau[99], closeTo(1023.45, 0.01));
        expect(tau.reduce((v, e) => v + e), closeTo(1683.33, 0.01));
      });

      test("tauBySteps - 250", () {
        var tau = tauBySteps(250, 0.5, ReorderingMode.NONE);
        expect(tau, hasLength(250));
        expect(tau[0], closeTo(0.250002, 0.000001));
        expect(tau[1], closeTo(0.250022, 0.000001));
        expect(tau[2], closeTo(0.250061, 0.000001));
        expect(tau[247], closeTo(706.52, 0.01));
        expect(tau[248], closeTo(1589.57, 0.01));
        expect(tau[249], closeTo(6358.01, 0.01));
        expect(tau.reduce((v, e) => v + e), closeTo(10458.33, 0.01));
      });

      test("tauBySteps - 500", () {
        var tau = tauBySteps(500, 0.5, ReorderingMode.NONE);
        expect(tau, hasLength(500));
        expect(tau[0], closeTo(0.250001, 0.000001));
        expect(tau[1], closeTo(0.250006, 0.000001));
        expect(tau[2], closeTo(0.250015, 0.000001));
        expect(tau[497], closeTo(2820.19, 0.01));
        expect(tau[498], closeTo(6345.33, 0.01));
        expect(tau[499], closeTo(25381.06, 0.01));
        expect(tau.reduce((v, e) => v + e), closeTo(41750.00, 0.01));
      });

      test("tauBySteps - 1000", () {
        var tau = tauBySteps(1000, 0.5, ReorderingMode.NONE);
        expect(tau, hasLength(1000));
        expect(tau[0], closeTo(0.250000, 0.000001));
        expect(tau[1], closeTo(0.250001, 0.000001));
        expect(tau[2], closeTo(0.250004, 0.000001));
        expect(tau[997], closeTo(11269.25, 0.01));
        expect(tau[998], closeTo(25355.72, 0.01));
        expect(tau[999], closeTo(101422.61, 0.01));
        expect(tau.reduce((v, e) => v + e), closeTo(166833.33, 0.01));
      });

      test("tauBySteps - Leja", () {
        _unordererEquals(10, 0.5);
        _unordererEquals(25, 0.5);
        _unordererEquals(50, 0.5);
        _unordererEquals(100, 0.5);
        _unordererEquals(250, 0.5);
        _unordererEquals(500, 0.5);
        _unordererEquals(1000, 0.5);
      });

      test("maxCycleTimeBySteps", () {
        expect(maxCycleTimeBySteps(10, 0.5), closeTo(18.33, 0.01));
        expect(maxCycleTimeBySteps(25, 0.5), closeTo(108.33, 0.01));
        expect(maxCycleTimeBySteps(50, 0.5), closeTo(425.00, 0.01));
        expect(maxCycleTimeBySteps(100, 0.5), closeTo(1683.33, 0.01));
        expect(maxCycleTimeBySteps(250, 0.5), closeTo(10458.33, 0.01));
        expect(maxCycleTimeBySteps(500, 0.5), closeTo(41750.00, 0.01));
        expect(maxCycleTimeBySteps(1000, 0.5), closeTo(166833.33, 0.01));
      });

      test("maxProcessTimeBySteps", () {
        expect(maxProcessTimeBySteps(10, 1, 0.5), closeTo(18.33, 0.01));
        expect(maxProcessTimeBySteps(25, 1, 0.5), closeTo(108.33, 0.01));
        expect(maxProcessTimeBySteps(50, 1, 0.5), closeTo(425.00, 0.01));
        expect(maxProcessTimeBySteps(100, 1, 0.5), closeTo(1683.33, 0.01));
        expect(maxProcessTimeBySteps(250, 1, 0.5), closeTo(10458.33, 0.01));
        expect(maxProcessTimeBySteps(500, 1, 0.5), closeTo(41750.00, 0.01));
        expect(maxProcessTimeBySteps(1000, 1, 0.5), closeTo(166833.33, 0.01));
      });

    });
  }
}
