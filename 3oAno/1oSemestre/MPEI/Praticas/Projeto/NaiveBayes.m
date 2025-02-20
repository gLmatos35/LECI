classdef NaiveBayes
    methods(Static)
        % Extrai tokens únicos de uma URL
        function unique_tokens = all_UniqueTokens(urls)
            urls_lower = lower(urls);
            tokens = regexp(urls_lower, '\w+', 'match');
            tokens_str = arrayfun(@(x) string(x{:}), tokens, 'UniformOutput', false);
            unique_tokens = unique([tokens_str{:}]);
        end
        
        % Divisão em conjuntos de treino e teste
        function [trainDataset, testDataset, train_classes, test_classes] = splitTrainTestData(urls, classes, percentTrain)
            test = randperm(length(urls));
            trainSize = round(percentTrain * length(urls));
            trainIndices = test(1:trainSize); 
            testIndices = test(trainSize+1:end);
            
            trainDataset = urls(trainIndices, :);
            train_classes = classes(trainIndices);
            testDataset = urls(testIndices, :);
            test_classes = classes(testIndices);
        end
        
        % Treinamento do modelo
        function [prob_safe, prob_unsafe, words, urlsX_train] = train(trainDataset, train_classes)
            words = NaiveBayes.all_UniqueTokens(trainDataset);
            
            % Construindo a matriz de treino
            urlsX_train = zeros(length(trainDataset), length(words));
            for i = 1:length(trainDataset)
                urlTokens = NaiveBayes.all_UniqueTokens(trainDataset{i});
                for j = 1:length(urlTokens)
                    indiceToken = find(strcmp(words(1,:),urlTokens{j}));
                    urlsX_train(i, indiceToken) = 1;
                end
            end
            
            safeCount = sum(train_classes == 'safe');
            unsafeCount = sum(train_classes == 'unsafe');
            totalTrain = length(train_classes);
            
            prob_safe = safeCount / totalTrain;
            prob_unsafe = unsafeCount / totalTrain;
        end
        

                function predictedClass = predict(model, words, url)
            % Função para prever a classe de um URL usando o modelo Naive Bayes
            % model: Estrutura contendo o modelo treinado
            % words: Lista de palavras únicas
            % url: URL para previsão

            % Tokenizar o URL
            urlTokens = NaiveBayesModel.all_UniqueTokens(url);

            % Inicializar probabilidades logarítmicas
            logProbSafe = log(model.prob_safe);
            logProbUnsafe = log(model.prob_unsafe);

            for i = 1:length(urlTokens)
                token = urlTokens{i};
                indiceToken = find(strcmp(words, token));

                if isempty(indiceToken)
                    continue; % Ignorar tokens que não estão na lista de palavras únicas
                end

                % Calcular frequência condicional com suavização de Laplace
                ocorrTokenSafe = sum(model.urlsX_train(model.class_train == 'safe', indiceToken));
                ocorrTokenUnsafe = sum(model.urlsX_train(model.class_train == 'unsafe', indiceToken));

                probTokenSafe = (ocorrTokenSafe + 1) / (model.safeCount + model.numWords);
                probTokenUnsafe = (ocorrTokenUnsafe + 1) / (model.unsafeCount + model.numWords);

                % Atualizar probabilidades logarítmicas
                logProbSafe = logProbSafe + log(probTokenSafe);
                logProbUnsafe = logProbUnsafe + log(probTokenUnsafe);
            end

            % Decisão baseada nas probabilidades logarítmicas
            if logProbSafe > logProbUnsafe
                predictedClass = 'safe';
            else
                predictedClass = 'unsafe';
            end
        end
    end
end


