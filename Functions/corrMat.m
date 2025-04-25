%%%This script generates a cosine similarity matrix for depicting the
%%%relationship between population vectors throughout time series,
%%%weighting the activation of a neuron as binary across the whole
%%%experiment, given by the tf-idf normalization.%%%
%%%
%%%
%%% Gamaliel Isaias Mendoza Cuevas
%%%INB-UNAM. 2019.


function corrMat (bins)
clear; close; clc
[bins]= uigetfile;
bins=open(bins);
fnms=fieldnames(bins);
bins=bins.(fnms{1});


M=zeros((size(bins,1)*2),size(bins,2));

%%% Normalices occurence of activation along the series of time, extracting
%%% the tf normalization
for i=1:size(bins,1)
    for j=1:size(bins,2)
        tf(i)=sum(bins(i,:)==1)/size(bins,2);
    end
end
tf=tf';

%%% Normalices occurence of activation along the series of time, extracting
%%% the idf normalization
for i=1:size(bins,1)
    val=max(bins(i,:));
    container=sum(bins(i,:)==val);
    for j=1:size(bins,2)
        idf(i)=log(size(bins,2)/(container));
    end
end
idf=idf';

%%%Calculates the weigth for each cell for vector
for i=1:size(bins,1)
    for j=1:size(bins,2)
        indivCell(i,j)=bins(i,j)*tf(i)*idf(i);
    end
end


%%%Gets the magnitud for each population vector
for i = 1:size(indivCell,2)
magnitudes(i)=sqrt(sum(indivCell(:,i).^2));
%directions(i)=sum(bins(:,i))/magnitudes(i);
end

%%% Calculates the similarity betweeen vectors, as the cosine similarity 
%%% between all the vectors and all the vectors
for i = 1:size(indivCell,2)
    v1=indivCell(:,i);
    for j = 1:size(indivCell,2)
    v2=indivCell(:,j);
    crossProd=sum(v1.*v2);
    M(i,j)=(crossProd)/(magnitudes(i)*magnitudes(j));
    M(j,i)=M(i,j);
    end
end 


%%% Makes images of the matrix container of the cosine similarities (i,.j)
%%% and viceversa.
M=flip(M);
matriz=imagesc(M);
colormap('jet')
barra=colorbar;
F=title(barra,'Similarity index');
F.Rotation=90;
F.Position=[50 120 0];



xlabel('i Vector (t)');
ylabel('j Vector (t)');
title('Correlation matrix')
axis('square')
saveas(matriz,'SimilIn','jpeg')

end