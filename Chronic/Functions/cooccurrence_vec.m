function [co_vec1, co_vec2, count_co_vec1, count_co_vec2]=cooccurrence_vec(a_s,a_e,n_s, n_e)
%%% This function finds co occurrences between event 1 and event 2
%    input:
%           a_s, a_e: start and stop of event 1
%           n_s, n_e: start and stop of event 2
%    output:,
%           co_vec1 : index of cooccurring event 1
%           co_vec2 : index of cooccurring event 2
%           count_co_vec1 : total count of cooccurring event 1
%           count_co_vec2 : total count of cooccurring event 2

% To correct for repititions, use unique(co_vec1) or unique(co_vec2)
    

    co_vec1=[];%HPC
    co_vec2=[];%Cortex
    total_event=[];
    for i=1:length(a_s)

        j = find(  n_s>=a_s(i) & n_e<=a_e(i) | a_s(i)<=n_s & n_s<=a_e(i) & a_e(i)<=n_e  | n_s<=a_s(i) & a_s(i)<=n_e  & n_e<=a_e(i) |...
            n_s<=a_s(i) & n_e>=a_e(i) & (n_e-n_s)>(a_e(i)-a_s(i)) );
        
        if ~isempty(j)
            co_vec1 = [co_vec1; i];
            co_vec2 = [co_vec2; j];            
        end
%         if ~isempty(j)
%             co_vec1 = [co_vec1; i];
%             co_vec2 = [co_vec2; j];
%         end        
        
    end
    
    count_co_vec1 = length(unique(co_vec1));
    count_co_vec2 = length(unique(co_vec2));
    
end
