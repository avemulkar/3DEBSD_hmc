function varargout = find_corners_GUI(varargin)
% FIND_CORNERS_GUI MATLAB code for find_corners_GUI.fig
%      FIND_CORNERS_GUI, by itself, creates a new FIND_CORNERS_GUI or raises the existing
%      singleton*.
%
%      H = FIND_CORNERS_GUI returns the handle to a new FIND_CORNERS_GUI or the handle to
%      the existing singleton*.
%
%      FIND_CORNERS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIND_CORNERS_GUI.M with the given input arguments.
%
%      FIND_CORNERS_GUI('Property','Value',...) creates a new FIND_CORNERS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before find_corners_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to find_corners_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help find_corners_GUI

% Last Modified by GUIDE v2.5 05-Apr-2012 23:37:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @find_corners_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @find_corners_GUI_OutputFcn, ...
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


% --- Executes just before find_corners_GUI is made visible.
function find_corners_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to find_corners_GUI (see VARARGIN)

% Choose default command line output for find_corners_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes find_corners_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% add paths to code
addpath('BL Transformation Code')
addpath('IPF Code')


% --- Outputs from this function are returned to the command line.
function varargout = find_corners_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_text_c1x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_c1x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_c1x as text
%        str2double(get(hObject,'String')) returns contents of edit_text_c1x as a double

replotLine(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_text_c1x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_c1x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_text_c2x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_c2x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_c2x as text
%        str2double(get(hObject,'String')) returns contents of edit_text_c2x as a double

replotLine(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_text_c2x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_c2x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_text_c3x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_c3x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_c3x as text
%        str2double(get(hObject,'String')) returns contents of edit_text_c3x as a double

replotLine(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_text_c3x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_c3x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_text_c4x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_c4x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_c4x as text
%        str2double(get(hObject,'String')) returns contents of edit_text_c4x as a double

replotLine(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_text_c4x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_c4x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_text_c1y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_c1y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_c1y as text
%        str2double(get(hObject,'String')) returns contents of edit_text_c1y as a double

replotLine(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_text_c1y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_c1y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_text_c2y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_c2y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_c2y as text
%        str2double(get(hObject,'String')) returns contents of edit_text_c2y as a double

replotLine(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_text_c2y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_c2y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_text_c3y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_c3y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_c3y as text
%        str2double(get(hObject,'String')) returns contents of edit_text_c3y as a double

replotLine(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_text_c3y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_c3y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_text_c4y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_c4y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_c4y as text
%        str2double(get(hObject,'String')) returns contents of edit_text_c4y as a double

replotLine(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_text_c4y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_c4y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_text_minSlice_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_minSlice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_minSlice as text
%        str2double(get(hObject,'String')) returns contents of edit_text_minSlice as a double


% --- Executes during object creation, after setting all properties.
function edit_text_minSlice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_minSlice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_text_maxSlice_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_maxSlice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_maxSlice as text
%        str2double(get(hObject,'String')) returns contents of edit_text_maxSlice as a double


% --- Executes during object creation, after setting all properties.
function edit_text_maxSlice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_maxSlice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit_text_dataset_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_dataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_dataset as text
%        str2double(get(hObject,'String')) returns contents of edit_text_dataset as a double


% --- Executes during object creation, after setting all properties.
function edit_text_dataset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_dataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_text_deltay_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_deltay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_deltay as text
%        str2double(get(hObject,'String')) returns contents of edit_text_deltay as a double


% --- Executes during object creation, after setting all properties.
function edit_text_deltay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_deltay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_text_deltax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_deltax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_deltax as text
%        str2double(get(hObject,'String')) returns contents of edit_text_deltax as a double


% --- Executes during object creation, after setting all properties.
function edit_text_deltax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_deltax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_text_msg_Callback(hObject, eventdata, handles)
% hObject    handle to edit_text_msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_text_msg as text
%        str2double(get(hObject,'String')) returns contents of edit_text_msg as a double


% --- Executes during object creation, after setting all properties.
function edit_text_msg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_text_msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_msg.
function listbox_msg_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_msg contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_msg


% --- Executes during object creation, after setting all properties.
function listbox_msg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.listbox_msg,'String','System Messages');

%% folder paths
dataSetName = get(handles.edit_text_dataset,'String');
writeFolder = [fullfile('Transformed Data',dataSetName)];
dataFolder = [fullfile('Cleaned Data',dataSetName)];

if exist(dataFolder,'dir')
    %% if data exist
    if ~exist(writeFolder,'dir'); 
        % make write folder if necessary
        mkdir(writeFolder); 
        newMsg = ['Created folder: ',writeFolder];
        updateMsg(hObject, eventdata, handles, newMsg)
    end
    
    % set current slice = first slice
    slice = get(handles.edit_text_minSlice,'String');
    set(handles.static_text_slice,'String',slice);

    % plot data and corners
    pushbutton_reset_Callback(hObject, eventdata, handles)

else
    %% if data does not exist
    newMsg = ['Cannot find data: ',dataFolder];
    updateMsg(hObject, eventdata, handles, newMsg)
end




% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_transform,'UserData',[]);

%% plot data
[data corners] = getData(hObject, eventdata, handles);
plotData(hObject, eventdata, handles, data)

%% plot corners
% get corners if file already exists
if isempty(corners)
    corners = getCorners(hObject, eventdata, handles);
else
    newMsg = 'Loaded existing corner points';
    updateMsg(hObject, eventdata, handles, newMsg)
end
setCorners(hObject, eventdata, handles, corners)
hold on
cx = [corners(:,1); corners(1,1)];
cy = [corners(:,2); corners(1,2)];
line(cx,cy,'color','k','linewidth',2);


% --- Executes on button press in pushbutton_transform.
function pushbutton_transform_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_transform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% import data
data = getData(hObject, eventdata, handles);

% get corners from GUI
corners = getCorners(hObject, eventdata, handles);

% transform data
deltax = get(handles.edit_text_deltax,'String');
deltay = get(handles.edit_text_deltay,'String');
deltax = str2double(deltax);
deltay = str2double(deltay);

desiredCorners = [0 0; 0 deltay; deltax deltay; deltax 0];
transData = BLtranform(data,corners,desiredCorners);

% save trasnformed data to UserData handle
set(handles.pushbutton_transform,'UserData',transData)

%calculate IPF colors         
IPFcolors = myeuler2rgb(transData(:,1:3));

% create IPF map
colorList = [IPFcolors transData(:,4:6)];
spacing = estSpacing(data(:,4));
IPFcolorsMap = MapFromList(colorList,spacing);

% plot IPF map
cla(handles.plot1);

xRange = [min(transData(:,4)),max(transData(:,4))];
yRange = [min(transData(:,5)),max(transData(:,5))];

image(xRange,yRange,IPFcolorsMap);
set(handles.plot1,'Ydir','normal')
axis equal;
axis tight;

% draw desired corner point lines
x = [desiredCorners(:,1); 0];
y = [desiredCorners(:,2); 0];
line(x,y,'color','k','linewidth',2);


% --- Executes on button press in pushbutton_skip.
function pushbutton_skip_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_skip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in pushbutton_save.

%% increment slice
%get slice #
slice = get(handles.static_text_slice,'String');
slice = str2double(slice);

% check if still in the slice  range
maxSlice = get(handles.edit_text_maxSlice,'String');
maxSlice = str2double(maxSlice);

slice = slice +1;
if slice > maxSlice
    newMsg = sprintf('All finished! :D');
    updateMsg(hObject, eventdata, handles, newMsg)
    %easterEgg(hObject, eventdata, handles)
    return
end

%increment
set(handles.static_text_slice,'String',int2str(slice));

%% plot data and corners
pushbutton_reset_Callback(hObject, eventdata, handles)


function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% save work
transData = get(handles.pushbutton_transform,'UserData');
if ~isempty(transData)
    % save work
    saveTransData(hObject, eventdata, handles, transData);
    % continue
    pushbutton_skip_Callback(hObject, eventdata, handles)
else
    newMsg = 'Error: cannot save, data not transformed';
    updateMsg(hObject, eventdata, handles, newMsg)
end



function plot1_Callback(hObject, eventdata, handles)
% gets mouse point on graph and set the corner
[x y] = ginput(1);

% get axis limits
xRange = get(handles.plot1,'Xlim');
yRange = get(handles.plot1,'Ylim');
xMid = mean(xRange);
yMid = mean(yRange);

% check what quadrant the points inside
if x<=xMid && y<=yMid
    c1x = num2str(x); set(handles.edit_text_c1x,'String',c1x); 
    c1y = num2str(y); set(handles.edit_text_c1y,'String',c1y);
elseif x<=xMid && y>yMid
    c2x = num2str(x); set(handles.edit_text_c2x,'String',c2x); 
    c2y = num2str(y); set(handles.edit_text_c2y,'String',c2y);
elseif x>xMid && y>yMid
    c3x = num2str(x); set(handles.edit_text_c3x,'String',c3x); 
    c3y = num2str(y); set(handles.edit_text_c3y,'String',c3y);
elseif x>xMid && y<=yMid 
    c4x = num2str(x); set(handles.edit_text_c4x,'String',c4x);
    c4y = num2str(y); set(handles.edit_text_c4y,'String',c4y);
else
    error('How did you not click a quadrant? Troll')
end

% replot the corner point lines
replotLine(hObject, eventdata, handles)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% helper functions

function [data corners] = getData(hObject, eventdata, handles)
% imports the data from file
%% import data
dataSetName = get(handles.edit_text_dataset,'String');
slice = get(handles.static_text_slice,'String');
slice = str2num(slice);
[data corners msg] = loadCornerData(dataSetName,slice);

 
function plotData(hObject, eventdata, handles, data)
% plots the inverse pole figure

% find ipf rgb values from euler angle
IPFcolors = myeuler2rgb(data(:,1:3));

%find spacing
spacing = estSpacing(data(:,4));
mapScaling = 1/spacing;
newMsg = sprintf('Replotting: assumed spacing: %g', spacing);
updateMsg(hObject, eventdata, handles, newMsg)

% respace x y values
dataI = round(data(:,4:5)*mapScaling);
dataI(:,1) = dataI(:,1) - min(dataI(:,1)) + 1;
dataI(:,2) = dataI(:,2) - min(dataI(:,2)) + 1;

% preallocate memory
IPFcolorsMap = zeros(max(dataI(:,2)),max(dataI(:,1)),3);

% create map by adding rgb values to appropriate entry
numPts = size(data,1);
for i=1:numPts
    IPFcolorsMap(dataI(i,2),dataI(i,1),:)=IPFcolors(i,:);
end

% plot colormap
axes(handles.plot1);
hold off;
xRange = [min(data(:,4)),max(data(:,4))];
yRange = [min(data(:,5)),max(data(:,5))];
handle_plot1 = image(xRange,yRange,IPFcolorsMap);
set(handles.plot1,'Ydir','normal')
axis equal;
axis tight;

% set callback function for graph
set(handle_plot1,'ButtonDownFcn',{@plot1_Callback, handles})


function setCorners(hObject, eventdata, handles, corners)
% sets the corner edit text
cx = corners(:,1);
cy = corners(:,2);
c1x = num2str(cx(1)); set(handles.edit_text_c1x,'String',c1x); 
c2x = num2str(cx(2)); set(handles.edit_text_c2x,'String',c2x); 
c3x = num2str(cx(3)); set(handles.edit_text_c3x,'String',c3x); 
c4x = num2str(cx(4)); set(handles.edit_text_c4x,'String',c4x);
c1y = num2str(cy(1)); set(handles.edit_text_c1y,'String',c1y); 
c2y = num2str(cy(2)); set(handles.edit_text_c2y,'String',c2y); 
c3y = num2str(cy(3)); set(handles.edit_text_c3y,'String',c3y); 
c4y = num2str(cy(4)); set(handles.edit_text_c4y,'String',c4y); 

function corners = getCorners(hObject, eventdata, handles)
% plot corner points if exists
%% get corners
c1x = get(handles.edit_text_c1x,'String'); c1x = str2double(c1x);
c1y = get(handles.edit_text_c1y,'String'); c1y = str2double(c1y);
c2x = get(handles.edit_text_c2x,'String'); c2x = str2double(c2x);
c2y = get(handles.edit_text_c2y,'String'); c2y = str2double(c2y);
c3x = get(handles.edit_text_c3x,'String'); c3x = str2double(c3x);
c3y = get(handles.edit_text_c3y,'String'); c3y = str2double(c3y);
c4x = get(handles.edit_text_c4x,'String'); c4x = str2double(c4x);
c4y = get(handles.edit_text_c4y,'String'); c4y = str2double(c4y);

corners = [c1x c2x c3x c4x;...
           c1y c2y c3y c4y]';
       
   
function replotLine(hObject, eventdata, handles)
% delete current corner lines
handles_lines = findobj(gca,'Type','line');
delete(handles_lines)
% replot corners
corners = getCorners(hObject, eventdata, handles);
cx = [corners(:,1); corners(1,1)];
cy = [corners(:,2); corners(1,2)];
hold on
line(cx,cy,'color','k','linewidth',2);
           

function saveTransData(hObject, eventdata, handles, transData)
% save transformed data and corner points
% data: Matrix (Nx6) [euler1 euler2 euler3 x y confidence]
% corners: Matrix (4x2) [x y]

%% Write path for data
dataSetName = get(handles.edit_text_dataset,'String');
slice = get(handles.static_text_slice,'String');
slice = str2double(slice);
dataFolder = 'Transformed Data';
fileName = 'scanTrans#.txt';

%% Save that data
fileNameTemp = strrep(fileName,'#',int2str(slice));
dataPath = [fullfile(dataFolder,dataSetName,fileNameTemp)];
save(dataPath,'transData','-ascii', '-tabs');

%% get corners
corners = getCorners(hObject, eventdata, handles);

%% Save all corners
cornerpath = [fullfile('Corner Points',strcat(dataSetName,'.txt'))];
if exist(cornerpath,'file')
    allCorners = importdata(cornerpath);
    
    numSlices = size(allCorners,1);
    if numSlices<slice
        % pad with zeros
        allCorners = [allCorners; zeros(slice-numSlices,8)];
    end
else
    allCorners = zeros(slice,8);
end
allCorners(slice,:) = reshape(corners',1,8);
save(cornerpath,'allCorners','-ascii', '-tabs')

updateMsg(hObject, eventdata, handles, 'Data and corners saved')

function updateMsg(hObject, eventdata, handles, newMsg)
% displays messages from the program in the listbox
oldMsg = get(handles.listbox_msg,'String');
msg = vertcat(cellstr(oldMsg),cellstr(newMsg));
set(handles.listbox_msg,'String',msg);
set(handles.listbox_msg,'Value',length(msg));

function easterEgg(hObject, eventdata, handles)
% play the best video in the universe
minSlice = get(handles.edit_text_minSlice,'String');
maxSlice = get(handles.edit_text_maxSlice,'String');
minSlice = str2double(minSlice);
maxSlice = str2double(maxSlice);

if maxSlice-minSlice>8
    newMsg = ['I said hey, what''s goin'' on'];
    updateMsg(hObject, eventdata, handles, newMsg)
    
    set(handles.plot1,'Units','pixels');
    apos = get(handles.plot1,'position');
    actx = actxcontrol('WMPlayer.ocx.7',apos);
    media = actx.newMedia(fullfile('BL transformation code','HEYYEYAAEYAAAEYAEYAA.mp4'));
    actx.CurrentMedia = media;
    actx.Controls.play
    actx.Close
end