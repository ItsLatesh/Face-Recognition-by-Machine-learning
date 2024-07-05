
function [trainedW1, trainedW2, err] = trainNetwork(trainingSamples, trainingTargets, W1, W2, Epoch, numberOfTrainingData, numberOfImages, learningRate)

ERROR = zeros(Epoch,1);

 for epoch = 1:Epoch
     for r = 1:numberOfTrainingData
        
         iSample = trainingSamples(:,r); % Features For rth Image
         iTarget = trainingTargets(:,r); % Target For rth Image
         NET1 = iSample'*W1;         % NET Of Hidden Layer
         NET1 = NET1';
         Out1 = 1./(1+exp(-NET1));   % OutPut Of Hidden Layer
         X2 = [1;Out1];              % Input Of OutPut Layer
         Net2 = X2'*W2;              % NET Of OutPut Layer
         Out2 = 1./(1+exp(-Net2));   % Out Of OutPut Layer
              
         % Adjust delta values of weights For output layer:
         Z = Out2*(1-Out2')*(iTarget - Out2');
            
         % Propagate the delta backwards into hidden layers:
         Delta12 = W2 * Z;
         Delta2 = X2 .*(1-X2).*Delta12; 
         Delta3 = Delta2(2:end);
               
         % weight Correction:
         W2 = W2 + learningRate*X2*Z'; % Wkj Correction 
         W1 = W1 + learningRate*iSample*Delta3'; % Wji Correction
         
         % Network Error
         EW(r) = ((sum((iTarget' - Out2).^2))/2);
     end
    
     ERROR(epoch) = sum(EW)/numberOfImages;
 end
 trainedW1 = W1;
 trainedW2 = W2;
 err = ERROR;
end