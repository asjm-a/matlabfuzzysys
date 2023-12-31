% To remove the warning messages for using old syntax
warning('off', 'fuzzy:general:warnDeprecation_Newfis') 
warning('off', 'fuzzy:general:warnDeprecation_Addvar')
warning('off', 'fuzzy:general:warnDeprecation_Addmf')
warning('off', 'fuzzy:general:warnDeprecation_Evalfis')

% Clears the Command Window of clutter
clc


% A declaration of new FIS for Vehicle Speed
a = newfis('Vehicle Speed')

%Default options for FIS
%                                                       AND OR    Impl Agg  Defuzzification
%a = newfis('Vehicle Speed', 'mamdani', 'min', 'max', 'min', 'max', 'centroid');

%Different options for FIS
%                                                       AND OR    Impl Agg  Defuzzification
%a = newfis('Vehicle Speed', 'mamdani', 'prod', 'probor', 'prod', 'max', 'mom');


% Declaring a new variable - this is an INPUT(1)
a = addvar(a, 'input', 'Traffic Density', [0 100]);
% Populating the 1st input variable with membership functions
a = addmf(a, 'input', 1, 'Light Traffic', 'trapmf', [0 0 25 40]); 
a = addmf(a, 'input', 1, 'Moderate Traffic', 'trimf', [30 50 70]); 
a = addmf(a, 'input', 1, 'Heavy Traffic', 'trapmf', [60 80 100 100]);

% Declaring a new variable - this is another INPUT(2)
a = addvar(a, 'input', 'Road Condition', [0 100]); 
% Populating the 2nd input variable with membership functions
a = addmf(a, 'input', 2, 'Poor', 'trapmf', [0 0 25 40]); 
a = addmf(a, 'input', 2, 'Moderate', 'trimf', [30 50 70]); 
a = addmf(a, 'input', 2, 'Good', 'trapmf', [60 80 100 100]);

% Declaring a new variable - this is another INPUT(3)
a = addvar(a, 'input', 'Speed Limit', [0 100]); 
% Populating the 3rd input variable with membership functions
a = addmf(a, 'input', 3, 'Low', 'trapmf', [0 20 25 40]); 
a = addmf(a, 'input', 3, 'Medium', 'trimf', [30 50 70]); 
a = addmf(a, 'input', 3, 'High', 'trapmf', [60 80 100 100]);

% Declaring a new variable - this is another INPUT(4) for Weather
a = addvar(a, 'input', 'Weather', [0 100]); 
% Populating the 4th input variable with membership functions
a = addmf(a, 'input', 4, 'Clear', 'trapmf', [0 0 25 40]); 
a = addmf(a, 'input', 4, 'Cloudy', 'trimf', [30 50 70]); 
a = addmf(a, 'input', 4, 'Rainy', 'trapmf', [60 80 100 100]);

% Declaring a new variable - this is an OUTPUT(1)
a = addvar(a, 'output', 'Vehicle Speed', [0 100]);
% Populating the output variable with membership functions
a = addmf(a, 'output', 1, 'Slow', 'trapmf', [0 0 25 40]);
a = addmf(a, 'output', 1, 'Moderate', 'trapmf', [30 50 50 70]); 
a = addmf(a, 'output', 1, 'Fast', 'trapmf', [60 80 100 100]);

% Corrected Rule declarations
rule1 = [1 1 1 1 1 1 1];
rule2 = [1 2 2 1 2 1 1];
rule3 = [1 3 3 1 3 1 1];
rule4 = [2 2 3 1 2 1 1];
rule5 = [2 3 3 1 3 1 1];
rule6 = [3 1 3 1 1 1 1];
rule7 = [3 2 1 1 1 1 1];
rule8 = [1 3 3 1 3 1 1];
rule9 = [1 3 3 3 2 1 1];
rule10 = [1 3 3 2 3 1 1];
rule11 = [2 1 2 3 1 1 1];
rule12 = [3 1 2 3 1 1 1];
rule13 = [3 1 2 2 1 1 1];
rule14 = [2 1 2 2 1 1 1];
rule15 = [1 3 3 3 2 1 1];
rule16 = [3 1 3 3 2 1 1];
rule17 = [1 3 3 -1 3 1 2];
rule18 = [0 3 3 1 3 1 2];
rule19 = [0 3 2 3 2 1 1];
rule20 = [0 3 3 3 2 1 1];
rule21 = [0 3 3 1 3 1 1];
rule22 = [0 3 3 2 3 1 1];
rule23 = [0 3 1 3 1 1 1];
rule24 = [0 1 3 3 2 1 1];
rule25 = [3 1 3 3 1 1 2];
rule26 = [3 1 2 2 2 1 2];
rule27 = [3 3 2 2 2 1 2];

% A matrix to hold the corrected rule arrays
ruleList = [rule1; rule2; rule3; rule4; rule5; rule6;
    rule7; rule8; rule9; rule10; rule11; rule12; rule13; rule14;
    rule15; rule16; rule17; rule18; rule19; rule20; rule21;
    rule22; rule23; rule24; rule25; rule26; rule27];

% Add the rules to the fis
a = addRule(a, ruleList);

% Example input values
TrafficDensity = 81.75
RoadConditions = 66.59
SpeedLimit = 51.9
Weather = 54.27

% Evaluate the fuzzy system
Output = evalfis(a, [TrafficDensity, RoadConditions, SpeedLimit, Weather])

% Display the result
fprintf('Traffic Density: %.2f, Road Condition: %.2f, Speed Limit: %.2f, Weather: %.2f => Vehicle Speed: %.2f\n', TrafficDensity, RoadConditions, SpeedLimit, Weather, Output);




%% Creating a sample data set to test he code
%data = [TrafficDensity, RoadConditions, SpeedLimit, Weather, Speed];
%headers = {'Traffic Density', 'Road Condition', 'Speed Limit', 'Weather', 'Speed'};
%%writecell(headers, 'speed_data.xlsx', 'Sheet', 'Data', 'Range', 'A1');
%%writematrix(data, 'speed_data.xlsx', 'Sheet', 'Data', 'Range', 'A2', 'WriteMode', 'append');
%
%% Check if the file exists, write headers if not
%if exist('sample_data.xlsx', 'file') ~= 2
%    writecell(headers, 'sample_data.xlsx', 'Sheet', 'Data', 'Range', 'A1');
%end
%
%% Append data to the file
%writematrix(data, 'sample_data.xlsx', 'Sheet', 'Data', 'WriteMode', 'append');
%
%% Read the values from the Excel file
%testData = xlsread('sample_data.xlsx', 'Data');


% Create an Excel file and input data into it
data = [TrafficDensity, RoadConditions, SpeedLimit, Weather, Output];
headers = {'Traffic Density', 'Road Condition', 'Speed Limit', 'Weather', 'Output'};
%writecell(headers, 'speed_data.xlsx', 'Sheet', 'Data', 'Range', 'A1');
%writematrix(data, 'speed_data.xlsx', 'Sheet', 'Data', 'Range', 'A2', 'WriteMode', 'append');

% Check if the file exists, write headers if not
if exist('speed_data.xlsx', 'file') ~= 2
    writecell(headers, 'speed_data.xlsx', 'Sheet', 'Data', 'Range', 'A1');
end

% Append data to the file
writematrix(data, 'speed_data.xlsx', 'Sheet', 'Data', 'WriteMode', 'append');

% Read the values from the Excel file
testData = xlsread('speed_data.xlsx', 'Data');



% The ruleview allows you to see the rule-base
ruleview(a)

% The subplots to visualize the system
subplot(4, 1, 1), plotmf(a, 'input', 1);
subplot(4, 1, 2), plotmf(a, 'input', 2);
subplot(4, 1, 3), plotmf(a, 'input', 3);
subplot(4, 1, 4), plotmf(a, 'input', 4);
