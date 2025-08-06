clear;
% Loading Model
load('trainedModel.mat')

% Testing model with diabetes-training
predictions = trainedModel.predictFcn(diabetestraining);
true_labels=diabetestraining(:,7);
array=table2array(true_labels);
counter=0;
for i=1:600
    if predictions(i)==array(i)
        counter=counter+1;
    end
end
accu_train=(counter/600)*100;

disp(accu_train);

% Testing model with diabetes-validation
predictions = trainedModel.predictFcn(diabetesvalidation);
true_labels=diabetesvalidation(:,7);
array=table2array(true_labels);
counter=0;
for i=1:100
    if predictions(i)==array(i)
        counter=counter+1;
    end
end
accu_train=(counter/100)*100;

disp(accu_train);