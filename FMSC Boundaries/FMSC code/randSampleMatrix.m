function SamplePop = randSampleMatrix(Population,K,DIM)
% randSampleMatrix(Population,K,DIM)
% same as randSample but samples
% rows or columns of matrices
% DIM - 'row' (default),'col'

if nargin > 2
    % DIM == 'col'
    if strcmp(DIM,'col')
        numElem = size(Population,2);
        sampleInd = randsample(numElem,K);
        SamplePop = Population(:,sampleInd);
    % DIM == 'row'
    elseif strcmp(DIM,'row')
        numElem = size(Population,1);
        sampleInd = randsample(numElem,K);
        SamplePop = Population(sampleInd,:);
    else
        error('invalid input for DIM, options - ''row'',''col''') 
    end
else
    % DIM == 'row' (default)
    numElem = size(Population,1);
    sampleInd = randsample(numElem,K);
    SamplePop = Population(sampleInd,:);
end
        
        
        
        
        
