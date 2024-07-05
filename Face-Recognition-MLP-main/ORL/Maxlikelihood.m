
%% NN_HW_03_Face_Detection_With_MLP
%%% Saeid_Moradi

clc
clear all
close all

%% Read Image And Compute Means Of Block Images

NI = 360; % Number Of Images (10 Image in 40 Class)
NF = 2; % Number Of Features
NO = 40; % Number Of Output

Sample1 = zeros(NF,NI); % Variable For Inputs
Target1 = zeros(40,NI); % Variable For Target

n = 1;
for a = 1 : 40
    for b = 1 : 9
        Adress = ['s',num2str(a),'\',num2str(b),'.pgm'];
        if(exist(Adress,'file')) ~= 0
            I = imread(Adress);
            [r,c] = size(I);
            FeatureVec = FeatureExtraction(I,r,c,NF); % Get Features From FeatureExtraction Function*
            Sample1(:,n) = FeatureVec; % Make Sample Matrix Consist of Features In Evry Column* 
            Target1(a,n) = 1; % Make Target Matrix That Evry Column Has One True Value*
            n = n+1;
        end
    end
end

%[Sample,Target] = Randomize(Sample1,Target1); % Randomize Sample Value For Good Training

%% Test Section
test_image = imread('s40\3.pgm');
[r,c] = size(test_image);

utest_image = mean(mean(test_image));
sigma_test_image = sqrt(sum(sum(((test_image-utest_image).^2)))/(r*c));

OUT2 = zeros(2,360);

for i=1:360
    OUT2(1,i) = abs(utest_image-Sample1(1,i));
    OUT2(2,i) = abs(sigma_test_image-Sample1(2,i));
    
end
[V, Index] = min(sum(OUT2));
[a,index] = max(Target1(:,Index));
imshow(test_image);title(num2str(index),'color','r');