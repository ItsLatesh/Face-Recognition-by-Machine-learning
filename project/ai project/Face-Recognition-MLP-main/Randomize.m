function [Sample,Target] = Randomize(Sample1,Target1)
%% Function For Randomize Inputs And Targets

[r1,c1] = size(Sample1); % Get Row And Colum Of Sample Matrix
[r2,c2] = size(Target1); % Get Row And Colum Of Target Matrix

Sample = zeros(r1,c1); % Define Variable For Randomized Sample
Target = zeros(r2,c2); % Define Variable For Randomized Target

Var = randperm(c1);  % Make Random Values Beetwin 0 To c1
for i = 1:c1
    
    Randcol = Var(i);
    Sample(:,Randcol) = Sample1(:,i); % Randomize Samples
    Target(:,Randcol) = Target1(:,i); % Randomize Targets

end

end