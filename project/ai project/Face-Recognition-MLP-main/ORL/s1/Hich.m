
I = imread('1.pgm');
imshow(I);
FFT = fft2(I);
A = abs((FFT));
A(1,1) = 0;
B = (A - min(min(A))) / (max(max(A))-min(min(A)));
B (1,1) = 1;
C = reshape(B,(112*92),1);
D = sort(C,'descend');