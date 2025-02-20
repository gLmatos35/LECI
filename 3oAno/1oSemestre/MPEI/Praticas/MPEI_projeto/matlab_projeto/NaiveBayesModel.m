classdef NaiveBayesModel
    methods (Static)
        function [model, words] = train(urls_train, class_train)
            words = NaiveBayesModel.all_UniqueTokens(urls_train);
            % matriz binaria
            urlsX_train = zeros(length(urls_train), length(words));
            for i = 1:length(urls_train)
                urlTokens = NaiveBayesModel.all_UniqueTokens(urls_train{i});
                for j = 1:length(urlTokens)
                    indiceToken = find(strcmp(words, urlTokens{j}));
                    urlsX_train(i, indiceToken) = 1;
                end
            end

            % probabilidades a priori
            safeCount = sum(class_train == 'safe');
            unsafeCount = sum(class_train == 'unsafe');
            totalTrain = length(class_train);

            model.prob_safe = safeCount / totalTrain;
            model.prob_unsafe = unsafeCount / totalTrain;

            % Armazenar 
            model.urlsX_train = urlsX_train;
            model.class_train = class_train;
            model.safeCount = safeCount;
            model.unsafeCount = unsafeCount;
            model.numWords = length(words);
        end

        function predictedClass = predict(model, words, url)
            urlTokens = NaiveBayesModel.all_UniqueTokens(url);

            % probabilidades logarítmicas (slides)
            logProbSafe = log(model.prob_safe);
            logProbUnsafe = log(model.prob_unsafe);

            for i = 1:length(urlTokens)
                token = urlTokens{i};
                indiceToken = find(strcmp(words, token));

                if isempty(indiceToken)
                    continue; % ignorar se não estiverem na lista de words
                end

                % frequência condicional com suavização de Laplace
                ocorrTokenSafe = sum(model.urlsX_train(model.class_train == 'safe', indiceToken));
                ocorrTokenUnsafe = sum(model.urlsX_train(model.class_train == 'unsafe', indiceToken));

                probTokenSafe = (ocorrTokenSafe + 1) / (model.safeCount + model.numWords);
                probTokenUnsafe = (ocorrTokenUnsafe + 1) / (model.unsafeCount + model.numWords);

                logProbSafe = logProbSafe + log(probTokenSafe);
                logProbUnsafe = logProbUnsafe + log(probTokenUnsafe);
            end

            if logProbSafe > logProbUnsafe
                predictedClass = 'safe';
            else
                predictedClass = 'unsafe';
            end
        end

        function unique_tokens = all_UniqueTokens(urls)
            urls_lower = lower(urls);
            tokens = regexp(urls_lower, '\w+', 'match');
            tokens_str = arrayfun(@(x) string(x{:}), tokens, 'UniformOutput', false);
            unique_tokens = unique([tokens_str{:}]);
        end
    end
end
