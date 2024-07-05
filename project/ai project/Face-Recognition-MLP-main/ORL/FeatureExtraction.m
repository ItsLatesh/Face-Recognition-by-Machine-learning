function [FeatureVec] = FeatureExtraction(Image,r,c,NF)
%% Function For Get fft As Feature
FeatureVec = zeros(1,NF);   % Define A Vector For Features
u=0;
sigma=0;
u = mean(mean(Image));
sigma = sqrt((sum(sum((Image-u).^2)))/(r*c));
FeatureVec(1,1:2) = [u sigma];       % Get NF Value Of fft For Features

end