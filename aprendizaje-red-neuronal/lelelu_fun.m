function l=lelelu_fun(X,a)
  %size(a)
  l=a.*max(X,0)+0.1*a.*min(0,X);
endfunction 