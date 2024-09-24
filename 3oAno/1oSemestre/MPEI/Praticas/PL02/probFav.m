function y = probFav(prob,nLanc,nAcontecimentosPretendido,Nexp)
    tentativas = rand(nLanc,Nexp) > prob;
    sucessos = sum(tentativas) >= nAcontecimentosPretendido;
    y = sum(sucessos)/Nexp;
end