function [Deg,Qsize,Qlink,marker] = qmdupd ( node_num,adj_num,adj_row,adj, Nlist,list, Deg,Qsize,Qlink,marker)


% Trouver tous les supernoeuds éliminés qui sont adjacents à certains
% noeuds dans la liste donnée

% Les mettre dans les ensembles voisins (nbrhd, nbrsze)

%Deg0 contient le nombre de noeuds dans la liste 
if( Nlist <= 0)
    return
end

Deg0= 0;
nbrsze= 0;

for i=1:Nlist
    node=list(i);
    Deg0=Deg0+Qsize(node);
    jstart=adj_row(node);
    jstop=adj_row(node+1)-1;
    
    for j=jstart:jstop
        nbr=adj(j);
        if (marker(nbr)==0 & Deg(nbr)<0) 
            marker(nbr) = -1;
            nbrsze=nbrsze+1;
            nbrhd(nbrsze)=nbr;
        end
    end
end

% Fusionner les noeuds indiscernables dans la liste en faisant appel à
% QMDMRG
if (nbrsze >0)
    [Deg,Qsize,Qlink,marker] = qmdmrg ( node_num,adj_num,adj_row,adj, Deg0, nbrsze,nbrhd, Deg,Qsize,Qlink,marker);
end
% Trouver les nouveaux degrés des noeuds qui n'ont pas été fusionnés
for i=1:Nlist
    node=list(i);
    mark=marker(node);
    if (mark ==0 || mark==1 )
        marker(node) = 2;
        
        [rchsze,rchset,nbrsze,nbrhd,marker] = qmdrch ( node,node_num,adj_num,adj_row,adj, Deg,marker);
        
        Deg1=Deg0;
        if (rchsze > 0)
            for  Irch=1:rchsze
                Inode=rchset(Irch);
                Deg1=Deg1 + Qsize(Inode);
                marker(Inode) = 0;
            end
        end
        Deg(node)= Deg1 - 1;
        if (nbrsze > 0)
            for Inbr=1:nbrsze
                Inode=nbrhd(Inbr);
                marker(Inode)=0;
            end
        end
    end
end

return
end
                
              