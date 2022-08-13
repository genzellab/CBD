%% ||| Detection of Ripples and Sharp-Waves ||| %%

results_dir = uigetdir('..', 'Folder to save results');

% rat ids
rats = [2, 3, 4, 5, 9, 10, 11, 201, 203, 204, 205, 206, 207, 209, 210, 211, 212, 213, 214];

fn = 600;

[file,path] = uigetfile('*.mat', 'Select processed pyramidal data file');
processed_pyra = load(fullfile(path, file));
[file,path] = uigetfile('*.mat', 'Select processed below pyramidal data file');
processed_belo = load(fullfile(path, file));
ripple_thresholds = [4.6, 5.25, 5, 4.7, 4.5, 4.7, 5, 4.5, 5, 5, 5, 5, 5, 4.7, 5, 5, 5, 5.35, 5];
sharpwave_thresholds = [3.7, 3.45, 4.5, 4.4, 3.7, 5, 5, 3.95, 5, 5, 4.5, 4, 4.5, 4.4, 4, 4.6, 5.2, 4, 3.5];

sigs_len = length(processed_pyra.signals);
bins_num = 11;

for i = 1:length(rats)
    
    % Ripples detection
    lims = processed_pyra.signals_indexes(i,:);
    sig = processed_pyra.signals(i, lims(1):lims(2));
    yourtimevector = (1:length(sig))/fn;
    detection_threshold = mean(sig) + ripple_thresholds(i)*std(sig);
    [S, E, M] = findRipplesLisa(sig, yourtimevector, detection_threshold, (detection_threshold)*(1/2), 600 );
    r_spe = [S'*fn, M'*fn, E'*fn] + lims(1);
    r_num = length(M);
    
    % Sharp-waves detection
    lims = processed_belo.signals_indexes(i,:);
    sig = processed_belo.signals(i, lims(1):lims(2));
    detection_threshold = mean(sig) - sharpwave_thresholds(i)*std(sig);
    spw = double(sig <= detection_threshold);
    dspw = abs(diff(spw));
    sw_event_marks = find(dspw);
    sw_event_lims = [sw_event_marks(1:2:end); sw_event_marks(2:2:end)]';
    sw_num = length(sw_event_lims);
    peaks = zeros(sw_num,1);
    for j = 1:sw_num
        sw_lim = sw_event_lims(j,:);
        [~,I] = min(sig(sw_lim(1):sw_lim(2)));
        peaks(j) = sw_lim(1) + I -1;
    end
    sw_spe = [sw_event_lims(:,1) peaks sw_event_lims(:,2)] + lims(1);
    
    % Oscil Table creation
    sw_mark = ones(sw_num,1);
    r_mark = ones(r_num,1)+1;
    Type = cat(1,sw_mark,r_mark);
    Start = cat(1, sw_spe(:,1), r_spe(:,1));
    Peak = cat(1, sw_spe(:,2), r_spe(:,2));
    End = cat(1, sw_spe(:,3), r_spe(:,3));
    Six_Start = Peak - 1800;
    Six_Start = Start - Six_Start;
    Six_End = Peak + 1800;
    Six_End = 3601 - (Six_End - End);
    Sleep_State = processed_pyra.sleep_states(i,int64(Peak))';
    Bin = ceil(Peak /(sigs_len / bins_num));
    oscil_table = table(Type, Start, Peak, End, Six_Start, Six_End, Sleep_State, Bin);
    oscil_table = sortrows(oscil_table, 3);
    
    % Overlaps
    r = oscil_table(:, [1 2 4]);
    sw = oscil_table(:, [1 2 4]);
    for j = 1:height(oscil_table)
        if oscil_table.Type(j) == 1
            r(j, 2) = {-2};
            r(j, 3) = {-1};
        elseif oscil_table.Type(j) == 2
            sw(j, 2) = {-4};
            sw(j, 3) = {-3};
        end
    end
    ripple = r{:,[2 3]};
    sharpwave = sw{:,[2 3]};
    complexes = find_overlap(ripple, sharpwave);
    for k = 1:length(complexes)
        complex = complexes{k};
        if length(complex) == 1
            for j = 1:length(complex)
                oscil_table(complex(j), 1) = {3};
            end
            oscil_table(k, 1) = {4};
        elseif length(complex) > 1
            for j = 1:length(complex)
                oscil_table(complex(j), 1) = {5};
            end 
            oscil_table(k, 1) = {6};
        end 
    end
    
    % Grouped table
    singles = oscil_table(oscil_table.Type == 1 | oscil_table.Type == 2,:);
    singles.Properties.VariableNames(1) = {'Form'};
    singles.Form = num2cell(singles.Form);
    Type = repelem("singles",height(singles));
    singles = [table(Type') singles];
    singles.Properties.VariableNames(1) = {'Type'};
    Type = string(zeros(1,length(complexes)));
    Form = cell(1,length(complexes));
    Start = zeros(1,length(complexes));
    Peak = zeros(1,length(complexes));
    End = zeros(1,length(complexes));
    Six_Start = zeros(1,length(complexes));
    Six_End = zeros(1,length(complexes));
    for j = 1:length(complexes)
        complex = complexes{j};
        type = length(complex);
        if type == 1 || type > 1
            indexes = sort([j complex]);
            if type > 1; Type(j) = "complex"; else; Type(j) = "simple"; end
            Form{j} = oscil_table{indexes,1}';
            Start(j) = min(oscil_table{indexes,2});
            Peak(j) = oscil_table{j,3};
            End(j) = max(oscil_table{indexes,4});
            Six_Start(j) = oscil_table{j,5};
            Six_End(j) = oscil_table{j,6};
        end 
    end
    indexes = find(~strcmp("0", Type));
    Type = Type(indexes)';
    Form = Form(indexes)';
    Start = Start(indexes)';
    Peak = Peak(indexes)';
    End = End(indexes)';
    Six_Start = Six_Start(indexes)';
    Six_End = Six_End(indexes)';
    Sleep_State = processed_pyra.sleep_states(i,int64(Peak))';
    Bin = ceil(Peak /(sigs_len / bins_num));
    simples_complexes = table(Type, Form, Start, Peak, End, Six_Start, Six_End, Sleep_State, Bin);
    grouped_oscil_table = [singles; simples_complexes];
    grouped_oscil_table = sortrows(grouped_oscil_table, 4);
    
    result_file = [num2str(rats(i)) '.mat'];
    save(fullfile(results_dir, result_file), 'oscil_table', 'grouped_oscil_table');
end