Traveling salesman problem
===

This repository features two different programming approaches for solving TSP:
- brute-force
- dynamic programming

The solvers assume all cities are connected to each other. The city coordinates
are passed using stdin, for example:

    ./tsp-solver < input/20cities.in

The solver will give the shortest tour by returning the sequence of cities,
followed by the total length of the tour:

    0 9 16 5 10 15 13 6 19 11 17 3 14 7 1 8 2 12 4 18 0
    369.99

The input for the solvers is defined by a simple distance matrix. Here's how to
generate a randomized matrix with 20 cities and calculate it's shortest tour in
a single command (using ```pee``` from ```moreutils```):

    ./gen-matrix 20 | pee cat ./tsp
