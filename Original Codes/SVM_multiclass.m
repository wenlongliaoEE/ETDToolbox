D=csvread('Dataset_muticlass.csv');
Xtrain1=D(1:6000,1:48);
Ytrain1=D(1:6000,49);

Xvalid1=D(6001:9000,1:48);
Yvalid1=D(6001:9000,49);

Xtest1=D(9001:end,1:48);
Ytest1=D(9001:end,49);


t = templateSVM('KernelFunction','polynomial','PolynomialOrder',2);
%t = templateSVM('KernelFunction','linear');
Mdl =fitcecoc(Xvalid1,Yvalid1,'Learners',t);
[predict_label] =predict(Mdl,Xtest1);
accuracy=0;
for j=1:length(Ytest1)
    if Ytest1(j)==predict_label(j)
       accuracy=accuracy+1;
    end
end
accuracy=accuracy/length(Ytest1) 
