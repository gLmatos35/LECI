function y = probTeoricaFav(prob,nLanc,nAcontPretend)
    y = nchoosek(nLanc,nAcontPretend)*prob^nAcontPretend*(1-prob)^(nLanc-nAcontPretend);
end