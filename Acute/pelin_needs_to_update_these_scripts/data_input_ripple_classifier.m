%% 

%% Generate data input for ripple classifier

%% RatID2
clc
clear

load('GC_ratID2_cbd.mat')
x=GC_ripple_ratID2_cbd;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID2_cbd;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID2_cbd;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID2_cbd.mat with x
GC_ripple_ratID2_cbd=x;
GC_swr_ratID2_cbd=y;
GC_complex_swr_ratID2_cbd=z;

clearvars -except -regexp GC data_info
save GC_ratID2_cbd.mat


%% RatID3
clc
clear

load('GC_ratID3_veh.mat')
x=GC_ripple_ratID3_veh;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID3_veh;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID3_veh;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID3_veh.mat with x
GC_ripple_ratID3_veh=x;
GC_swr_ratID3_veh=y;
GC_complex_swr_ratID3_veh=z;

clearvars -except -regexp GC data_info
save GC_ratID3_veh.mat

%% RatID4
clc
clear

load('GC_ratID4_veh.mat')
x=GC_ripple_ratID4_veh;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID4_veh;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID4_veh;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID4_veh.mat with x
GC_ripple_ratID4_veh=x;
GC_swr_ratID4_veh=y;
GC_complex_swr_ratID4_veh=z;

clearvars -except -regexp GC data_info
save GC_ratID4_veh.mat


%% RatID5
clc
clear

load('GC_ratID5_cbd.mat')
x=GC_ripple_ratID5_cbd;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID5_cbd;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID5_cbd;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID5_cbd.mat with x
GC_ripple_ratID5_cbd=x;
GC_swr_ratID5_cbd=y;
GC_complex_swr_ratID5_cbd=z;

clearvars -except -regexp GC data_info
save GC_ratID5_cbd.mat

%% RatID9
clc
clear

load('GC_ratID9_veh.mat')
x=GC_ripple_ratID9_veh;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID9_veh;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID9_veh;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID9_veh.mat with x
GC_ripple_ratID9_veh=x;
GC_swr_ratID9_veh=y;
GC_complex_swr_ratID9_veh=z;

clearvars -except -regexp GC data_info
save GC_ratID9_veh.mat

%% RatID10
clc
clear

load('GC_ratID10_cbd.mat')
x=GC_ripple_ratID10_cbd;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID10_cbd;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID10_cbd;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID10_cbd.mat with x
GC_ripple_ratID10_cbd=x;
GC_swr_ratID10_cbd=y;
GC_complex_swr_ratID10_cbd=z;

clearvars -except -regexp GC data_info
save GC_ratID10_cbd.mat

%% RatID11
clc
clear

load('GC_ratID11_cbd.mat')
x=GC_ripple_ratID11_cbd;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID11_cbd;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID11_cbd;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID11_cbd.mat with x
GC_ripple_ratID11_cbd=x;
GC_swr_ratID11_cbd=y;
GC_complex_swr_ratID11_cbd=z;

clearvars -except -regexp GC data_info
save GC_ratID11_cbd.mat

%% RatID201
clc
clear

load('GC_ratID201_veh.mat')
x=GC_ripple_ratID201_veh;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID201_veh;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID201_veh;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID201_veh.mat with x
GC_ripple_ratID201_veh=x;
GC_swr_ratID201_veh=y;
GC_complex_swr_ratID201_veh=z;

clearvars -except -regexp GC data_info
save GC_ratID201_veh.mat


%% RatID203
clc
clear

load('GC_ratID203_veh.mat')
x=GC_ripple_ratID203_veh;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID203_veh;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID203_veh;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID203_veh.mat with x
GC_ripple_ratID203_veh=x;
GC_swr_ratID203_veh=y;
GC_complex_swr_ratID203_veh=z;

clearvars -except -regexp GC data_info
save GC_ratID203_veh.mat

%% RatID204
clc
clear

load('GC_ratID204_cbd.mat')
x=GC_ripple_ratID204_cbd;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID204_cbd;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID204_cbd;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID204_cbd.mat with x
GC_ripple_ratID204_cbd=x;
GC_swr_ratID204_cbd=y;
GC_complex_swr_ratID204_cbd=z;

clearvars -except -regexp GC data_info
save GC_ratID204_cbd.mat

%% RatID205
clc
clear

load('GC_ratID205_cbd.mat')
x=GC_ripple_ratID205_cbd;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID205_cbd;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID205_cbd;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID205_cbd.mat with x
GC_ripple_ratID205_cbd=x;
GC_swr_ratID205_cbd=y;
GC_complex_swr_ratID205_cbd=z;

clearvars -except -regexp GC data_info
save GC_ratID205_cbd.mat

%% RatID206
clc
clear

load('GC_ratID206_veh.mat')
x=GC_ripple_ratID206_veh;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID206_veh;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID206_veh;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID206_veh.mat with x
GC_ripple_ratID206_veh=x;
GC_swr_ratID206_veh=y;
GC_complex_swr_ratID206_veh=z;

clearvars -except -regexp GC data_info
save GC_ratID206_veh.mat

%% RatID207
clc
clear

load('GC_ratID207_cbd.mat')
x=GC_ripple_ratID207_cbd;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID207_cbd;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID207_cbd;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID207_cbd.mat with x
GC_ripple_ratID207_cbd=x;
GC_swr_ratID207_cbd=y;
GC_complex_swr_ratID207_cbd=z;

clearvars -except -regexp GC data_info
save GC_ratID207_cbd.mat

%% RatID209
clc
clear

load('GC_ratID209_cbd.mat')
x=GC_ripple_ratID209_cbd;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID209_cbd;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID209_cbd;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID209_cbd.mat with x
GC_ripple_ratID209_cbd=x;
GC_swr_ratID209_cbd=y;
GC_complex_swr_ratID209_cbd=z;

clearvars -except -regexp GC data_info
save GC_ratID209_cbd.mat

%% RatID210
clc
clear

load('GC_ratID210_veh.mat')
x=GC_ripple_ratID210_veh;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID210_veh;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID210_veh;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID210_veh.mat with x
GC_ripple_ratID210_veh=x;
GC_swr_ratID210_veh=y;
GC_complex_swr_ratID210_veh=z;

clearvars -except -regexp GC data_info
save GC_ratID210_veh.mat

%% RatID211
clc
clear

load('GC_ratID211_veh.mat')
x=GC_ripple_ratID211_veh;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID211_veh;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID211_veh;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID211_veh.mat with x
GC_ripple_ratID211_veh=x;
GC_swr_ratID211_veh=y;
GC_complex_swr_ratID211_veh=z;

clearvars -except -regexp GC data_info
save GC_ratID211_veh.mat

%% RatID212
clc
clear

load('GC_ratID212_cbd.mat')
x=GC_ripple_ratID212_cbd;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID212_cbd;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID212_cbd;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID212_cbd.mat with x
GC_ripple_ratID212_cbd=x;
GC_swr_ratID212_cbd=y;
GC_complex_swr_ratID212_cbd=z;

clearvars -except -regexp GC data_info
save GC_ratID212_cbd.mat

%% RatID213
clc
clear

load('GC_ratID213_veh.mat')
x=GC_ripple_ratID213_veh;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID213_veh;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID213_veh;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID213_veh.mat with x
GC_ripple_ratID213_veh=x;
GC_swr_ratID213_veh=y;
GC_complex_swr_ratID213_veh=z;

clearvars -except -regexp GC data_info
save GC_ratID213_veh.mat

%% RatID214
clc
clear

load('GC_ratID214_cbd.mat')
x=GC_ripple_ratID214_cbd;
Wave={};

for i=1:length(x.waveforms)
    i
    trace=x.waveforms{i}(2,:);
    start_end=table2array([x.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

x.ripple_trace=Wave';
x.PCA_features=PCA_features;

%y
y=GC_swr_ratID214_cbd;
Wave={};

for i=1:length(y.waveforms)
    i
    trace=y.waveforms{i}(2,:);
    start_end=table2array([y.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

y.ripple_trace=Wave';
y.PCA_features=PCA_features;

%z
z=GC_complex_swr_ratID214_cbd;
Wave={};

for i=1:length(z.waveforms)
    i
    trace=z.waveforms{i}(2,:);
    start_end=table2array([z.grouped_oscil_table(i,6:7)]);
    wave=trace(start_end(1):start_end(2));
    Wave=[Wave; {wave}];
end
Wave=Wave.';

[~,~,~,~,~,~,~,~,~,~,PCA_features]=delta_specs(Wave,0,0,600);
PCA_features=PCA_features(:,2:end);

z.ripple_trace=Wave';
z.PCA_features=PCA_features;

%Now overwrite GC_ratID214_cbd.mat with x
GC_ripple_ratID214_cbd=x;
GC_swr_ratID214_cbd=y;
GC_complex_swr_ratID214_cbd=z;

clearvars -except -regexp GC data_info
save GC_ratID214_cbd.mat


