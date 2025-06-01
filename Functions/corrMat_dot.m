%%%[medianGosine,medianNoGosine,meanGosine,meanNoGosine,M]=corrMat_dot(bins,TItle,vectorname)
%
%%%This script generates a cosine similarity matrix for depicting the
%%%relationship between population vectors throughout time series,
%%%weighting the activation of a neuron as binary across the whole
%%%experiment, given by the tf-idf normalization.%%%
%%%
%%%
%%% 
%%%INB-UNAM. 2019.

% [bins]= uigetfile;
% bins= ['csm_' num2str(f-2) '.mat'];
% bins=load(bins);
% fnms=fieldnames(bins);
% bins=bins.(fnms{1});
function [medianGosine,medianNoGosine,meanGosine,meanNoGosine,M]=corrMat_dot(bins)
% function [medianGosine,medianNoGosine,meanGosine,meanNoGosine,M]=corrMat_dot(bins,Straggregate,vectorname)
% imlog=0;
M=zeros((size(bins,2)),(size(bins,2)));
imlog=1;
vectorname='Vector';
%%
for r=1:size(bins,2)
    v1=bins(:,r);
    v1=v1(~isnan(v1));
    for j=1:size(bins,2)
        try
            v2=bins(:,j);
            v2=v2(~isnan(v2));
            P=dot(v1,v2);
            m1=norm(v1);
            m2=norm(v2);
            magP=m1*m2;
            cs=P/magP;
            M(r,j)=cs;
            M(j,r)=cs;
        catch
            M(r,j)=nan;
            M(j,r)=nan;
        end
    end
end
%%
%%% Makes images of the matrix container of the cosine similarities (i,.j)
%%% and viceversa.
% M=flip(M);

for r = 1:size(M,1)
    for j=1:size(M,2)
        if isnan(M(r,j)) || isinf(M(r,j))
            M(r,j)=0;
        end
    end
end
% M=1-M;
Mhalf=floor(size(M,1)/2);
medianGosine=median(median(M(1:Mhalf,1:Mhalf)));
medianNoGosine=median(median(M(Mhalf+1:size(M,2),Mhalf+1:size(M,2))));
meanGosine=mean(mean(M(1:Mhalf,1:Mhalf)));
meanNoGosine=mean(mean(M(Mhalf+1:size(M,2),Mhalf+1:size(M,2))));
if imlog==1
    % simatFig=figure;
    img=imagesc(M);
    axis('square')
    e=colorbar;
    e.Label.String='Similarity index';
    colormap('jet')
    xlabel([vectorname ' i'])
    ylabel([vectorname ' j'])
    img.Parent.YDir='normal';
    % fi=applytofig(simatFig,'FontMode','scaled','FontSize','1','Color','cmyk','width',5,'height',5,'linewidth',.15);
%         print(gcf,'RT_LM_raster','-depsc')
%     print(mt,'Similitud_matrix','-depsc')
% % % % print(simatFig,'-vector','-depsc',['Similitud_matrix_' Straggregate])
% print(simatFig,'-vector','-dsvg',['Similitud_matrix_' Straggregate])
end
return
