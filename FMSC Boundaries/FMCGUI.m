function varargout = FMCGUI(varargin)
% FMCGUI MATLAB code for FMCGUI.fig
%      FMCGUI, by itself, creates a new FMCGUI or raises the existing
%      singleton*.
%
%      H = FMCGUI returns the handle to a new FMCGUI or the handle to
%      the existing singleton*.
%
%      FMCGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FMCGUI.M with the given input arguments.
%
%      FMCGUI('Property','Value',...) creates a new FMCGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FMCGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FMCGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FMCGUI

% Last Modified by GUIDE v2.5 02-Nov-2012 16:55:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FMCGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FMCGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FMCGUI is made visible.
function FMCGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FMCGUI (see VARARGIN)

set(hObject,'toolbar','figure');
fullrangebutton_Callback(hObject, eventdata, handles)
if (matlabpool('size')>0)
    set(handles.matlabpoolbutton,'Visible','off');
    set(handles.mptext,'Visible','off');
end

% Choose default command line output for FMCGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes FMCGUI wait for user response (see UIRESUME)
% uiwait(handles.outaxes);


% --- Outputs from this function are returned to the command line.
function varargout = FMCGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function minX_Callback(hObject, eventdata, handles)
% hObject    handle to minX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minX as text
%        str2double(get(hObject,'String')) returns contents of minX as a double


% --- Executes during object creation, after setting all properties.
function minX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minY_Callback(hObject, eventdata, handles)
% hObject    handle to minY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minY as text
%        str2double(get(hObject,'String')) returns contents of minY as a double


% --- Executes during object creation, after setting all properties.
function minY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minZ_Callback(hObject, eventdata, handles)
% hObject    handle to minZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minZ as text
%        str2double(get(hObject,'String')) returns contents of minZ as a double


% --- Executes during object creation, after setting all properties.
function minZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxZ_Callback(hObject, eventdata, handles)
% hObject    handle to maxZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxZ as text
%        str2double(get(hObject,'String')) returns contents of maxZ as a double


% --- Executes during object creation, after setting all properties.
function maxZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxY_Callback(hObject, eventdata, handles)
% hObject    handle to maxY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxY as text
%        str2double(get(hObject,'String')) returns contents of maxY as a double


% --- Executes during object creation, after setting all properties.
function maxY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxX_Callback(hObject, eventdata, handles)
% hObject    handle to maxX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxX as text
%        str2double(get(hObject,'String')) returns contents of maxX as a double


% --- Executes during object creation, after setting all properties.
function maxX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fullrangebutton.
function fullrangebutton_Callback(hObject, eventdata, handles)
% hObject    handle to fullrangebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[dataSetName, DxRange, DyRange, Dslicerange, radius, sliceSpacing] = datasetMENU_Callback(hObject, eventdata, handles);
xRange = DxRange;
yRange = DyRange;
slicerange = Dslicerange;
set(handles.minX,'String',xRange(1))
set(handles.maxX,'String',xRange(2))
set(handles.minY,'String',yRange(1))
set(handles.maxY,'String',yRange(2))
set(handles.minZ,'String',slicerange(1))
set(handles.maxZ,'String',slicerange(2))





function cmahaBOX_Callback(hObject, eventdata, handles)
% hObject    handle to cmahaBOX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmahaBOX as text
%        str2double(get(hObject,'String')) returns contents of cmahaBOX as a double


% --- Executes during object creation, after setting all properties.
function cmahaBOX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmahaBOX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alphaBOX_Callback(hObject, eventdata, handles)
% hObject    handle to alphaBOX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alphaBOX as text
%        str2double(get(hObject,'String')) returns contents of alphaBOX as a double


% --- Executes during object creation, after setting all properties.
function alphaBOX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alphaBOX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cmaha0BOX_Callback(hObject, eventdata, handles)
% hObject    handle to cmaha0BOX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmaha0BOX as text
%        str2double(get(hObject,'String')) returns contents of cmaha0BOX as a double


% --- Executes during object creation, after setting all properties.
function cmaha0BOX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmaha0BOX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function quatmaxBOX_Callback(hObject, eventdata, handles)
% hObject    handle to quatmaxBOX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of quatmaxBOX as text
%        str2double(get(hObject,'String')) returns contents of quatmaxBOX as a double


% --- Executes during object creation, after setting all properties.
function quatmaxBOX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to quatmaxBOX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gammaWBOX_Callback(hObject, eventdata, handles)
% hObject    handle to gammaWBOX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gammaWBOX as text
%        str2double(get(hObject,'String')) returns contents of gammaWBOX as a double


% --- Executes during object creation, after setting all properties.
function gammaWBOX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gammaWBOX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in NNLTbutton.
function NNLTbutton_Callback(hObject, eventdata, handles)
% hObject    handle to NNLTbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
minX = get(handles.minX,'String');
maxX = get(handles.maxX,'String');
minY = get(handles.minY,'String');
maxY = get(handles.maxY,'String');
minZ = get(handles.minZ,'String');
maxZ = get(handles.maxZ,'String');
minX = str2num(minX);
maxX = str2num(maxX);
minY = str2num(minY);
maxY = str2num(maxY);
minZ = str2num(minZ);
maxZ = str2num(maxZ);

xRange = [minX maxX];
yRange = [minY maxY];
slicerange = [minZ maxZ];

[dataSetName, ~, ~, ~, radius, sliceSpacing] = datasetMENU_Callback(hObject, eventdata, handles);

guidata(hObject, handles);

addpath('NNLT code')
NNLT(dataSetName,xRange,yRange,slicerange,sliceSpacing,radius)
rmpath('NNLT code')


% --- Executes on button press in FMCbutton.
function FMCbutton_Callback(hObject, eventdata, handles)
% hObject    handle to FMCbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
minX = get(handles.minX,'String');
maxX = get(handles.maxX,'String');
minY = get(handles.minY,'String');
maxY = get(handles.maxY,'String');
minZ = get(handles.minZ,'String');
maxZ = get(handles.maxZ,'String');
minX = str2num(minX);
maxX = str2num(maxX);
minY = str2num(minY);
maxY = str2num(maxY);
minZ = str2num(minZ);
maxZ = str2num(maxZ);

cmaha = get(handles.cmahaBOX,'String');
alpha = get(handles.alphaBOX,'String');
cmaha0 = get(handles.cmaha0BOX,'String');
gammaW = get(handles.gammaWBOX,'String');
quatmax = get(handles.quatmaxBOX,'String');
cmaha = str2num(cmaha);
alpha = str2num(alpha);
cmaha0 = str2num(cmaha0);
gammaW = str2num(gammaW);
quatmax = str2num(quatmax);

xRange = [minX maxX];
yRange = [minY maxY];
slicerange = [minZ maxZ];

[dataSetName, ~, ~, ~, ~, sliceSpacing] = datasetMENU_Callback(hObject, eventdata, handles);

guidata(hObject, handles);

addpath('FMSC code')
main_FMC
rmpath('FMSC code')



% --- Executes on button press in Interpretbutton.
function Interpretbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Interpretbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
minConf = 0.3;
minClustSize = 10;

minX = get(handles.minX,'String');
maxX = get(handles.maxX,'String');
minY = get(handles.minY,'String');
maxY = get(handles.maxY,'String');
minZ = get(handles.minZ,'String');
maxZ = get(handles.maxZ,'String');
minX = str2num(minX);
maxX = str2num(maxX);
minY = str2num(minY);
maxY = str2num(maxY);
minZ = str2num(minZ);
maxZ = str2num(maxZ);

xRange = [minX maxX];
yRange = [minY maxY];
slicerange = [minZ maxZ];

[dataSetName, ~, ~, ~, ~, ~] = datasetMENU_Callback(hObject, eventdata, handles);

addpath('FMSC code')
main_interpret
rmpath('FMSC code')
axes(handles.axes1)
set(handles.axes1,'Visible','off');
addpath('MB visual code')
plot2assignments(data,assignments,50, 1);
rmpath('MB visual code')
guidata(hObject, handles);


% --- Executes on button press in FullFMCbutton.
function FullFMCbutton_Callback(hObject, eventdata, handles)
% hObject    handle to FullFMCbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FMCbutton_Callback(hObject, eventdata, handles)
Interpretbutton_Callback(hObject, eventdata, handles)

% --- Executes on selection change in datasetMENU.
function [dataSetName, DxRange, DyRange, Dslicerange, radius, sliceSpacing] = datasetMENU_Callback(hObject, eventdata, handles)
% hObject    handle to datasetMENU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.datasetMENU,'Value')
    case 1
        dataSetName = 'aluminum_grains';
        DxRange = [0 56]; %microns
        DyRange = [.5 18]; %microns
        Dslicerange = [5 5];
        radius = 0.71;
        sliceSpacing = 0.1;
    case 2
        dataSetName =  'aluminum_rolled';
        DxRange = [0 20]; 
        DyRange = [0 8.5];
        Dslicerange = [74 74];
        radius = 0.15;
        sliceSpacing = 0.1;
    case 3
        dataSetName =  'aluminum_tensile';
        DxRange = [1 38];
        DyRange = [1 20];
        Dslicerange = [49 49];
        radius = 0.15;
        sliceSpacing = 0.1;
    case 4
        dataSetName =  'nickel_diecompressed';
        DxRange = [4 18];
        DyRange = [4 16];
        Dslicerange = [5 5];
        radius = 0.15;
        sliceSpacing = 0.1;
    case 5
        dataSetName = 'toy';
        DxRange = [0 7.5];
        DyRange = [0 5];
        Dslicerange = [1 1];
        radius = 0.15;
        sliceSpacing = 0.1;
end
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns datasetMENU contents as cell array
%        contents{get(hObject,'Value')} returns selected item from datasetMENU


% --- Executes during object creation, after setting all properties.
function datasetMENU_CreateFcn(hObject, eventdata, handles)
% hObject    handle to datasetMENU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in matlabpoolbutton.
function matlabpoolbutton_Callback(hObject, eventdata, handles)
% hObject    handle to matlabpoolbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
matlabpool()
set(handles.matlabpoolbutton,'Visible','off');
set(handles.mptext,'Visible','off');
guidata(hObject, handles);
