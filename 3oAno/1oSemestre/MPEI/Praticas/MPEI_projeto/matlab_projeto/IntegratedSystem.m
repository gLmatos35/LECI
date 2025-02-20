classdef IntegratedSystem
    properties
        BloomFilter     % objeto
        NaiveBayesModel % modelo
        Words   % palavras únicas
        MinHashMatrix
        URLs
        Classes % safe/unsafe
        K   % nº MinHashes
        A   % parâmetros para hash
        B   % parâmetros para hash
        P   % nºs primos para hash
        ShingleSize
    end

    methods
        % Inicializar o sistema integrado
        function obj = IntegratedSystem(bloomFilterSize, bloomHashCount, datasetFile, k, shingleSize)
            % Configurar o BloomFilter
            obj.BloomFilter = BloomFilter(bloomFilterSize, bloomHashCount);
            
            % Ler dataset
            dataset = readcell(datasetFile);
            obj.URLs = dataset(2:end, 1); % URLs
            obj.Classes = categorical(dataset(2:end, end)); % Classes
            
            % Inserir URLs unsafe no BloomFilter
            unsafeUrls = obj.URLs(obj.Classes == 'unsafe');
            for i = 1:length(unsafeUrls)
                obj.BloomFilter = obj.BloomFilter.insert(unsafeUrls{i});
            end
            
            % Treinar o NaiveBayes
            [obj.NaiveBayesModel, obj.Words] = NaiveBayesModel.train(obj.URLs, obj.Classes);
            
            % Configurar MinHash
            obj.K = k;
            obj.ShingleSize = shingleSize;
            rng(12345); % Semente fixa
            obj.A = randi(10000, k, 1);
            obj.B = randi(10000, k, 1);
            primeNumbers = primes(10000);
            obj.P = primeNumbers(randi(length(primeNumbers), k, 1));
            
            % Calcular matriz de MinHash para o dataset
            obj.MinHashMatrix = MinHash.computeMinHashMatrix(obj.URLs, k, obj.A, obj.B, obj.P, shingleSize);
        end

        function result = analyzeURL(obj, url)
            result = struct;
            result.InputURL = url;

            % 1: Verificação no BloomFilter
            result.BloomCheck = obj.BloomFilter.check(url);
            if result.BloomCheck
                result.BloomPrediction = 'unsafe';
                return; % Retorna se estiver no BloomFilter
            else
                result.BloomPrediction = 'not found';
            end

            % 2: predict com NaiveBayes
            result.NaiveBayesPrediction = NaiveBayesModel.predict(obj.NaiveBayesModel, obj.Words, url);

            % 3: Similaridade com MinHash
            userHash = MinHash.computeUserMinHash(url, obj.K, obj.A, obj.B, obj.P, obj.ShingleSize);
            similarities = MinHash.computeSimilarities(obj.MinHashMatrix, userHash, obj.K);
            [~, bestMatchIndex] = max(similarities);
            result.MostSimilarURL = obj.URLs{bestMatchIndex};
            result.MostSimilarURLClass = char(obj.Classes(bestMatchIndex));
            result.MostSimilarURLSimilarity = similarities(bestMatchIndex);
        end
    end
end
