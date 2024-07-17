function varargout = Visualization(varargin)
% VISUALIZATION MATLAB code for Visualization.fig
%      VISUALIZATION, by itself, creates a new VISUALIZATION or raises the existing
%      singleton*.
%
%      H = VISUALIZATION returns the handle to a new VISUALIZATION or the handle to
%      the existing singleton*.
%
%      VISUALIZATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISUALIZATION.M with the given input arguments.
%
%      VISUALIZATION('Property','Value',...) creates a new VISUALIZATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Visualization_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Visualization_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Visualization

% Last Modified by GUIDE v2.5 20-Sep-2021 17:14:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Visualization_OpeningFcn, ...
                   'gui_OutputFcn',  @Visualization_OutputFcn, ...
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


% --- Executes just before Visualization is made visible.
function Visualization_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Visualization (see VARARGIN)

% Choose default command line output for Visualization
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Visualization wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Visualization_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
Funcollect=GenerationFunc;
x=0:0.5:23.5;
y0=[0.187	0.185	0.185	0.183	0.086	0.133	0.101	0.113	0.111	0.093	0.128	0.076	0.151	0.087	0.116	0.193	0.511	0.311	0.591	0.531	0.135	0.289	0.221	0.102	0.782	0.266	0.217	0.166	0.097	0.13	0.088	0.114	0.14	0.273	0.233	0.157	0.155	0.855	1.8890001	0.796	0.753	0.607	0.71	0.574	0.846	0.343	0.282	0.245];
y1=Funcollect.GetType1(y0,0.1,0.8);
y2=Funcollect.GetType2(y0,4);
y3=Funcollect.GetType3(y0,0.1,0.8);
y4=Funcollect.GetType4(y0);
y5=Funcollect.GetType5(y0,0.1,0.8);
y6=Funcollect.GetType6(y0);
y7=Funcollect.GetType7(y0,0.4);
y8=Funcollect.GetType8(y0,0.4);

size1=1.5;  
size2=15;
size3=10;

axes(handles.axes1);
plot(x,y0,'*-','Color',[0 153 229]/255,'markersize',size3,'LineWidth',size1); hold on;
plot(x,y1,'o-','Color',[255  76 76]/255,'markersize',size3,'LineWidth',size1);
set(gca,'FontSize',size2,'XTick',0:6:24); 
set(gca,'FontSize',size2,'YTick',0:0.5:2); 
xlabel('Time(hour)','FontSize',size2,'Fontname','times new Roman'); 
ylabel('Power load(kW)','FontSize',size2); 
xlim([0 24]);
ylim([0 2]);
set(gca,'Fontname','times new Roman');
legend('Real','Fake');
title('Abnormal 1');

axes(handles.axes2);
plot(x,y0,'*-','Color',[0 153 229]/255,'markersize',size3,'LineWidth',size1); hold on;
plot(x,y2,'o-','Color',[255  76 76]/255,'markersize',size3,'LineWidth',size1);
set(gca,'FontSize',size2,'XTick',0:6:24); 
set(gca,'FontSize',size2,'YTick',0:0.5:2); 
xlabel('Time(hour)','FontSize',size2,'Fontname','times new Roman'); 
ylabel('Power load(kW)','FontSize',size2); 
xlim([0 24]);
ylim([0 2]);
set(gca,'Fontname','times new Roman');
legend('Real','Fake');
title('Abnormal 2');

axes(handles.axes3);
plot(x,y0,'*-','Color',[0 153 229]/255,'markersize',size3,'LineWidth',size1); hold on;
plot(x,y3,'o-','Color',[255  76 76]/255,'markersize',size3,'LineWidth',size1);
set(gca,'FontSize',size2,'XTick',0:6:24); 
set(gca,'FontSize',size2,'YTick',0:0.5:2); 
xlabel('Time(hour)','FontSize',size2,'Fontname','times new Roman'); 
ylabel('Power load(kW)','FontSize',size2); 
xlim([0 24]);
ylim([0 2]);
set(gca,'Fontname','times new Roman');
legend('Real','Fake');
title('Abnormal 3');

axes(handles.axes4);
plot(x,y0,'*-','Color',[0 153 229]/255,'markersize',size3,'LineWidth',size1); hold on;
plot(x,y4,'o-','Color',[255  76 76]/255,'markersize',size3,'LineWidth',size1);
set(gca,'FontSize',size2,'XTick',0:6:24); 
set(gca,'FontSize',size2,'YTick',0:0.5:2); 
xlabel('Time(hour)','FontSize',size2,'Fontname','times new Roman'); 
ylabel('Power load(kW)','FontSize',size2); 
xlim([0 24]);
ylim([0 2]);
set(gca,'Fontname','times new Roman');
legend('Real','Fake');
title('Abnormal 4');

axes(handles.axes5);
plot(x,y0,'*-','Color',[0 153 229]/255,'markersize',size3,'LineWidth',size1); hold on;
plot(x,y5,'o-','Color',[255  76 76]/255,'markersize',size3,'LineWidth',size1);
set(gca,'FontSize',size2,'XTick',0:6:24); 
set(gca,'FontSize',size2,'YTick',0:0.5:2); 
xlabel('Time(hour)','FontSize',size2,'Fontname','times new Roman'); 
ylabel('Power load(kW)','FontSize',size2); 
xlim([0 24]);
ylim([0 2]);
set(gca,'Fontname','times new Roman');
legend('Real','Fake');
title('Abnormal 5');

axes(handles.axes6);
plot(x,y0,'*-','Color',[0 153 229]/255,'markersize',size3,'LineWidth',size1); hold on;
plot(x,y6,'o-','Color',[255  76 76]/255,'markersize',size3,'LineWidth',size1);
set(gca,'FontSize',size2,'XTick',0:6:24); 
set(gca,'FontSize',size2,'YTick',0:0.5:2); 
xlabel('Time(hour)','FontSize',size2,'Fontname','times new Roman'); 
ylabel('Power load(kW)','FontSize',size2); 
xlim([0 24]);
ylim([0 2]);
set(gca,'Fontname','times new Roman');
legend('Real','Fake');
title('Abnormal 6');

axes(handles.axes7);
plot(x,y0,'*-','Color',[0 153 229]/255,'markersize',size3,'LineWidth',size1); hold on;
plot(x,y7,'o-','Color',[255  76 76]/255,'markersize',size3,'LineWidth',size1);
set(gca,'FontSize',size2,'XTick',0:6:24); 
set(gca,'FontSize',size2,'YTick',0:0.5:2); 
xlabel('Time(hour)','FontSize',size2,'Fontname','times new Roman'); 
ylabel('Power load(kW)','FontSize',size2); 
xlim([0 24]);
ylim([0 2]);
set(gca,'Fontname','times new Roman');
legend('Real','Fake');
title('Abnormal 7');

axes(handles.axes8);
plot(x,y0,'*-','Color',[0 153 229]/255,'markersize',size3,'LineWidth',size1); hold on;
plot(x,y8,'o-','Color',[255  76 76]/255,'markersize',size3,'LineWidth',size1);
set(gca,'FontSize',size2,'XTick',0:6:24); 
set(gca,'FontSize',size2,'YTick',0:0.5:2); 
xlabel('Time(hour)','FontSize',size2,'Fontname','times new Roman'); 
ylabel('Power load(kW)','FontSize',size2); 
xlim([0 24]);
ylim([0 2]);
set(gca,'Fontname','times new Roman');
legend('Real','Fake');
title('Abnormal 8');
% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
