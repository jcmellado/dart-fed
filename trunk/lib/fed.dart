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

library fed;

import "dart:math" as math;

import "package:fed/src/fed_util.dart";

part "src/fed_kappa.dart";

/**
 * Allocates an array of [n] time steps and fills it with FED time step sizes,
 * such that the maximal stopping time for this cycle is obtained. [tauMax] is
 * the stability limit. Use [reordering] if time steps should be reordered
 * using kappa cycles.
 *
 * See [ReorderingMode]
 */
List<double> tauBySteps(int n, double tauMax, KappaLookup reordering) {
  return _tau(n, 1.0, tauMax, reordering);
}

/**
 * Allocates an array of the least number of time steps such that a certain
 * stopping time per cycle [t] can be obtained and fills it with the respective
 * FED time step sizes. [tauMax] is the stability limit. Use [reordering] if
 * time steps should be reordered using kappa cycles.
 *
 * See [ReorderingMode]
 */
List<double> tauByCycleTime(double t, double tauMax, KappaLookup reordering) {
  // Number of time steps.
  var n = ((math.sqrt(((3 * t) / tauMax) + 0.25) - 0.5 - 1.0e-8)).ceil();

  // Ratio of t we search to maximal t.
  var scale = (3 * t) / (tauMax * (n * (n + 1)));

  return _tau(n, scale, tauMax, reordering);
}

/**
 * Allocates an array of the least number of time steps such that a certain
 * stopping time [t] for the whole process consisting of [m] cycles can be
 * obtained, and fills it with the respective FED time step sizes for one cycle.
 * [tauMax] is the stability limit. Use [reordering] if time steps should be
 * reordered using kappa cycles.
 *
 * See [ReorderingMode]
 */
List<double> tauByProcessTime(double t, int m, double tauMax, KappaLookup reordering) {
  return tauByCycleTime(t / m, tauMax, reordering);
}

/**
 * Computes the maximal cycle time that can be obtained using a certain
 * number of steps [n]. This corresponds to the cycle time that arises from a
 * tau array which has been created using [:tauBySteps(n, tauMax, reordering):].
 * [tauMax] is the stability limit.
 */
double maxCycleTimeBySteps(int n, double tauMax) {
  return (tauMax * (n * (n + 1))) / 3;
}

/**
 * Computes the maximal process time that can be obtained using a certain
 * number of steps [n] for the whole process consisting of [m] cycles. This
 * corresponds to the cycle time that arises from a tau array which has been
 * created using [:tauBySteps(n, tauMax, reordering):]. [tauMax] is the stability
 * limit.
 */
double maxProcessTimeBySteps(int n, int m, double tauMax) {
  return (tauMax * (n * (n + 1) * m)) / 3;
}

/**
 * Allocates an array of [n] relaxation parameters and fills it with the FED
 * based parameters for Fast-Jacobi. [omegaMax] is the stability limit. Use
 * [reordering] if time steps should be reordered using kappa cycles.
 *
 * See [ReorderingMode]
 */
List<double> relaxParams(int n, double omegaMax, KappaLookup reordering) {
  return _tau(n, 1.0, omegaMax, reordering);
}

/**
 * Allocates an array of [n] time steps and fills it with FED time step sizes.
 */
List<double> _tau(int n, double scale, double tauMax, KappaLookup reordering) {
  var tau = new List<double>(n);

  var c = math.PI / ((4 * n) + 2);
  var d = (scale * tauMax) / 2;
  var c2 = 2 * c;

  if (reordering == ReorderingMode.NONE) {
    for (var i = 0; i < n; ++ i) {
      var h = math.cos(c + (c2 * i));
      tau[i] = d / (h * h);
    }
  } else {
    var kappa = reordering(n);
    var prime = nextPrime(n);
    var k = 0;
    var index;

    for (var i = 0; i < n; ++ i) {
      while ((index = (k += kappa) % prime) > n)
      ;

      var h = math.cos(c + (c2 * -- index));
      tau[i] = d / (h * h);
    }
  }

  return tau;
}
