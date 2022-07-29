function [x,y,z,w,h,q,l,p,si_mixed,th,PCA_features]= eachSpecs_hist(si,timeasleep,print_hist)
%Computes main features of events detected.

% x - Instantaneous Frequencies (print_hist = 0)
% y - Average frequency (print_hist = 1)
% z - Amplitude (print_hist = 2)
% l - Area under the curve (print_hist = 3)
% q - Duration (print_hist = 4)
% p - Peak-to-peak distance (print_hist = 5)

PCA_features=[];
    if ~isempty(si)

        %Instantaneous frequency.
        x=cellfun(@(equis) mean(instfreq(equis,1000)) ,si,'UniformOutput',false);
        x=cell2mat(x);
        if print_hist==0
            histogram(x,'Normalization','probability'); title('Instantaneous Frequencies');xlabel('Frequency (Hz)');ylabel('Count')
        end
        PCA_features(:,1)=x;
        
        %Average frequency
        y=cellfun(@(equis) (meanfreq(equis,1000)) ,si,'UniformOutput',false);
        y=cell2mat(y);
        th=NaN;
        si_mixed.g1=NaN;
        si_mixed.i1=NaN;
        si_mixed.g2=NaN;
        si_mixed.i2=NaN;
 
        if print_hist==1
            histogram(y,'Normalization','probability'); title('Average Frequencies');xlabel('Frequency (Hz)');ylabel('Count') 
        end
        PCA_features(:,2)=y;

        %Amplitude
        z=cellfun(@(equis) max(abs(hilbert(equis))) ,si,'UniformOutput',false);
        z=cell2mat(z);
        if print_hist==2
            histogram(z,'Normalization','probability'); title('Amplitude');xlabel('\muV');ylabel('Count')
        end
        PCA_features(:,3)=z;
        
        %Area under the curve
        l=cell2mat(cellfun(@(equis) trapz((1:length(equis))./1000,abs(equis)),si,'UniformOutput',false));
        if print_hist==3
            histogram(l,'Normalization','probability'); title('Area under the curve');xlabel('AUC');ylabel('Count')            
        end
        PCA_features(:,4)=l;
        
        %Count
        w=length(si);

        %Rate
        h=w/(timeasleep*(60));

        %Duration
        q=(cellfun('length',si)/600)*1000;
        if print_hist==4
            histogram(q,'Normalization','probability'); title('Duration');
            xlabel('Milliseconds');ylabel('Count')   
        end
        PCA_features(:,5)=q;
        
        %Peak-to-peak distance
        p=cellfun(@peak2peak,si);
        if print_hist==5
            histogram(p,'Normalization','probability'); title('Peak-to-peak amplitude');xlabel('\muV');ylabel('Count');   
        end
                PCA_features(:,6)=p;

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
