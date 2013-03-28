for sliceNum = [1:32]
    readName = ['slice' num2str(sliceNum)];
    writeName = ['slice' num2str(sliceNum) '.txt'];
    
    save(writeName,readName,'-ascii','-tabs')
end