% Dzung Pham
% 
% File: TestingSet.m
% Input: threshold score acquired from TraingSet.m
% Output: APCER and NPCER for the test set
% 
function TestingSet(threshold)

%% Testing data
% Real irides
RealIrisLeft_dir = dir(['../data-raw/authentic/dpham1_Ia_L*.bmp']);
RealTextLeft_dir = dir(['../data-raw/authentic/dpham1_Ia_L*_segm.txt']);

RealIrisRight_dir = dir(['../data-raw/authentic/dpham1_Ia_R*.bmp']);
RealTextRight_dir = dir(['../data-raw/authentic/dpham1_Ia_R*_segm.txt']);

% Fake irides
FakeIrisLeft_dir = dir(['../data-raw/acquired-during-class/dpham1_L*.bmp']);
FakeTextLeft_dir = dir(['../data-raw/acquired-during-class/dpham1_L*_segm.txt']);

FakeIrisRight_dir = dir(['../data-raw/acquired-during-class/dpham1_R*.bmp']);
FakeTextRight_dir = dir(['../data-raw/acquired-during-class/dpham1_R*_segm.txt']);

% Liveness score containers
lscoreFake = [];    % for fake irides
lscoreReal = [];    % for real irides

%% Load real iris data

for i = 1 : length(RealIrisLeft_dir)
    image = imread(['../data-raw/authentic/' RealIrisLeft_dir(i).name]);
    seg = load(['../data-raw/authentic/' RealTextLeft_dir(i).name]);
    [n, d] = IrisDetection(image, seg, 10, 40, 20); 
    lscoreReal = [lscoreReal n/d]; 
end

for i = 1 : length(RealIrisRight_dir)
    image = imread(['../data-raw/authentic/' RealIrisRight_dir(i).name]);
    seg = load(['../data-raw/authentic/' RealTextRight_dir(i).name]);
    [n, d] = IrisDetection(image, seg, 10, 40, 20); 
    lscoreReal = [lscoreReal n/d]; 
end

%% Load fake iris data

for i = 1 : length(FakeIrisRight_dir)
    image = imread(['../data-raw/acquired-during-class/' FakeIrisRight_dir(i).name]);
    seg = load(['../data-raw/acquired-during-class/' FakeTextLeft_dir(i).name]);
    [n, d] = IrisDetection(image, seg, 10, 40, 15); 
    lscoreFake = [lscoreFake n/d]; 
end

for i = 1 : length(FakeIrisLeft_dir)
    image = imread(['../data-raw/acquired-during-class/' FakeIrisLeft_dir(i).name]);
    seg = load(['../data-raw/acquired-during-class/' FakeTextRight_dir(i).name]);
    [n, d] = IrisDetection(image, seg, 10, 40, 15); 
    lscoreFake = [lscoreFake n/d]; 
end

%% Calculate APCER and NPCER

wrongAuthentic = 0;
for i = 1:length(lscoreFake)
   if lscoreFake(i) < threshold
        wrongAuthentic = wrongAuthentic + 1;
   end
end
APCER = wrongAuthentic / length(lscoreFake)

% NPCER (incorrectly classified as attack)
wrongAttack = 0; 
for i = 1:length(lscoreReal)
   if lscoreReal(i) > threshold
       wrongAttack = wrongAttack + 1; 
   end
end
NPCER = wrongAttack / length(lscoreReal)
