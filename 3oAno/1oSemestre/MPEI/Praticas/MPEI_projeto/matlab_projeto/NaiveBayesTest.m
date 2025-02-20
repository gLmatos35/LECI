clear;

dataset = readcell('dataset_no_ips.csv');

class = categorical(dataset(2:end, end));
urls = dataset(2:end, 1:end-1);  

test = randperm(length(urls));
% percentTrain = 0.9935;  % deixa ~100 urls aleatórios para teste
percentTrain = 0.8;
trainSize = round(percentTrain * length(urls));
trainIndices = test(1:trainSize);
testIndices = test(trainSize+1:end);

urls_train = urls(trainIndices, :);
urls_test = urls(testIndices, :);
class_train = class(trainIndices);
class_test = class(testIndices);

[model, words] = NaiveBayesModel.train(urls_train, class_train);

truePositive = 0; % predicted SAFE e é SAFE
falsePositive = 0; % predicted SAFE mas é UNSAFE
trueNegative = 0; % predicted UNSAFE e é UNSAFE
falseNegative = 0; % predicted UNSAFE mas é SAFE

for i = 1:length(urls_test)
    predictedClass = NaiveBayesModel.predict(model, words, urls_test{i});
    trueClass = class_test(i);

    if predictedClass == "safe" && trueClass == "safe"
        truePositive = truePositive + 1;
    elseif predictedClass == "safe" && trueClass == "unsafe"
        falsePositive = falsePositive + 1;
    elseif predictedClass == "unsafe" && trueClass == "unsafe"
        trueNegative = trueNegative + 1;
    elseif predictedClass == "unsafe" &&  trueClass == "safe"
        falseNegative = falseNegative + 1;
    end

    % fprintf("URL %d: True Class = %s,\tPredicted Class = %s\n", i, trueClass, predictedClass);
end

disp("---------------------------------")
fprintf("Verdadeiros Positivos: %d\n",truePositive);
fprintf("Falsos Positivos: %d\n",falsePositive);
fprintf("Verdadeiros Negativos: %d\n",trueNegative);
fprintf("Falsos Negativos: %d\n",falseNegative);

precision = truePositive / (truePositive + falsePositive);
recall = truePositive / (truePositive + falseNegative);
f1Score = 2 * (precision * recall) / (precision + recall);
accuracy = (truePositive + trueNegative) / (truePositive + falsePositive + trueNegative + falseNegative);


fprintf("\nMetrics:\n");
fprintf("Precision: %.2f\n", precision);
fprintf("Recall: %.2f\n", recall);
fprintf("F1-Score: %.2f\n", f1Score);
fprintf("Accuracy: %.2f\n", accuracy);
fprintf('______________________________________________________________________________\n')