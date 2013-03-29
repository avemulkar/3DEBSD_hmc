function [Red Green Blue meanRGB satpix] = amplifyColor(Red,Green,Blue,scaling)

meanRGB = [mean(Red),mean(Green),mean(Blue)];
Red = scaling(1)*Red;
Green = scaling(2)*Green;
Blue = scaling(3)*Blue;

satpix = nnz(Red>1)+nnz(Green>1)+nnz(Blue>1);

Red(Red>1)=1; Red(Red<0)=0;
Green(Green>1)=1; Green(Green<0)=0;
Blue(Blue>1)=1; Blue(Blue<0)=0;