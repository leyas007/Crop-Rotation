clc
clear all
close all

%Read the Input data
[data1,txt]=xlsread('Data.csv');

%Split attribute and target
data=data1(:,2:7);
target=data1(:,8);

x=target';
A=data';

%%CLASSIFIER
%Classifier Parameters
net1=newcf(minmax(A),[10,5,1],{'tansig','tansig','purelin','trainrp'});
net1.trainParam.show=1000;
net1.trainParam.lr=0.04;
net1.trainParam.epoches=500;
net1.trainParam.goals=1e-5;

%Train ANN
[netan]=train(net1,A,x);
save netan1 netan
clc;

[data2,txt]=xlsread('feed.csv');

%Split attribute and target
 tesdata=data2(:,2:7);


%Crop Prediction 
load netan1
y=round(abs(sim(netan,tesdata')));
disp('---------------------------');
disp('**** OUTPUT *****');
disp('---------------------------');
res=y(1);

if res==1
    cr='Cotton';
elseif res==2
    cr='Sugarcane';
elseif res==3
    cr='Bajra';
elseif res==4
    cr='Corn';
elseif res==5
    cr='Rice';
elseif res==6
    cr='Millets';
end

%Display Results
sprintf('Recommended Crop is %s',cr)
msgbox(cr,'Crop')