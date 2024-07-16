function [total_count_vec]=replace_with_nans(total_count,total_count_rate)

    total_count_vec=total_count(:);
    total_count_vec(isnan(total_count_rate(:)))=NaN;
    total_count_vec=reshape(total_count_vec,[19,10]);

end