# Quotient Minimum Degree algorithm 
Matlab code for the quotient minimum degree algorithm 

## Inputs & outputs

```
perm : the output permutation vector
A    : the initial matrix
```

## Overview

```
Step 1: Initialization of the work variables
Step 2: Select the minimum degree node
Step 3: Elimination of the node "NODE"  and its indistinguishable nodes.
Step 4: Update degrees
Step 4-1: Identification of indistinguishable nodes "RCHSET"
Step 4-2: Merging indistinguishable nodes
Step 4-3: Calcule degrees of indistinguishable nodes
Step 4-4: Calculate degrees of unmerged nodes of "RCHSET"
Step 4-5: Updating the threshold value for the new minimum degree search
Step 5: Transforming the graph quotient
```

## Subroutines

```
* Matrix_adjacence: routine converting from a matrix to a structure of graph with two lists: Adj, list of adjacent to each vertex, and Adj_row, list of pointers to the first items in each list of adjacent.

* Qmdrch: routine to search for the reachable set of eliminated nodes, by putting this  set into RCHSET and then putting the set together with the eliminated vertices used in NBRHD

* Qmdind : routine to identify indistinguishable vertices, to merge them and then calculate the degree of the new supernode

* Qmdqt  : routine to switch from the G_k quotient graph to the quotient graph G_ (k+1)


```

