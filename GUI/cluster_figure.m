%%% The program stablishes the axes for the figure and depending of the
%%% index extracted by means of K-means or linkage, draws each point in
%%% color from 'colores'.

%%%It's the final step and hence displays "Done!" at the end of the program
%%%
%%%Gamaliel Isaias Mendoza Cuevas. 2019. INB-UNAM

function cluster_figure(mappedX,idx)
%     figure
     hold on
    xlabel('Component1'),ylabel('Component2'),zlabel('PCA3')
    %plot(mappedX(:,1),mappedX(:,2),'.'),
    colores= [.5 1 .5;1 0 0;0 0 1];%[75 0 130; 32 178 170]./255;
    for n=1:size(mappedX,1)
        plot(mappedX(n,1),mappedX(n,2),'.'...
            ,'color',colores(idx(n),:),'Markersize',20)
    end
    disp('Done!')
    
    
