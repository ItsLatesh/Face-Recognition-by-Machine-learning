
%%% Face Recognition usin MultiLayer Perceptron
%

%% Read Images from Dataset and build features vectors...

numberOfImages = 400; % Number Of Images (10 Image in 40 Class)
numberOfFeatures = 200; % Number Of Features
numberOfClasses = 40; % Number Of Output

Samples = zeros(numberOfFeatures,numberOfImages); % Samples Data
Targets = zeros(40,numberOfImages); % Samples Target

EW = zeros(numberOfImages,1);

numberOfTrainingData = round(.5*numberOfImages); % Number Of Training Data
numberOfTestData = numberOfImages - numberOfTrainingData; % Number Of Test Data

n = 1;
for a = 1 : 40
    for b = 1 : 10
        Adress = ['ORL\s',num2str(a),'\',num2str(b),'.pgm'];
        if(exist(Adress,'file')) ~= 0
            I = imread(Adress);
            [r,c] = size(I);
            FeatureVec = FeatureExtraction(I,r,c,numberOfFeatures); % Feature vector for every image
            Samples(:,n) = FeatureVec; % Samples Matrix Consist of Features In Evry Column 
            Targets(a,n) = 1; % Targets Matrix That Evry Column Has One True Value related to the class of image
            n = n+1;
        end
    end
end

[randomizedSamples,randomizedTargets] = Randomize(Samples,Targets); % Randomize Sample Value For Good Training

trainingSamples = randomizedSamples(:, 1:numberOfTrainingData); % Data For Train = %50 Samples*
trainingTargets = randomizedTargets(:, 1:numberOfTrainingData); % Target For Train Data*
testSamples = randomizedSamples(:, numberOfTrainingData+1:numberOfImages); % Data For Test = %50 Samples*
testTargets = randomizedTargets(:, numberOfTrainingData+1:numberOfImages); % Target For Test Data*

%% Training Section
alpha = 0.018; % Learning Rate
NH = 200; 	 % Number Of Neurons For Hidden Layer
Epoch = 100;  % Number of Epochs

W1 = (rand(numberOfFeatures,NH)-.5)*.5; % Weights Between Inputs And Hidden Layer
W2 = (rand(NH+1,numberOfClasses)-.5)*.5; % Weights Between Hidden Layer And OutPut Layer

% Train Netwrok:
[trainedW1, trainedW2, ERROR] = trainNetwork(trainingSamples, trainingTargets, W1, W2, Epoch, numberOfTrainingData, numberOfImages, alpha); 
%% Test Section
correctedClassified = testNetwork(testSamples, testTargets, trainedW1, trainedW2, numberOfTestData);

networkAccuracy = (correctedClassified/(numberOfTestData))*100 % Success Percent
plot(ERROR);title('rms ERROR')