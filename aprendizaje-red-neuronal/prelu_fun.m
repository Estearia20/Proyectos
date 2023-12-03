function l=prelu_fun(X,a)
  l=max(a.*X,X);
endfunction 