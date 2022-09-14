function [x,y,z,w,h,q,l,p,si_mixed,th,PCA_features_v,...
    xc,yc,zc,wc,hc,qc,lc,pc,PCA_features_r]= specsHist(si,sc,timeasleep,print_hist)
%Computes main features of events detected.
% Inputs:
% si   - traces from vehicle data
% sc   - traces from CBD data
% timeasleep - maybe set to 0
% print_hist - maybe set to 1 to produce histogram plots
%
% Outputs:
% x,xc - Instantaneous Frequencies
% y,yc - Average frequency
% z,zc - Amplitude
% l,lc - Area under the curve
% w,wc - Count
% h,hc - Rate
% q,qc - Duration
% p,pc - Peak-to-peak distance
% 
PCA_features_v=[];
    if ~isempty(si)

        %Instantaneous frequency.
        x=cellfun(@(equis) mean(instfreq(equis,600)) ,si,'UniformOutput',false);
        x=cell2mat(x);
        xc=cellfun(@(equis) mean(instfreq(equis,600)) ,sc,'UniformOutput',false);
        xc=cell2mat(xc);
        if print_hist==1
            subplot(3,2,1)
           % xlim([100 250])
            hold on
            histogram(x,'FaceColor',[0.75 0.75 0.75],'Normalization','probability')
            histogram(xc,'FaceColor',[0.4 0.8 0.1],'Normalization','probability'); 
            title('Instantaneous Frequencies');xlabel('Frequency (Hz)');ylabel('probability')
            hold off 
            legend('Vehicle','CBD')
%             ylim([0 35])
        end
        PCA_features_v(:,1)=x;
        PCA_features_r(:,1)=xc;
        
        %Average frequency
        y=cellfun(@(equis) (meanfreq(equis,600)) ,si,'UniformOutput',false);
        y=cell2mat(y);
        yc=cellfun(@(equis) (meanfreq(equis,600)) ,sc,'UniformOutput',false);
        yc=cell2mat(yc);
        th=NaN;
        si_mixed.g1=NaN;
        si_mixed.i1=NaN;
        si_mixed.g2=NaN;
        si_mixed.i2=NaN;
 
        if print_hist==1
            subplot(3,2,2)
%             xlim([100 250])
            hold on
            histogram(y,'FaceColor',[0.75 0.75 0.75],'Normalization','probability');
            histogram(yc,'FaceColor',[0.4 0.8 0.1],'Normalization','probability');
            title('Average Frequencies');xlabel('Frequency (Hz)');ylabel('probability')
            hold off
            legend('Vehicle','CBD')   
        end
        PCA_features_v(:,2)=y;
        PCA_features_r(:,2)=yc;
        
        %Amplitude
        z=cellfun(@(equis) max(abs(hilbert(equis))) ,si,'UniformOutput',false);
        z=cell2mat(z);
        zc=cellfun(@(equis) max(abs(hilbert(equis))) ,sc,'UniformOutput',false);
        zc=cell2mat(zc);
        if print_hist==1
            subplot(3,2,3)
%             xlim([0 30])
            hold on
            histogram(z,'FaceColor',[0.75 0.75 0.75],'Normalization','probability');
            histogram(zc,'FaceColor',[0.4 0.8 0.1],'Normalization','probability');
            title('Amplitude');xlabel('\muV');ylabel('probability') 
            hold off
            legend('Vehicle','CBD')          
        end
        PCA_features_v(:,3)=z;
        PCA_features_r(:,3)=zc;
        
        %Area under the curve
        l=cell2mat(cellfun(@(equis) trapz((1:length(equis))./600,abs(equis)),si,'UniformOutput',false));
        lc=cell2mat(cellfun(@(equis) trapz((1:length(equis))./600,abs(equis)),sc,'UniformOutput',false));
        if print_hist==1
            subplot(3,2,4)
%             xlim([0 0.5])
            hold on
            histogram(l,'FaceColor',[0.75 0.75 0.75],'Normalization','probability')
            histogram(lc,'FaceColor',[0.4 0.8 0.1],'Normalization','probability');
            title('Area under the curve');xlabel('AUC');ylabel('probability')
            hold off
            legend('Vehicle','CBD')
        end
        PCA_features_v(:,4)=l;
        PCA_features_r(:,4)=lc;

        %Count
        w=length(si);
        wc=length(sc);

        %Rate
        h=w/(timeasleep*(60));
        hc=wc/(timeasleep*(60));
        
        %Duration
        q=(cellfun('length',si)/600)*1000;
        qc=(cellfun('length',sc)/600)*1000;
        
        if print_hist==1
            subplot(3,2,5)
            hold on
            histogram(q,'FaceColor',[0.75 0.75 0.75],'Normalization','probability')
            histogram(qc,'FaceColor',[0.4 0.8 0.1],'Normalization','probability');
            title('Duration');xlabel('Milliseconds');ylabel('probability')
            hold off
            legend('Vehicle','CBD')
        end
        PCA_features_v(:,5)=q;
        PCA_features_r(:,5)=qc;
        
        %Peak-to-peak distance
        p=cellfun(@peak2peak,si);
        pc=cellfun(@peak2peak,sc);
        if print_hist==1
            subplot(3,2,6)
%             xlim([0 45])
            hold on
            histogram(p,'FaceColor',[0.75 0.75 0.75],'Normalization','probability')
            histogram(pc,'FaceColor',[0.4 0.8 0.1],'Normalization','probability');
            title('Peak-to-peak amplitude');xlabel('\muV');ylabel('probability')
            hold off
            legend('Vehicle','CBD')           
        end
                PCA_features_v(:,6)=p;
                PCA_features_r(:,6)=pc;

    else

        x=NaN;
        y=NaN;
        z=NaN;
        w=NaN;
        h=NaN;
        q=NaN;
        l=NaN;
        p=NaN;
        th=NaN;
        si_mixed.g1=NaN;
        si_mixed.i1=NaN;
        si_mixed.g2=NaN;
        si_mixed.i2=NaN;
    end

end
