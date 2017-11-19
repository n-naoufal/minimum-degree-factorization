function [Deg,Qsize,Qlink,marker] = qmdmrg ( node_num,adj_num,adj_row,adj, Deg0, nbrsze,nbrhd, Deg,Qsize,Qlink,marker)

%initialisation

if (nbrsze <= 0 ) 
    return
end

for Inbr=1:nbrsze
    root=nbrhd(Inbr);
    marker(root)=0;
end

%Boucle à travers chaque supernoeud éléminé dans l'ensemble des voisins (nbrsze,nbrhd)
for Inbr=1:nbrsze
    root=nbrhd(Inbr);
    marker (root)=-1;
    rchsze=0;
    novrlp=0;
    Deg1=0;
    jstart=adj_row(root);
    jstop=adj_row(root+1)-1;
    % Identifier les "reachable sets" et leurs intersection avec notre
    % "reachable set" de départ
    for j=jstart:jstop
        nbr=adj(j);
        root=-nbr;
        
        while (nbr<0)  
            jstart=adj_row(root);
            jstop=adj_row(root+1)-1;
                for j1=jstart:jstop
                    nbr=adj(j1);
                    root=-nbr;
                end
        end
        
        if (nbr==0)
            break
        end

        if (nbr>0)  
        mark=marker(nbr);
            if (mark==0)
                rchsze=rchsze+1;
                rchset(rchsze)=nbr;
                Deg1=Deg1+Qsize(nbr);
                marker(nbr)=1;
     
            elseif (mark==1)
                    novrlp=novrlp+1;
                    ovrlp(novrlp)=nbr;
                    marker(nbr)=2;

            end
            %Déterminer les noeuds qui peuvent être fusionnés dans
            %l'ensemble chevauché
        end
    end
                head=0;
                mrgsze=0;
                for Iov=1:novrlp
                    node=ovrlp(Iov);
                    jstart=adj_row(node);
                    jstop=adj_row(node+1)-1;
                    for j=jstart:jstop
                        nbr =adj(j);
                        if (marker(nbr) ==0)
                            marker(node)=1;
                            break
                        end
                    end
                    if (marker(nbr) ==0)
                        continue
                    end
                    % le noeud appartient au nouveaux supernoeuds fusionnés
                    % Mettre à jour les vecteurs Qlink et Qsize
                    mrgsze=mrgsze + Qsize(node);
                    marker(node)=-1;
                    lnode=node;
                    link=Qlink(lnode);
                    while (link >0)
                        lnode=link;
                        link=Qlink(lnode);
                    end
                    Qlink(lnode)=head;
                    head=node;
                end
                if (head>0)
                    Qsize(head)=mrgsze;
                    Deg(head)=Deg0+Deg1-1;
                    marker(head)=2;
                end
                % Remttre à zéro les valeurs de "marker"
                root=nbrhd(Inbr);
                marker(root)=0;
                if (rchsze >0)
                    for Irch=1:rchsze
                        node=rchset(Irch);
                        marker(node)=0;
                    end
                end 
        end

return
end
    
    
    
    
 
        