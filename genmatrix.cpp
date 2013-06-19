#include <cstdio>
#include <ctime>
#include <algorithm>

int n;
const int nmin = 2, nmax = 64;
double dist[nmax][nmax];

void construct_matrix()
{
	for (int i = 0; i < n; i++) {
		for (int j = n-1; j > i; j--) {
			dist[i][j] = rand() % 90 + 10;
			dist[j][i] = dist[i][j];
		}
	}
}

void print_matrix()
{
	printf("%d\n", n);
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			printf("%.2f\t", dist[i][j]);
		}
		printf("\n");
	}
}

int main(int argc, char **argv)
{
	if (argc < 2) {
		fprintf(stderr, "Usage: %s <cities>\n", argv[0]);
		return 1;
	}

	n = atoi(argv[1]);

	if (n < nmin || n > nmax) {
		fprintf(stderr, "Incorrect number of cities\n");
		return 1;
	}

	srand(time(NULL));

	construct_matrix();
	print_matrix();

	return 0;
}
