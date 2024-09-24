function y = gerarMatrizes(prob,nLanc,nAcontecimentosPretendido,Nexp)
    tentativas = rand(nLanc,Nexp) > prob;
    y = tentativas >= nAcontecimentosPretendido;
end