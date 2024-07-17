D=csvread('Dataset_muticlass.csv');
%D=csvread('Dataset_binaryclass.csv');
Xtrain1=D(1:6000,1:48);
Ytrain1=D(1:6000,49);

Xvalid1=D(6001:9000,1:48);
Yvalid1=D(6001:9000,49);

Xtest1=D(9001:end,1:48);
Ytest1=D(9001:end,49);

numClasses =max(Ytrain1)+1;

Ytrain1=categorical(Ytrain1);Yvalid1=categorical(Yvalid1);Ytest1=categorical(Ytest1);

Xtrain1=reshape(Xtrain1',[1,1,size(Xtrain1,2),size(Xtrain1,1)]);
Xvalid1=reshape(Xvalid1',[1,1,size(Xvalid1,2),size(Xvalid1,1)]);
Xtest1=reshape(Xtest1',[1,1,size(Xtest1,2),size(Xtest1,1)]);

layers = [ ... 
imageInputLayer([1 1 48]); 
fullyConnectedLayer(200)
batchNormalizationLayer
reluLayer
fullyConnectedLayer(200)
batchNormalizationLayer
reluLayer
fullyConnectedLayer(200)
batchNormalizationLayer
reluLayer
fullyConnectedLayer(numClasses)
softmaxLayer
classificationLayer]; 

options = trainingOptions('rmsprop', ...
    'MaxEpochs',15,...
    'MiniBatchSize',32, ...
    'InitialLearnRate',0.0001, ...
    'Verbose',false, ...
    'Plots','training-progress', ...
    'ValidationData',{Xvalid1,Yvalid1});
net = trainNetwork(Xtrain1,Ytrain1,layers,options);

YPred = classify(net,Xtest1,'MiniBatchSize',32);

accuracy = sum(YPred == Ytest1)/numel(Ytest1)



