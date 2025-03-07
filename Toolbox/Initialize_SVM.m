function varargout = Initialize_SVM(varargin)
% INITIALIZE_SVM MATLAB code for Initialize_SVM.fig
%      INITIALIZE_SVM, by itself, creates a new INITIALIZE_SVM or raises the existing
%      singleton*.
%
%      H = INITIALIZE_SVM returns the handle to a new INITIALIZE_SVM or the handle to
%      the existing singleton*.
%
%      INITIALIZE_SVM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INITIALIZE_SVM.M with the given input arguments.
%
%      INITIALIZE_SVM('Property','Value',...) creates a new INITIALIZE_SVM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Initialize_SVM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Initialize_SVM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Initialize_SVM

% Last Modified by GUIDE v2.5 04-Sep-2021 20:55:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Initialize_SVM_OpeningFcn, ...
                   'gui_OutputFcn',  @Initialize_SVM_OutputFcn, ...
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


% --- Executes just before Initialize_SVM is made visible.
function Initialize_SVM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Initialize_SVM (see VARARGIN)

% Choose default command line output for Initialize_SVM
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Initialize_SVM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Initialize_SVM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.xlsx';'*.xls'},'Open a Exel file');
D=xlsread(filename);

%1hour,24; 30min,48; 20min,72;10min,144.
[MD,ND]=size(D);
max1=max(max(D(:,1:ND-1)));
D(:,1:ND-1)=D(:,1:ND-1)/max1;
num1=str2num(get(handles.edit1,'string'));
num2=str2num(get(handles.edit2,'string'))+num1;

Xtrain1=D(1:num1,1:ND-1);Ytrain1=D(1:num1,ND);
Xvalid1=D(num1+1:num2,1:ND-1);Yvalid1=D(num1+1:num2,ND);
Xtest1=D(num2+1:end,1:ND-1);Ytest1=D(num2+1:end,ND);
if handles.radiobutton1.Value== 1
   t= templateSVM('KernelFunction','gaussian');
elseif handles.radiobutton2.Value== 1
   t= templateSVM('KernelFunction','linear');
elseif handles.radiobutton3.Value== 1
   num3=str2num(get(handles.edit3,'string'));
   t=templateSVM('KernelFunction','polynomial','PolynomialOrder',num3);
end
Mdl =fitcecoc(Xtrain1,Ytrain1,'Learners',t);

Fake1=predict(Mdl,Xtrain1);
Fake2=predict(Mdl,Xvalid1);
Fake3=predict(Mdl,Xtest1);

Real1=Ytrain1;Real2=Yvalid1;Real3=Ytest1;
Fake1=categorical(Fake1);Fake2=categorical(Fake2);Fake3=categorical(Fake3);
Ytrain1=categorical(Ytrain1);Yvalid1=categorical(Yvalid1);Ytest1=categorical(Ytest1);
figure();plotconfusion(Ytrain1,Fake1);title('Confusion matrix of training set');
figure();plotconfusion(Yvalid1,Fake2);title('Confusion matrix of validation set');
figure();plotconfusion(Ytest1,Fake3);title('Confusion matrix of test set');

FakeTemp=str2num(char(Fake1)); 
RealTemp=Real1; 
FakeTemp(FakeTemp>1)=1;RealTemp(RealTemp>1)=1;
TP=0;FN=0;FP=0;TN=0;
for j=1:length(RealTemp)
    if (RealTemp(j)==0)&&(FakeTemp(j)==0)
        TP=TP+1;
    elseif (RealTemp(j)==0)&&(FakeTemp(j)==1)
        FN=FN+1;
    elseif (RealTemp(j)==1)&&(FakeTemp(j)==0)
        FP=FP+1;
    elseif (RealTemp(j)==1)&&(FakeTemp(j)==1)
        TN=TN+1;
    end
end
global Accuracy1 Precision1 Recall1 F1score1
Accuracy1=(TP+TN)/(TP+FN+FP+TN);
Precision1=TP/(TP+FP);
Recall1=TP/(TP+FN);
F1score1=2*TP/(2*TP+FP+FN);

FakeTemp=str2num(char(Fake2));RealTemp=Real2;
FakeTemp(FakeTemp>1)=1;RealTemp(RealTemp>1)=1;
TP=0;FN=0;FP=0;TN=0;
for j=1:length(RealTemp)
    if (RealTemp(j)==0)&&(FakeTemp(j)==0)
        TP=TP+1;
    elseif (RealTemp(j)==0)&&(FakeTemp(j)==1)
        FN=FN+1;
    elseif (RealTemp(j)==1)&&(FakeTemp(j)==0)
        FP=FP+1;
    elseif (RealTemp(j)==1)&&(FakeTemp(j)==1)
        TN=TN+1;
    end
end
global Accuracy2 Precision2 Recall2 F1score2
Accuracy2=(TP+TN)/(TP+FN+FP+TN);
Precision2=TP/(TP+FP);
Recall2=TP/(TP+FN);
F1score2=2*TP/(2*TP+FP+FN);

FakeTemp=str2num(char(Fake3));RealTemp=Real3;
FakeTemp(FakeTemp>1)=1;RealTemp(RealTemp>1)=1;
TP=0;FN=0;FP=0;TN=0;
for j=1:length(RealTemp)
    if (RealTemp(j)==0)&&(FakeTemp(j)==0)
        TP=TP+1;
    elseif (RealTemp(j)==0)&&(FakeTemp(j)==1)
        FN=FN+1;
    elseif (RealTemp(j)==1)&&(FakeTemp(j)==0)
        FP=FP+1;
    elseif (RealTemp(j)==1)&&(FakeTemp(j)==1)
        TN=TN+1;
    end
end
global Accuracy3 Precision3 Recall3 F1score3;
Accuracy3=(TP+TN)/(TP+FN+FP+TN);
Precision3=TP/(TP+FP); 
Recall3=TP/(TP+FN); 
F1score3=2*TP/(2*TP+FP+FN); 

Results('Position',[105,16,97,34]);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.xlsx';'*.xls'},'Open a Exel file');
D=xlsread(filename);

%1hour,24; 30min,48; 20min,72;10min,144.
[MD,ND]=size(D);
max1=max(max(D(:,1:ND-1)));
D(:,1:ND-1)=D(:,1:ND-1)/max1;
num1=str2num(get(handles.edit1,'string'));
num2=str2num(get(handles.edit2,'string'))+num1;

Xtrain1=D(1:num1,1:ND-1);Ytrain1=D(1:num1,ND);
Xvalid1=D(num1+1:num2,1:ND-1);Yvalid1=D(num1+1:num2,ND);
Xtest1=D(num2+1:end,1:ND-1);Ytest1=D(num2+1:end,ND);
if handles.radiobutton1.Value== 1
   t= templateSVM('KernelFunction','gaussian');
elseif handles.radiobutton2.Value== 1
   t= templateSVM('KernelFunction','linear');
elseif handles.radiobutton3.Value== 1
   num3=str2num(get(handles.edit3,'string'));
   t=templateSVM('KernelFunction','polynomial','PolynomialOrder',num3);
end
Mdl =fitcecoc(Xtrain1,Ytrain1,'Learners',t);

Fake1=predict(Mdl,Xtrain1);
Fake2=predict(Mdl,Xvalid1);
Fake3=predict(Mdl,Xtest1);

Fake1=categorical(Fake1);Fake2=categorical(Fake2);Fake3=categorical(Fake3);
Ytrain1=categorical(Ytrain1);Yvalid1=categorical(Yvalid1);Ytest1=categorical(Ytest1);
figure();plotconfusion(Ytrain1,Fake1);title('Confusion matrix of training set');
figure();plotconfusion(Yvalid1,Fake2);title('Confusion matrix of validation set');
figure();plotconfusion(Ytest1,Fake3);title('Confusion matrix of test set');

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
Choose_method('Position',[105,16,100,17]);
close(handles.figure1);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
