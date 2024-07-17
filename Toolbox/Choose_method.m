function varargout = Choose_method(varargin)
% CHOOSE_METHOD MATLAB code for Choose_method.fig
%      CHOOSE_METHOD, by itself, creates a new CHOOSE_METHOD or raises the existing
%      singleton*.
%
%      H = CHOOSE_METHOD returns the handle to a new CHOOSE_METHOD or the handle to
%      the existing singleton*.
%
%      CHOOSE_METHOD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHOOSE_METHOD.M with the given input arguments.
%
%      CHOOSE_METHOD('Property','Value',...) creates a new CHOOSE_METHOD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Choose_method_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Choose_method_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Choose_method

% Last Modified by GUIDE v2.5 30-Aug-2021 14:15:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Choose_method_OpeningFcn, ...
                   'gui_OutputFcn',  @Choose_method_OutputFcn, ...
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


% --- Executes just before Choose_method is made visible.
function Choose_method_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Choose_method (see VARARGIN)

% Choose default command line output for Choose_method
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Choose_method wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Choose_method_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global BJLSTM
BJLSTM=3;%LSTM
Initialize_LSTM('Position',[105,16,115,24]);
close(handles.figure1);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global BJLSTM
BJLSTM=2;%BiLSTM
Initialize_LSTM('Position',[105,16,115,24]);
close(handles.figure1);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
Initialize_MLP('Position',[105,16,115,24]);
close(handles.figure1);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
Initialize_CNN('Position',[105,16,115,24]);
close(handles.figure1);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
Initialize_SVM('Position',[105,16,115,23]);
close(handles.figure1);
