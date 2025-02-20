classdef MinHash
    methods(Static)
        function shingles = generateShingles(text, shingleSize)
            % Remove espaços repetidos
            text = regexprep(text, '\s+', ' '); 
            shingles = {};
            for i = 1:(length(text) - shingleSize + 1)
                shingles{end + 1} = text(i:i + shingleSize - 1);
            end
            shingles = unique(shingles); % Retornar apenas os únicos
        end

        function hashValue = createHash(values, a, b, p)
            % Criar o valor hash para um conjunto de shingles
            array = zeros(1, length(values));
            for i = 1:length(values)
                valueHash = sum(double(values{i}));
                array(i) = mod((a * valueHash + b), p);
            end
            hashValue = min(array);
        end

        function minHashMatrix = computeMinHashMatrix(urls, k, a, b, p, shingleSize)
            % Computa a matriz de MinHash para um conjunto de URLs
            numURLs = length(urls);
            shingleSets = cell(numURLs, 1);
            for i = 1:numURLs
                url = urls{i};
                shingleSets{i} = MinHash.generateShingles(url, shingleSize);
            end
            minHashMatrix = zeros(k, numURLs);
            for j = 1:numURLs
                for i = 1:k
                    minHashMatrix(i, j) = MinHash.createHash(shingleSets{j}, a(i), b(i), p(i));
                end
            end
        end

        function userHash = computeUserMinHash(inputString, k, a, b, p, shingleSize)
            % Computa o MinHash para uma string de entrada
            inputShingles = MinHash.generateShingles(inputString, shingleSize);
            userHash = zeros(k, 1);
            for i = 1:k
                userHash(i) = MinHash.createHash(inputShingles, a(i), b(i), p(i));
            end
        end

        function similarities = computeSimilarities(minHashMatrix, userHash, k)
            % Calcula similaridades entre a matriz de MinHash e um hash de usuário
            numURLs = size(minHashMatrix, 2);
            similarities = zeros(numURLs, 1);
            for i = 1:numURLs
                matches = sum(minHashMatrix(:, i) == userHash);
                similarities(i) = matches / k;
            end
        end
    end
end
