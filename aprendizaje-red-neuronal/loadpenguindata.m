## Copyright (C) 2022 Pablo Alvarado
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica
##
## Para uso exclusivo del curso.

## -*- texinfo -*-
## @deftypefn {Function File} {[@var{Xtrain},@var{Ytrain},@var{Xtest},@var{Ytest},@var{names}]=} loadpenguindata (@var{ylabel},@var{trainfraction})
##
## Load Allison Horst's Penguin Dataset and split it into train and test data.
## See @url{https://allisonhorst.github.io/palmerpenguins/articles/intro.html}.
##
## @var{ylabel} string: which classes should be used as labels.  The supported
##                      values are "species","island", or "sex".  
## 
## @var{trainfraction} float: indicates which fraction of the total data samples
##                            is used for training.  It must be between 0 and 1.
##                            If ommited 0.8 is used.
##
## @var{Xtrain} and @var{Xtest} are design matrices, with data samples in each
## row, composed by four features: culmen length [mm], culmen depth [mm], 
## flipper length [mm], and body mass [g].
##
## @var{Ytrain} and @var{Ytest} are one-hot encoded class identifiers, whose
## meaning depends on the parameter @var{ylabel}.
##
## @var{names} is a cell array containing the names of the classes encoded in
## @var{Ytrain} and @var{Ytest}, i.e. the species names, or island names or 
## sex of each specimen.
##
## Since the original data is incomplete, invalid rows are removed.  Hence,
## the total number of samples returned depends on the selected @var{ylabel},
## as the missing labels depend on the selected @var{ylabel}.
##  
## @end deftypefn

function [Xtrain,Ytrain,Xtest,Ytest,names]=loadpenguindata(ylabel,trainfraction=0.8)
  
  pkg load io;
  D=csv2cell("penguins_size.csv");

  ## First row contains the labels of each column
  labels=D(1,:);

  ## Raw rows and columns
  rcols=columns(D);
  rrows=rows(D);

  ## First, extract the column index related to the given ylabel
  idx=1:rcols;
  ycolidx=idx(strcmp(labels,ylabel));

  if (isempty(ycolidx))
    msg=sprintf("Column '%s' not found",ylabel);
    error(msg);
  endif
    
  ## Extract the columns corresponding the the input data
  Xtmp=D(2:rrows,3:6);
  ## ... and the column of the label
  ytmp=D(2:rrows,ycolidx);

  ## Detect any invalid data entry in the input data, marked as NA
  valid=sum(strcmp(Xtmp,"NA"),2)==0;

  ## Strip the input and output data of any invalid entry
  Xtmp=cell2mat(Xtmp(valid,:));
  ytmp=ytmp(valid);

  ## We have to manually fix the missing data for each label type
  switch (ylabel)
    case {"species","island"}
      X=Xtmp;
      ## The species and island data has only three entries each
      ulab=unique(ytmp);
      y=[];
      for l=1:numel(ulab)
        y(:,l)=strcmp(ytmp,ulab{l});
      endfor
      names=ulab;
    case "sex"
      ## The sex data has some invalid entries.  We peek the valid
      ## ones only
      valid=or(strcmp(ytmp,"MALE"),strcmp(ytmp,"FEMALE"));
      X=Xtmp(valid,:);
      y=[strcmp(ytmp(valid),"FEMALE"),strcmp(ytmp(valid),"MALE")];
      names={"FEMALE","MALE"};
    otherwise
      error("Unknow label type");
  endswitch
    
  ## Here X and y contains all data.  We have to split it according to 
  ## train fraction, but, we need some deterministic behaviour
  rand("seed",42125);
  idx=randperm(rows(X));
  lasttrain=round(trainfraction*length(idx));
  
  trainidx=idx(1:lasttrain);
  testidx=[];
  if (lasttrain<rows(X))
    testidx=idx(lasttrain+1:end);
  endif
  
  Xtrain=X(trainidx,:);
  Ytrain=y(trainidx,:);
  
  Xtest=X(testidx,:);
  Ytest=y(testidx,:);
endfunction
