function perm = genqmd (A)

[adj_num, node_num, adj_row, adj] =Matrice_adjacence(A);
%   for i1=1:length(adj_row)-1
%       adj( adj_row(i1) : adj_row(i1+1)-1 )=adj(adj_row(i1+1)-1 : -1 : adj_row(i1));
%   end; 


Mindeg= node_num; % le degré minimum
Nofsub= 0;
%Initialisation des variables de travail
for i=1:node_num
    
    perm(i)=i; % vecteur qui stocke l'ordre du minimum degree
    invp(i)=i; % Son inverse
    
    marker(i)=0; % Si négatif alors le noeud a déjà été fusionné et donc on peut l'ignorer
    Qsize(i)=1;  % Vecteur qui stocke la taille des supernoeuds indiscernables
    Qlink(i)=0;  % Vecteur qui stocke les noeuds indiscernables. 
   
    Ndeg=adj_row(i+1)-adj_row(i);
    Deg(i)=Ndeg; % degré du noeud i
    
    if(Ndeg<Mindeg) 
        Mindeg=Ndeg;
    end
end

Num=0;
% perm=[6,2,1,4,5,3];
% marker=[0 -1 0 0 0 -1];
% Adj=[3 0 1 3 0 1 1 4 5 3 5 3 4 2];
% Deg=[-1 -1 2 2 2 -1];
% Recherche par seuil pour avoir le noeud de degré minimum
    search = 1; 
    thresh = Mindeg; % variable seuil
    Mindeg = node_num;
    while (Num<node_num)
        
        Nump1=Num+1;
        if (Nump1 > search)
            search=Nump1;
        end
        
        for j=search:node_num
            node=perm(j);
            if (marker(node) >= 0)
                Ndeg=Deg(node);
                if (Ndeg <= thresh) 
                    % j est un noeud de degré minimum
                    search=j;
                    
                    % on trouve ces "reachable sets".
                            Nofsub=Nofsub+Deg(node);
                            marker(node)=1; 
                            [rchsze,rchset,nbrsze,nbrhd,marker] = qmdrch ( node,node_num,adj_num,adj_row,adj, Deg,marker);
                            
                            % Eliminer les noeuds indiscernables
                            % Ils sont donnés par node, Qlink(node)
                            Nxnode=node;
                            while (Nxnode > 0)
                                Num=Num+1;        
                                NP=invp(Nxnode);                    
                                IP=perm(Num);                      
                                perm(NP)=IP;                  
                                invp(IP)=NP;                     
                                perm(Num)=Nxnode;                    
                                invp(Nxnode)=Num;                  
                                Deg(Nxnode)= -1;                
                                Nxnode = Qlink(Nxnode);
                            end
                          
                            
                            if (rchsze > 0)
                                %Mettre à jour les degrés des noeuds dans
                                %les "reachable sets" et identifier les
                                %noeuds indiscernables              
                                [Deg,Qsize,Qlink,marker] = qmdupd ( node_num,adj_num,adj_row,adj, rchsze,rchset, Deg,Qsize,Qlink,marker);            
                                
            

                                % Remettre la valeur de "marker" des noeuds
                                % dans les "reachable sets" à 0
                                % Mettre à jour la valeur du seuil pour la
                                % recherche cyclique
                                marker(node)=0;  
                                for i=1:rchsze
                                    inode=rchset(i);
                                    if (marker(inode)>=0)       
                                        marker(inode)=0;     
                                        Ndeg=Deg(inode);       
                                        if (Ndeg < Mindeg)         
                                            Mindeg=Ndeg;   
                                        end
                                        if (Ndeg <= thresh)
                                            Mindeg=thresh; 
                                            thresh=Ndeg; 
                                            search=invp(inode);
                                        end
                                    end
                                end
                                % Faire appel à la fonction qmdqt pour
                                % former le nouveau graphe quotient
                                if (nbrsze > 0)
                                    [adj] = qmdqt ( node,node_num,adj_num,adj_row,adj, rchsze,rchset,nbrhd,marker);
                                end
                               
                            end
                           
                break
                end
                

                if (Ndeg < Mindeg) 
                    Mindeg=Ndeg;
                end
            end
            if j==node_num
                search = 1;
                thresh = Mindeg;
                Mindeg = node_num;
            end
        end
        


    end

    return
end
