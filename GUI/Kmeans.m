function Kmeans(mappedX)
idx=kmeans(mappedX(:,:),2);
assignin('base','idx',idx);
%k_means_id=idx;
cluster_figure(mappedX,idx)