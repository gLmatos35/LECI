function y = probFav(prob,nLanc,nPretendido,Nexp)
    tentativas = rand(nLanc,Nexp) > p;
    sucessos = sum(tentativas) == nPretendido;
    y = sum(sucessos)/Nexp;
end