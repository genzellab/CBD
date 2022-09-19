function criticality_plot(features,norm_type,treatment)
%norm_type: normalization type: string indicating either probability or
%cumcount. or CDF!
%treatment: 0 or 1 for cbd.

%  [x]=histogram(features,'Normalization','probability');
%  [N,edges,bin] = histcounts(features,'Normalization','probability');
 [N,edges,bin] = histcounts(features,'Normalization',norm_type);

% N=N/length(features);
Edges=edges+(edges(2)-edges(1))/2;
Edges=Edges(1:end-1);


%Plot
% figure()
if treatment==1
    plot(Edges,N,'Color','g','LineWidth',2)

else
    plot(Edges,N,'Color','k','LineWidth',2)
  
end

xlabel('Amplitude')
ylabel('Probability')


set(gca,'xscale','log')
 set(gca,'yscale','log')
end