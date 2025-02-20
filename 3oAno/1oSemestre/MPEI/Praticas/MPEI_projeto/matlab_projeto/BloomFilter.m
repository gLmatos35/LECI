classdef BloomFilter
    properties
        Filter      % vetor bool que representa o filtro
        HashCount   % nº de funções hash (k)
    end
    
    methods
        % init
        function obj = BloomFilter(n, k)
            obj.Filter = false(1, n);
            obj.HashCount = k;
        end

        function hashes = createHash(~, value, k)
            hashes = zeros(1, k);
            str = value;
            for i = 1:k
                str = [str num2str(i)];
                h = string2hash(str);
                hashes(i) = h;
            end
        end

        function obj = insert(obj, value)
            hashes = obj.createHash(value, obj.HashCount);
            for i = 1:length(hashes)
                index = mod(hashes(i), length(obj.Filter)) + 1;
                obj.Filter(index) = true;
            end
        end

        function isPresent = check(obj, value)
            hashes = obj.createHash(value, obj.HashCount);
            isPresent = true;
            for i = 1:length(hashes)
                index = mod(hashes(i), length(obj.Filter)) + 1;
                if ~obj.Filter(index)
                    isPresent = false;
                    break;
                end
            end
        end
    end
end