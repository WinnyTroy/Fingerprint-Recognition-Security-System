% Dzung Pham 
% 
% Read all glue and silicone artifacts into binary and perform sweat pore
% detection in BIO_PAD_GF_HOWTO.m

clear all
close all

data_dir_glue = '../data-raw/glue';
data_dir_silicone = '../data-raw/silicone/dpham1';
data_dir_authentic = '../data-raw/authentic';

images_glue = dir([data_dir_glue '/*.bmp']);
images_silicone = dir([data_dir_silicone '/*.bmp']);
images_authentic = dir([data_dir_authentic '/*bmp']);

% Number of all instances 
total = length(images_glue) + length(images_silicone) + length(images_authentic);

score_artifacts = [];       % Number of sweat pores for all artifacts 
score_authentic = [];       % Number of sweat pores for all authentic  
score_all = [];             % Number of sweat pores for all instances 

%% Read glue artifiact images 
for i = 1:12
   IMAGE_GLUE = imread(['../data-raw/glue/' images_glue(i).name]);
   PORE_NUMBER = BIO_PAD_FG_HOWTO(IMAGE_GLUE);
   score_artifacts = [score_artifacts PORE_NUMBER];
   score_all = [score_all PORE_NUMBER];
end

%% Read silicon artifact images
for i = 1:12
   IMAGE_SILICONE = imread(['../data-raw/silicone/dpham1/' images_silicone(i).name]);
   PORE_NUMBER = BIO_PAD_FG_HOWTO(IMAGE_SILICONE);
   score_artifacts = [score_artifacts PORE_NUMBER];
   score_all = [score_all PORE_NUMBER];
end

%% Read authentic fingerprint images
for i = 1:12
   IMAGE_AUTHENTIC = imread(['../data-raw/authentic/' images_authentic(i).name]);
   PORE_NUMBER = BIO_PAD_FG_HOWTO(IMAGE_AUTHENTIC);
   score_authentic = [score_authentic PORE_NUMBER];
   score_all = [score_all PORE_NUMBER];
end

%% Calculate APCER and NPCER scores using percentiles WITHOUT training
% 
% Assume that authentic fingerprints have number of pore in the range of 50 
% to 100 percentile and NPCER = 0
APCER_score = [];
NPCER_score = [];
for n = 50:100
    fault_negative = sum(score_artifacts >= prctile(score_all, n));
    fault_positive = sum(score_authentic <= prctile(score_all, n)); 
    APCER = fault_negative / length(score_artifacts);
    NPCER = fault_positive / length(score_authentic);
    APCER_score = [APCER_score APCER]; 
    NPCER_score = [NPCER_score NPCER];
end 

index = find(NPCER_score == min(NPCER_score));

APCER_min = [];
for i = 1 : length(index)
    APCER_min = [APCER_min APCER_score(i)];
end 
APCER = min(APCER_min);
NPCER = min(NPCER_score);
disp(['Without training: APCER = ' num2str(APCER) ' NPCER = ' num2str(NPCER)]);


%% Calculate APCER and NPCER scores using mean WITH training
%
% Train dataset -- random 1/2 of the authentic pool
% train_authentic = datasample(score_authentic, length(score_authentic)/2);
train_authentic = score_authentic(1:6);

% Test dataset -- the rest of the enrollment pool 
% test_authentic = setdiff(score_authentic, train_authentic); 
test_authentic = score_authentic(7:12);
test_artifacts = score_artifacts; 

% Calculate threshold using authentic reference. 
authentic_ref = [];        
for i = 1 : length(train_authentic)
   authentic_score = [];
   for j = 1 :length(train_authentic)
       authentic_score = [authentic_score ...
           abs(train_authentic(i) - train_authentic(j))]; 
   end
   authentic_ref = [authentic_ref authentic_score];
end

threshold = max(authentic_ref); 

% Calculate distance for authentic vs. authentic references.  
authentic_dist = [];   
score = 0; 
for i = 1 : length(test_authentic)
    authentic_score = [];
    for j = 1 : length(train_authentic)
        authentic_score = [authentic_score ...
            abs(test_authentic(i) - train_authentic(j))];
    end
    authentic_dist = [authentic_dist mean(authentic_score)];
end 

for i = 1 : length(authentic_dist)
   if authentic_dist(i) > threshold
      score = score + 1;  
   end
end

NPCER = score / length(test_artifacts); 

% Calculate distance for artifacts vs. authentic references. 
artifact_dist = [];
score = 0;
for i = 1 : length(test_artifacts)
    artifact_score = [];
    for j = 1 : length(train_authentic)
        artifact_score = [artifact_score ...
            abs(test_artifacts(i) - train_authentic(j))];
    end
    artifact_dist = [artifact_dist mean(artifact_score)];
end 

for i = 1 : length(artifact_dist)
   if artifact_dist(i) < threshold
        score = score + 1; 
   end
end

APCER = score / length(test_artifacts); 

disp(['With training: APCER = ' num2str(APCER) ' NPCER = ' num2str(NPCER)]);