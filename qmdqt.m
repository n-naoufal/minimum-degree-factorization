function [adj] = qmdqt ( root,node_num,adj_num,adj_row,adj, rchsze,rchset,nbrhd,marker)


Irch= 0 ;
Inhd= 0 ;
node=root;

Jstart= adj_row(node);
Jstop= adj_row(node+1)-2;
   
while (Jstop < Jstart)
    % Attacher aux autres espaces donnés par les ensembles voisins
    link= adj(Jstop+1);
    node= -link;
    if( link >=0 )
        Inhd=Inhd+1;
        node=nbrhd(Inhd);
        adj(Jstop+1)=-node;
    end
    Jstart= adj_row(node);
    Jstop= adj_row(node+1)-2;
end

if (Jstop >= Jstart)
    % Placer les noeuds accessibles dans une liste adjacente de noeuds
    for j=Jstart:Jstop
        Irch = Irch +1;
        adj(j)=rchset(Irch);
        if (Irch >= rchsze)
            adj(j+1)=0;
            break
        end
        
    end
% Tous les noeuds des "reachable sets" ont été sauvegardés
% Clore la liste "Adj"

for Irch=1:rchsze
    node=rchset(Irch);
    if ( marker(node) >= 0 )
        Jstart= adj_row(node);
        Jstop= adj_row(node+1)-1;
        for j=Jstart:Jstop
            nbr=adj(j);
            if (marker(nbr) < 0)
                adj(j)=root;
                break
            end
        end
    end
end

    
end


return

end
        
        
        
        
        