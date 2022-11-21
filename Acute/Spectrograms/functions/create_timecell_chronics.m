function [C]=create_timecell_chronics(ro,leng)
%create_timecell(ro,leng)
    fn=2500;
    vec=-ro/fn:1/fn:ro/fn;
    C    = cell(1, leng);
    C(:) = {vec};
end