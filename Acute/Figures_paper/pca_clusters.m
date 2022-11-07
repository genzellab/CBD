   % We retrieve the 2 first components
%         PC1 = sum(data2cluster_norm' .* coeff(:,1), 1);
%         PC2 = sum(data2cluster_norm' .* coeff(:,2), 1);   
        PC1 = PCres{1};
        PC2 = PCres{2};   

        %Let's detect the outliers
        pca_outliers = isoutlier(abs(PC1) + abs(PC2), 'Percentiles',[0 99.9]);

    %     clusters = kmeans([log(PC1)'  real(log(PC2))'],2);
    % Choose between 2 or 3 clusters based on silhouette plots
        clusters2 = kmeans([PC1(pca_outliers==0)'  PC2(pca_outliers==0)'],2, 'MaxIter', 500);
        silh2 = silhouette([PC1(pca_outliers==0)'  PC2(pca_outliers==0)'],clusters2,'cityblock');
        clusters3 = kmeans([PC1(pca_outliers==0)'  PC2(pca_outliers==0)'],3, 'MaxIter', 500);
        silh3 = silhouette([PC1(pca_outliers==0)'  PC2(pca_outliers==0)'],clusters3,'cityblock');
        if mean(silh2)>mean(silh3)
            clusters = clusters2;
            nclus = 2;
        else
            clusters = clusters3;
            nclus = 3;
        end
            clusters = clusters2;
            nclus = 2;  

%         clusters = kmeans([PC1(pca_outliers==0)'  PC2(pca_outliers==0)'],3, 'MaxIter', 500);
        %If one epoch alone is into other cluster, make it into same cluster
        %than rest ==> Seems like a bad idea
        index = 2;
        while index <= (length(clusters)-1)
            if clusters(index-1) == clusters(index+1) & clusters(index) ~= clusters(index-1)
                clusters(index) = clusters(index-1);
                index = index+1;
            end
            index = index+1;
        end
%%
PC1=PC1(~pca_outliers);
PC2=PC2(~pca_outliers);
%%
clusters=clusters2;
colors = zeros(length(clusters),3);
    colors(clusters == 1,:) = repmat([0.3 1 0.2], length(colors(clusters == 1)),1);
    colors(clusters == 2,:) = repmat([ 0 0.5 1], length(colors(clusters == 2)),1);
%     colors(clusters == 3,:) = repmat([ 1 0.2 0.2], length(colors(clusters == 3)),1);
%    scatter(PC1, PC2, [], colors)
p=gkde2_contour([PC1(clusters==1); PC2(clusters==1)].');
[M,c]=contour(p.x,p.y,p.pdf,4);
c.LineColor=[ 0.3 1 0.2]
hold on
p=gkde2_contour([PC1(clusters==2); PC2(clusters==2)].');
[M,c]=contour(p.x,p.y,p.pdf,4);
c.LineColor=[ 0 0.5 1]
    
    
    xlabel('PC1')
    ylabel('PC2')
    title('PCA clusters')
    
    %%
f=gcf;
set(f,'Units','centimeters')
% h.Position(1)=0;
% h.Position(2)=0;
f.Position(3)=3;
f.Position(4)=3;
f.PaperSize=[3.05 3.05]
% f.Position(3)=3.5;
% f.Position(4)=3.5;
% f.PaperSize=[3.55 3.55]
%xo
ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8;
ax.FontName='Arial';
%%
filename='PCA_clusters_contours';
printing_image(filename)
print('-painters',f,filename,'-dpdf');%'-r0'


