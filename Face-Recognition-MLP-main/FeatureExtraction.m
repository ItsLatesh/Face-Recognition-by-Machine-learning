function [FeatureVec] = FeatureExtraction(Image,r,c,NF)
%% Function For Get fft As Feature

FFTIMAGE = zeros(r,c);      % Define Variable For fft Of Image
FeatureVec = zeros(1,NF);   % Define A Vector For Features

FFTIMAGE = fft2(Image);     % fft Of Image
A = abs(FFTIMAGE);          % Absolute Of fft
A(1,1)= 0;                  % Make First Value Of fft Equal To Zero
B = (A - min(min(A))) / (max(max(A))-min(min(A))); % Normalization Of Values
B(1,1) = 1;                 % Bias Value
C = reshape(B,(r*c),1);     % Convert Matrix fft To Vector
FeatureVec = C(1:NF);       % Get NF Value Of fft For Features

end