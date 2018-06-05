## QMD algorithm 

Here is a robust Matlab code for the quotient minimum degree algorithm (QMD). 

In numerical analysis the minimum degree algorithm is an algorithm used to permute the rows and columns of a symmetric sparse matrix before applying the Cholesky decomposition, to reduce the number of non-zeros in the Cholesky factor. Minimum degree algorithms are often used in the finite element method where the reordering of nodes can be carried out depending only on the topology of the mesh, rather than the coefficients in the partial differential equation, resulting in efficiency savings when the same mesh is used for a variety of coefficient values. 

QMD algorithm has a tight upper bound of O(n²m).


## Context

The problem of finding the best ordering is an NP-complete problem and is thus intractable, so heuristic methods are used instead. The minimum degree algorithm is derived from a method first proposed by Markowitz in 1959 for non-symmetric linear programming problems, which is loosely described as follows. At each step in Gaussian elimination row and column permutations are performed so as to minimize the number of off diagonal non-zeros in the pivot row and column. A symmetric version of Markowitz method was described by Tinney and Walker in 1967 and Rose later derived a graph theoretic version of the algorithm where the factorization is only simulated, and this was named the minimum degree algorithm. A crucial aspect of such algorithms is a tie breaking strategy when there is a choice of renumbering resulting in the same degree.


## Inputs & outputs

```
perm : the output permutation vector
A    : the initial matrix
```

## Algorithm steps
```
Step 1   : Initialization of the work variables
Step 2   : Select the minimum degree node
Step 3   : Elimination of the node "NODE"  and its indistinguishable nodes.
Step 4   : Update degrees
Step 4-1 : Identification of indistinguishable nodes "RCHSET"
Step 4-2 : Merging indistinguishable nodes
Step 4-3 : Calcule degrees of indistinguishable nodes
Step 4-4 : Calculate degrees of unmerged nodes of "RCHSET"
Step 4-5 : Updating the threshold value for the new minimum degree search
Step 5   : Transforming the graph quotient
```

## Subroutines


* Matrix_adjacence: routine converting from a matrix to a structure of graph with two lists: Adj, list of adjacent to each vertex, and Adj_row, list of pointers to the first items in each list of adjacent.

* Qmdrch: routine to search for the reachable set of eliminated nodes, by putting this  set into RCHSET and then putting the set together with the eliminated vertices used in NBRHD

* Qmdind : routine to identify indistinguishable vertices, to merge them and then calculate the degree of the new supernode

* Qmdqt  : routine to switch from the G_k quotient graph to the quotient graph G_ (k+1)



