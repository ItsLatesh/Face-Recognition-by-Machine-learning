%% Test Network:

function correctedClassified = testNetwork(testSamples, testTargets, trainedW1, trainedW2, numberOfTestData) 
 
 Cont = 0;
 
 for i = 1 : numberOfTestData
     
     OSample = testSamples(:,i); % Test Samples
     OTarget = testTargets(:,i); % Test Targets
     NET1 = OSample'*trainedW1;
     NET1 = NET1';
     OUT1 = 1./(1+exp(-NET1)); % OutPut For Hidden Layer
     X2 = [1;OUT1];  % Add Bias
     NET2 = X2'*trainedW2;
     NET2 = NET2';
     OUT2 = 1./(1+exp(-NET2)); % OutPut Of Network
     
     % Compare OutPut To Target
     [V, Index] = max(OUT2);
     
     if(OTarget(Index) == 1)
         Cont = Cont + 1;
     end
    
 end
 correctedClassified = Cont;

end