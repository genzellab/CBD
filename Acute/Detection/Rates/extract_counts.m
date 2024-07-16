function [total_count,ripples_count,sharpwaves_count,sharpwaveripples_count,complexsharpwaveripples_count]=extract_counts(filename)

% Read the .xls file into a table
counts = readtable(filename,'Sheet','TotalCount');

%Re-arrange rats
[x,ind]=sort(table2array(counts(:,1)));

total_count=counts(ind,:);

% Read the .xls file into a table
counts = readtable(filename,'Sheet','RipplesCount');

%Re-arrange rats
[x,ind]=sort(table2array(counts(:,1)));

ripples_count=counts(ind,:);

% Read the .xls file into a table
counts = readtable(filename,'Sheet','SharpWavesCount');

%Re-arrange rats
[x,ind]=sort(table2array(counts(:,1)));

sharpwaves_count=counts(ind,:);

% Read the .xls file into a table
counts = readtable(filename,'Sheet','SharpWaveRipplesCount');

%Re-arrange rats
[x,ind]=sort(table2array(counts(:,1)));

sharpwaveripples_count=counts(ind,:);

% Read the .xls file into a table
counts = readtable(filename,'Sheet','ComplexSharpWaveRipplesCount');

%Re-arrange rats
[x,ind]=sort(table2array(counts(:,1)));

complexsharpwaveripples_count=counts(ind,:);


end