Traveling salesman problem
===

This repository features two different programming approaches for solving TSP:
* brute-force and
* dynamic programming.

The solvers assume all cities are connected to each other. The city distances
are passed using stdin, for example:

    ./tspsolver < input/20cities.in

The solver will give the shortest tour by returning it's sequence (starting and
ending with city 0), followed by the total length of the tour (i.e. the sum of
all edges or distances):

    0 9 16 5 10 15 13 6 19 11 17 3 14 7 1 8 2 12 4 18 0
    369.99

The input for the solvers is defined by a simple distance matrix. Here's how to
generate a randomized matrix with 20 cities and calculate it's shortest tour in
a single line (using ```pee``` from ```moreutils``` for redirecting generated
city distances to both stdout and the solver):

    ./genmatrix 20 | pee cat ./tspsolver
