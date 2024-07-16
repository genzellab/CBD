clear variables
% Specify the path to the .xls file
filename = 'counts_rem.xls';

[total_count,ripples_count,sharpwaves_count,sharpwaveripples_count,complexsharpwaveripples_count]=extract_counts(filename);


%%
% Specify the path to the .xls file
filename = 'amount_of_NREM_binned.xlsx';

% Read the .xls file into a table
amount = readtable(filename);

% Display the first few rows of the table
head(amount);

%% NREM
V = amount{1:19, 3:13};
% EMPTY means no recording, NAN in this case is Zero NREM but sleep.
%Replace NaNs with zeros
for i = 1:size(V, 1)
    for j = 1:size(V, 2)
        if strcmp(V{i,j},'NaN')
            V{i, j} = '0';
        end
    end
end

% Replace empty cells with NaNs
for i = 1:size(V, 1)
    for j = 1:size(V, 2)
        if isempty(V{i, j})
            V{i, j} = 'NaN';
        end
    end
end


nrem_amount = cellfun(@str2double, V);
nrem_amount=nrem_amount(:,1:10);
%%
% V = amount{24:42, 3:13};
% total_amount = cellfun(@str2double, V);
% %%
% rem=total_amount-nrem_amount;
% 
% % Replace empty cells with zeros
% for i = 1:size(rem, 1)
%     for j = 1:size(rem, 2)
%         if rem(i,j)<0
%             rem(i,j)=0;
%         end
%     end
% end
%%
% Specify the path to the .xls file
filename = 'rem_amount.xlsx';

% Read the .xls file into a table
rem_amount = readtable(filename);
rem_amount= rem_amount(:,2:end);
rem_amount=table2array(rem_amount);
%%
% total_count = total_count{1:19, 3:12};
% total_count_rate=total_count./rem_amount;
% [total_count_vec]=replace_with_nans(total_count,total_count_rate);
% 
% ripples_count = ripples_count{1:19, 3:12};
% ripples_count_rate=ripples_count./rem_amount;
% [ripples_count_vec]=replace_with_nans(ripples_count,ripples_count_rate);
% 
% sharpwaves_count = sharpwaves_count{1:19, 3:12};
% sharpwaves_count_rate=sharpwaves_count./rem_amount;
% [sharpwaves_count_vec]=replace_with_nans(sharpwaves_count,sharpwaves_count_rate);
% 
% 
% sharpwaveripples_count = sharpwaveripples_count{1:19, 3:12};
% sharpwaveripples_count_rate=sharpwaveripples_count./rem_amount;
% [sharpwaveripples_count_vec]=replace_with_nans(sharpwaveripples_count,sharpwaveripples_count_rate);
% 
% 
% complexsharpwaveripples_count = complexsharpwaveripples_count{1:19, 3:12};
% complexsharpwaveripples_count_rate=complexsharpwaveripples_count./rem_amount;
% [complexsharpwaveripples_count_vec]=replace_with_nans(complexsharpwaveripples_count,complexsharpwaveripples_count_rate);
%%
% Cell array of variable names
varNames = {'total_count', 'ripples_count', 'sharpwaves_count', 'sharpwaveripples_count', 'complexsharpwaveripples_count'};
resultVars = {'total_count_vec', 'ripples_count_vec', 'sharpwaves_count_vec', 'sharpwaveripples_count_vec', 'complexsharpwaveripples_count_vec'};
rateVars = {'total_count_rate', 'ripples_count_rate', 'sharpwaves_count_rate', 'sharpwaveripples_count_rate', 'complexsharpwaveripples_count_rate'};

% Loop through each variable and perform the operations
for i = 1:length(varNames)
    % Extract the current variable
    var = eval(varNames{i});
    
    % Subset the variable
    var_subset = var{1:19, 3:12};
    
    % Calculate the rate
    var_rate = var_subset ./ rem_amount;
    
    % Replace with NaNs and store the result
    result = replace_with_nans(var_subset, var_rate);
    
    % Assign the result to the corresponding output variable
    assignin('base', resultVars{i}, result);
    % Assign the rate to the corresponding rate variable
    assignin('base', rateVars{i}, var_rate);
end


%% NREM counts

% Specify the path to the .xls file
filename = 'counts_nrem.xls';

[total_countNREM,ripples_countNREM,sharpwaves_countNREM,sharpwaveripples_countNREM,complexsharpwaveripples_countNREM]=extract_counts(filename);

varNames = {'total_countNREM', 'ripples_countNREM', 'sharpwaves_countNREM', 'sharpwaveripples_countNREM', 'complexsharpwaveripples_countNREM'};
resultVars = {'total_countNREM_vec', 'ripples_countNREM_vec', 'sharpwaves_countNREM_vec', 'sharpwaveripples_countNREM_vec', 'complexsharpwaveripples_countNREM_vec'};
rateVars = {'total_countNREM_rate', 'ripples_countNREM_rate', 'sharpwaves_countNREM_rate', 'sharpwaveripples_countNREM_rate', 'complexsharpwaveripples_countNREM_rate'};

% Loop through each variable and perform the operations
for i = 1:length(varNames)
    % Extract the current variable
    var = eval(varNames{i});
    
    % Subset the variable
    var_subset = var{1:19, 3:12};
    
    % Calculate the rate
    var_rate = var_subset ./ nrem_amount;
    
    % Replace with NaNs and store the result
    result = replace_with_nans(var_subset, var_rate);
    
    % Assign the result to the corresponding output variable
    assignin('base', resultVars{i}, result);
        % Assign the rate to the corresponding rate variable
    assignin('base', rateVars{i}, var_rate);
    
end

%%
rats_id= table2array( total_count(:,1));
rats_treatment= table2cell( total_count(:,2));
columnNames = total_count.Properties.VariableNames;
columnNames=columnNames(1:end-1);

% Get information about all variables in the workspace
vars = whos;

% Loop through the variables
for i = 1:length(vars)
    % Check if the variable is of type 'table'
    if strcmp(vars(i).class, 'table')
        % Delete the variable from the workspace
        evalin('base', ['clear ', vars(i).name]);
    end
end

%% TO SAVE:
% total_count_vec
% total_count_rate
% sharpwaves_count_vec
% sharpwaves_count_rate
% ripples_count_vec
% ripples_count_rate
% sharpwaveripples_count_vec
% sharpwaveripples_count_rate
% complexsharpwaveripples_count_vec
% complexsharpwaveripples_count_rate


% total_countNREM_vec
% total_countNREM_rate
% sharpwaves_countNREM_vec
% sharpwaves_countNREM_rate
% ripples_countNREM_vec
% ripples_countNREM_rate
% sharpwaveripples_countNREM_vec
% sharpwaveripples_countNREM_rate
% complexsharpwaveripples_countNREM_vec
% complexsharpwaveripples_countNREM_rate
xo
%%
% Create a cell array to store data and valid sheet names
data = {
    total_count_vec, 'total_count_vec';
    total_count_rate, 'total_count_rate';
    sharpwaves_count_vec, 'sharpwaves_count_vec';
    sharpwaves_count_rate, 'sharpwaves_count_rate';
    ripples_count_vec, 'ripples_count_vec';
    ripples_count_rate, 'ripples_count_rate';
    sharpwaveripples_count_vec, 'sharpwaveripples_count_vec';
    sharpwaveripples_count_rate, 'sharpwaveripples_count_rate';
    complexsharpwaveripples_count_vec, 'complexsharpwaveripples_count_vec';
    complexsharpwaveripples_count_rate, 'complexsharpwaveripples_count_rate';
    total_countNREM_vec, 'total_countNREM_vec';
    total_countNREM_rate, 'total_countNREM_rate';
    sharpwaves_countNREM_vec, 'sharpwaves_countNREM_vec';
    sharpwaves_countNREM_rate, 'sharpwaves_countNREM_rate';
    ripples_countNREM_vec, 'ripples_countNREM_vec';
    ripples_countNREM_rate, 'ripples_countNREM_rate';
    sharpwaveripples_countNREM_vec, 'sharpwaveripples_countNREM_vec';
    sharpwaveripples_countNREM_rate, 'sharpwaveripples_countNREM_rate';
    complexsharpwaveripples_countNREM_vec, 'complexsharpwaveripples_countNREM_vec';
    complexsharpwaveripples_countNREM_rate, 'complexsharpwaveripples_countNREM_rate'
};

% Define the Excel filename
excelFileName = 'data.xlsx';

% Loop through each pair of data and sheet name to write to Excel
for i = 1:size(data, 1)
    sheetData = data{i, 1};
    sheetName = data{i, 2};
 
    % Add rat IDs and rat treatment to the data
    extendedData = [num2cell(rats_id), rats_treatment, num2cell(sheetData)];
    % Combine column names and data
    extendedData = [columnNames; extendedData];   
    
    % Remove invalid characters from sheetName
    sheetName = regexprep(sheetName, '[^\w\s-]', ''); % Removes characters not allowed
    
    % Truncate if longer than 31 characters
    sheetName = sheetName(1:min(length(sheetName), 31));
    
 % Write to Excel
    writecell(extendedData, excelFileName, 'Sheet', sheetName);  
%     
%     % Determine data type and write to Excel
%     if isnumeric(sheetData)
%         writematrix(sheetData, excelFileName, 'Sheet', sheetName);
%     elseif iscell(sheetData)
%         writecell(sheetData, excelFileName, 'Sheet', sheetName);
%     else
%         disp(['Data type not supported for sheet: ' sheetName]);
%     end
end

disp(['Data saved to Excel file: ' excelFileName]);

%%
% bin_edges = linspace(0, 30,50);
% 
% % Plot the histograms using the same bin edges
% figure;
% histogram(total_count_rate(:), bin_edges, 'FaceAlpha', 0.6);
% hold on;
% histogram(total_countNREM_rate(:), bin_edges, 'FaceAlpha', 0.6);
% 
% % Add labels and title for clarity
% xlabel('Rate');
% ylabel('Frequency');
% title('Histogram of Total Count Rate and Total Count NREM Rate');
% legend('Total Count Rate', 'Total Count NREM Rate');
% hold off;

%%
total_count_rateHIST=total_count_rate(:,1:9);
total_countNREM_rateHIST=total_countNREM_rate(:,1:9);


bin_edges = linspace(0, 30, 60);

% Plot the histograms as probability density histograms
figure;
histogram(total_count_rateHIST(:), bin_edges, 'Normalization', 'probability', 'FaceAlpha', 0.6);
hold on;
histogram(total_countNREM_rateHIST(:), bin_edges, 'Normalization', 'probability', 'FaceAlpha', 0.6);

% Add labels and title for clarity
xlabel('Rate [Events/Minute]');
ylabel('Probability');
title('Histogram of event rates during REM-like and NREM-like states');
legend('Events during REM-like state', 'Events during NREM-like state');
hold off;

