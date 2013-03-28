function Afimage(start, stop)

for q=start:stop

    %Step 1: Import the text file
    path    =['ipf', int2str(q), '.txt'];
    Data=importfile(path);
    clear path

    
    for x=1:length(Data);
        Data(x,2)=Data(x,2)*6;
    end
    max(Data(:,2))
    
    for x=1:length(Data);
        if Data(x,2)>1;
            Data(x,2)=0;
        end
    end
    max(Data(:,2))


 %Step 2 build image from txt files
    IMAGEipfEDAX(Data)
    axis off
    
    saveas(gcf, ['ipf', int2str(q), 'c.jpg']); 
    close(gcf);

    clear Data
end
