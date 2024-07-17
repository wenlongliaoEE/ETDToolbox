D=csvread('Dataset_binaryclass.csv');
%D=csvread('Dataset_muticlass.csv');
[m,n]=size(D);
D=[D(:,1:48),zeros(m,1),D(:,49)];
Xtrain1=D(1:6000,1:49);
Ytrain1=D(1:6000,50);

Xvalid1=D(6001:9000,1:49);
Yvalid1=D(6001:9000,50);

Xtest1=D(9001:end,1:49);
Ytest1=D(9001:end,50);

numclass=max(Ytrain1)+1;
Ytrain1=categorical(Ytrain1);Yvalid1=categorical(Yvalid1);Ytest1=categorical(Ytest1);
Xtrain1=reshape(Xtrain1',7,7,1,6000);
Xvalid1=reshape(Xvalid1',7,7,1,3000);
Xtest1=reshape(Xtest1',7,7,1,3000);
imageSize=[7 7 1];
layers = [ ...
    imageInputLayer(imageSize)

    convolution2dLayer(2,32,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    maxPooling2dLayer(2,'Stride',2)

    convolution2dLayer(2,64,'Padding','same')
    batchNormalizationLayer
    reluLayer   
    maxPooling2dLayer(2,'Stride',2)

    convolution2dLayer(2,128,'Padding','same')
    batchNormalizationLayer
    reluLayer  
    fullyConnectedLayer(numclass)
    softmaxLayer
    classificationLayer];
options = trainingOptions('sgdm', ...
    'MaxEpochs',2,...
    'MiniBatchSize',32, ...
    'InitialLearnRate',0.0001, ...
    'Verbose',false, ...
    'Plots','training-progress', ...
    'ValidationData',{Xvalid1,Yvalid1});
net = trainNetwork(Xtrain1,Ytrain1,layers,options);
YPred = classify(net,Xtest1,'MiniBatchSize',32);
accuracy = sum(YPred == Ytest1)/numel(Ytest1)






