%D=csvread('Dataset_binaryclass.csv');
D=xlsread('Dataset_binaryclass.xlsx');
Xtrain1=D(1:6000,1:48);
Ytrain1=D(1:6000,49);

Xvalid1=D(6001:9000,1:48);
Yvalid1=D(6001:9000,49);

Xtest1=D(9001:end,1:48);
Ytest1=D(9001:end,49);


numClasses =max(Ytrain1)+1;

Ytrain1=categorical(Ytrain1);Yvalid1=categorical(Yvalid1);Ytest1=categorical(Ytest1);
Xtrain1=num2cell(Xtrain1,2);
Xvalid1=num2cell(Xvalid1,2);
Xtest1=num2cell(Xtest1,2);

for j=1:6000
    temp=Xtrain1{j};
    Xtrain1{j}=temp';
end
for j=1:3000
    temp1=Xvalid1{j};temp2=Xtest1{j};
    Xvalid1{j}=temp1';Xtest1{j}=temp2';
end

inputSize = 48;
numHiddenUnits = 200;
layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    lstmLayer(numHiddenUnits,'OutputMode','last')
    lstmLayer(numHiddenUnits,'OutputMode','last')

    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

maxEpochs =20;
miniBatchSize = 32;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'GradientThreshold',1, ...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(Xtrain1,Ytrain1,layers,options);

YPred= classify(net,Xtrain1,'MiniBatchSize',32);
accuracy=sum(YPred ==Ytrain1)/numel(Ytrain1)

YPred= classify(net,Xvalid1,'MiniBatchSize',32);
accuracy=sum(YPred ==Yvalid1)/numel(Yvalid1)

YPred= classify(net,Xtest1,'MiniBatchSize',32);
accuracy=sum(YPred == Ytest1)/numel(Ytest1)
