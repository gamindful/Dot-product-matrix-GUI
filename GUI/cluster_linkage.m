%%%
%%%The program is a routine for indexing clusters with linkage, send
%%%parameters for image depiction and plotting of a dendrogram if desired
%%%
%%% Gamaliel Isaias Mendoza Cuevas. 2019. INB-UNAM

function cluster_linkage(mappedX)
Z=linkage(mappedX,'weighted','euclidean');
idx = cluster(Z,'maxclust',2);
assignin('base','idx',idx);
cluster_figure(mappedX,idx)
%%%___________The remaining two lines draw a dendrogram for Z and plots it
%%%with the whole number of vetor in the matrix___________________________
% figure(2)
% dendro=dendrogram(Z,0);
