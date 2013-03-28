This file describes the main components in the EDAX ColorMapping folder.
The EDAX folder primarily deals with analyzing the images after creating the
ipf figure. Data is imported from a set of files labeled ipf_NUMBER_.txt

findBoundaries(ipfNum, quantStart, quantStop)
    Chooses a specific ipf file by ipfNum and applies quantizations from
    quantStart to quantStop. findBoundaries creates a series of files
    BoundaryIPF_QUANTNUMBER_.txt where QUANTNUMBER is the number of 
    colors in each quantization.

selectImageBoundaries(start, stop)
    Goes through a series of ipf files allowing a user to select a boundary
    of interest from ipf__start__.txt to ipf__stop__.txt. After going through
    start and stop, a file containing the boundary pts is created (Pts.txt)
    along with centroids for each boundary (Centroids.txt)

createEdaxImages(start, stop)
    Goes through a series of ipf files allowing a user to create images from
    ipf__start__.txt to ipf__stop__.txt. Images are saved as ipfP__NUMBER__.jpg.

createEdaxImagesQuant(start, stop, numCol)
    Goes through a series of ipf files allowing a user to create images from
    ipf__start__.txt to ipf__stop__.txt. Images are quantizations using a quantization
    size of numCol colors. Images are saved as ipfP__NUMBER__.jpg.