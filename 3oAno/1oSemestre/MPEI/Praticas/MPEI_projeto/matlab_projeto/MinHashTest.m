clear;

filename = 'dataset_no_ips.csv';
         
inputString = 'http://badmildiou.com/bin/bg_windows.meterpreter.reverse_tcp.exe.'; % unsafe, cortada parte do URL

% inputString = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ&pp=ygUMcmljayBhc3RlbGV5'; 

k = 100;    % Nº MinHashes
shingleSize = 15;

% Ler dataset
dataset = readcell(filename);
classes = categorical(dataset(2:end, end)); % (safe/unsafe)
urls = dataset(2:end, 1);

rng(12345); % seed
a = randi(10000, k, 1);
b = randi(10000, k, 1);
primeNumbers = primes(10000);
p = primeNumbers(randi(length(primeNumbers), k, 1));

minHashMatrix = MinHash.computeMinHashMatrix(urls, k, a, b, p, shingleSize);

userHash = MinHash.computeUserMinHash(inputString, k, a, b, p, shingleSize);

similarities = MinHash.computeSimilarities(minHashMatrix, userHash, k);

% Identificar o URL mais semelhante
[~, bestMatchIndex] = max(similarities);
similarURL = urls{bestMatchIndex};
urlClass = classes(bestMatchIndex);

% Exibir resultados
disp(['URL mais semelhante: ', similarURL]);
disp(['Classificação do URL acima: ', char(urlClass)]);
