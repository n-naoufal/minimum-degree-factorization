function [rchsze,rchset,nbrsze,nbrhd,marker] = qmdrch ( root,node_num,adj_num,adj_row,adj, Deg,marker)


% Loop through the neighbors of root in the quotient graph

nbrsze = 0; % Taille des ensembles voisins
rchsze = 0; % Taille des "reachable sets"
nbrhd=[]; % les ensembles voisins "neighborhood sets"
rchset=[]; % les "reachable sets"

istart = adj_row (root);
istop = adj_row (root+1)-1;
%Vérification logique
if (istop < istart)
    error('Fatal error');
end

for i=istart:istop
    nbr=adj(i); % Voisin = nabor en Anglais
    if(nbr==0)
        return
    end
    if (marker(nbr) == 0)
        if (Deg(nbr) >= 0)
            %Inclure les voisins dans les "reachable sets"
            rchsze=rchsze +1;
            rchset(rchsze)=nbr;
            marker(nbr)=1;
        else 
            % le voisin a été éliminé (deg negatif)
            % Trouver les noeuds accessibles à travers ce dernier
            marker(nbr)=-1;
            nbrsze= nbrsze +1;
            nbrhd(nbrsze)=nbr;
            jstart = adj_row (nbr);
            jstop = adj_row (nbr+1)-1;
            for j=jstart:jstop
                node=adj(j);
                nbr=-node;
                
                while (node<0)
                      jstart = adj_row (nbr);
                      jstop = adj_row (nbr+1)-1;
                      for j1=jstart:jstop
                             node=adj(j1);
                             nbr=-node;
                      end
                end
                
                if (node==0)
                    break
                elseif (node>0)
                    
                    if(marker(node)==0)
                    rchsze=rchsze + 1;
                    rchset(rchsze) = node;
                    marker(node) = 1; 
                    end
                end
            end

        end
    end
end

return

end