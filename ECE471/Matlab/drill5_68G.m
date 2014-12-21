function varargout = drill5_68G(varargin)
% DRILL5_68G MATLAB code for drill5_68G.fig
%      DRILL5_68G, by itself, creates a new DRILL5_68G or raises the existing
%      singleton*.
%
%      H = DRILL5_68G returns the handle to a new DRILL5_68G or the handle to
%      the existing singleton*.
%
%      DRILL5_68G('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRILL5_68G.M with the given input arguments.
%
%      DRILL5_68G('Property','Value',...) creates a new DRILL5_68G or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drill5_68G_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drill5_68G_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drill5_68G

% Last Modified by GUIDE v2.5 13-Nov-2014 13:59:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @drill5_68G_OpeningFcn, ...
                   'gui_OutputFcn',  @drill5_68G_OutputFcn, ...
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


% --- Executes just before drill5_68G is made visible.
function drill5_68G_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drill5_68G (see VARARGIN)

% Choose default command line output for drill5_68G
handles.output = hObject;

% setup a default display
handles.m = exprnd(2,1,10000);
axes(handles.axes1);
cla;
hist(handles.m,30);
alpha = get(handles.alpha, 'Value');
axes(handles.axes2);
cla
y=1-exp(-(alpha)*handles.m);
hist(y,30);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drill5_68G wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = drill5_68G_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in regen.
function regen_Callback(hObject, eventdata, handles)
% hObject    handle to regen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp(handles);
% if handles.Value == 1
%     disp(handles.Value);
% end
handles.m = exprnd(2,1,10000);
axes(handles.axes1);
cla;
hist(handles.m,30);

% --- Executes on slider movement.
function alpha_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
alpha = get(handles.alpha, 'Value');
set(handles.text1,'String',sprintf('alpha = %5.3f',alpha))
%disp(alpha)
axes(handles.axes2);
cla
y=1-exp(-(alpha)*handles.m);
hist(y,30);

% --- Executes during object creation, after setting all properties.
function alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function lowalpha_Callback(hObject, eventdata, handles)
% hObject    handle to lowalpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowalpha as text
%        str2double(get(hObject,'String')) returns contents of lowalpha as a double
lalpha = str2double(get(handles.lowalpha,'String'));
halpha = str2double(get(handles.highalpha,'String'));
set(handles.alpha,'Min',lalpha);
set(handles.alpha,'Max',halpha);
set(handles.alpha, 'Value',(halpha-lalpha)/2);

% --- Executes during object creation, after setting all properties.
function lowalpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowalpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function highalpha_Callback(hObject, eventdata, handles)
% hObject    handle to highalpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of highalpha as text
%        str2double(get(hObject,'String')) returns contents of highalpha as a double
lalpha = str2double(get(handles.lowalpha,'String'));
halpha = str2double(get(handles.highalpha,'String'));
set(handles.alpha,'Min',lalpha);
set(handles.alpha,'Max',halpha);
set(handles.alpha, 'Value',(halpha-lalpha)/2);


% --- Executes during object creation, after setting all properties.
function highalpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to highalpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
