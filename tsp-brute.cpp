#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <algorithm>
#include <cmath>
#include <limits>

using namespace std;

int n;
const int nmin = 1, nmax = 64;

int cities[nmax], route[nmax];
double min_len = numeric_limits<double>::infinity(); 
double dist[nmax][nmax];

// Returns the full cycle length for the current permutation of cities
double route_len(const int cities[])
{
	double len = 0;
	for (int i = 1; i <= n; i++)
		len += dist[cities[i - 1]][cities[i % n]];

	return len;
}

void print_route(const int cities[])
{
	for (int i = 0; i <= n; i++)
		printf("%d ", cities[i % n]);
	printf("\n");
}

// Recursively checks the cycle cost of all (n - 1)! city permutations
void tsp(int i = 1)
{
	if (i == n) {
		double len = route_len(cities);
		if (len < min_len) {
			copy(cities, cities+n, route);
			min_len = len;
		}

		return;
	}

	for (int j = i; j < n; j++) {
		swap(cities[i], cities[j]);
		tsp(i+1);
		swap(cities[i], cities[j]);
	}
}

void read_distances()
{
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			cin >> dist[i][j];
		}
	}
}

int main(int argc, char **argv)
{
	cin >> n;
	read_distances();

	for (int i = 0; i < n; i++)
		cities[i] = i;

	tsp();
	print_route(route);
	printf("%0.2f\n", min_len);

	return 0;
}
