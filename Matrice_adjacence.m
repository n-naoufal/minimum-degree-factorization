function [num_adj, num_node, xadj, adj] =Matrice_adjacence(A)
num_node = size(A,1);
adj_max = num_node * ( num_node - 1 );
num_adj = 0;
xadj = [];
adj = [];
A=A-diag(diag(A));

for i=1:size(A,1)
    ind=find(A(i,:));
    xadj = [xadj,length(adj)+1];
    adj=[adj,ind];
end 
xadj = [xadj,length(adj)+1];
num_adj = length(adj);

end 

