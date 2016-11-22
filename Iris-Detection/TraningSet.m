% Dzung Pham
% 
% File: TrainingSet.m
% Output: threshold for TestingSet.m
% 
function threshold = TrainingSet()

%% Training data

% Directory for the images. Each image is of length 640 
iris_fake_dir = dir(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/fake*.png']);
iris_real_dir = dir(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/real*.png']);
text_fake_dir = dir(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/fake*.txt']);
text_real_dir = dir(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/real*.txt']);

lscoreFake = [];    % liveness scores for fake irides
lscoreReal = [];    % liveness scores for real irides

% Load fake iris data
for i = 1 : length(iris_fake_dir)
    image = imread(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/' iris_fake_dir(i).name]);
    seg = load(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/' text_fake_dir(i).name]);
    [n, d] = IrisDetection(image, seg, 10, 40, 15); 
    lscoreFake = [lscoreFake n/d]; 
end


% Load real iris data
for i = 1 : length(iris_real_dir)
    image = imread(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/' iris_real_dir(i).name]);
    seg = load(['../data-raw/LivDet-Iris-2013-Warsaw-Subset/' text_real_dir(i).name]);
    [n, d] = IrisDetection(image, seg, 6, 35, 20); 
    lscoreReal = [lscoreReal n/d]; 
end

%% Calculate APCER and NPCER 
threshold = max(lscoreReal); 

% APCER (incorrectly classified as authentic)
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