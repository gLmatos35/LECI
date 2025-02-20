clear;

% Configurações do filtro de Bloom
n = 100000; % tamanho do filtro de Bloom    (expressão slides)
k = 7;      % número de funções hash        (slides)

% Inicializar filtro
bloomFilter = BloomFilter(n, k);

data = readtable('dataset_no_ips.csv', 'TextType', 'string', 'Delimiter', ',');

% Filtrar apenas as URLs marcadas como unsafe
unsafeUrls = data{strcmp(data.type, 'unsafe'), 1};
disp(['Total de URLs unsafe: ', num2str(length(unsafeUrls))]);

% Inserir URLs unsafe no filtro de Bloom
for i = 1:length(unsafeUrls)
    bloomFilter = bloomFilter.insert(unsafeUrls{i});
end

% URLs aleatórias
allUrls = data{:, 1};
type = data{:, 2};
x = randperm(length(allUrls), 10000); 
randomUrls = allUrls(x);    % 50 URLs random

presentCount = 0;        % URLs marcadas como presentes no Bloom Filter
notPresentCount = 0;     % ~...
truePositiveCount = 0;   % URLs corretamente identificadas como unsafe
falsePositiveCount = 0;  % URLs safe incorretamente identificadas como presentes no Filtro

for i = 1:length(randomUrls)
    if bloomFilter.check(randomUrls{i})
        presentCount = presentCount + 1;
        
        % Verificar se é mesmo unsafe
        if ismember(randomUrls{i}, unsafeUrls)
            truePositiveCount = truePositiveCount + 1;
        else
            falsePositiveCount = falsePositiveCount + 1;
        end
    else
        % Não encontrada no filtro
        notPresentCount = notPresentCount + 1;
    end
end

% Resultados
fprintf('Total de URLs testadas: %d\n', length(randomUrls));
fprintf(' - Presentes no BloomFilter: %d\n', presentCount);
fprintf('   -> Verdadeiros Positivos (realmente "unsafe"): %d\n', truePositiveCount);
fprintf('   -> Falsos Positivos (identificados como "presentes", mas são "safe"): %d\n', falsePositiveCount);
fprintf(' - Não presentes no BloomFilter: %d\n', notPresentCount);
fprintf('______________________________________________________________________________\n')