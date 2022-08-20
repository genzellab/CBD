function [C]=create_timecell(ro,leng)
%create_timecell(ro,leng)
    fn=600;
    vec=-ro/fn:1/fn:ro/fn;
    C    = cell(1, leng);
    C(:) = {vec};
end