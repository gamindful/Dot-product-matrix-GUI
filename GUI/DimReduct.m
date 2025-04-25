%%% The present 

function varargout = DimReduct(varargin)

% DIMREDUCT MATLAB code for DimReduct.fig
%      DIMREDUCT, by itself, creates a new DIMREDUCT or raises the existing
%      singleton*.
%
%      H = DIMREDUCT returns the handle to a new DIMREDUCT or the handle to
%      the existing singleton*.
%
%      DIMREDUCT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIMREDUCT.M with the given input arguments.
%
%      DIMREDUCT('Property','Value',...) creates a new DIMREDUCT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DimReduct_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DimReduct_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DimReduct

% Last Modified by GUIDE v2.5 10-Sep-2019 15:33:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DimReduct_OpeningFcn, ...
                   'gui_OutputFcn',  @DimReduct_OutputFcn, ...
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


% --- Executes just before DimReduct is made visible.
function DimReduct_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DimReduct (see VARARGIN)

% Choose default command line output for DimReduct
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DimReduct wait for user response (see UIRESUME)
 uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DimReduct_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in SelectMatrix.
function SelectMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to SelectMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[matrix]= uigetfile;
matrix=open(matrix);
fnms=fieldnames(matrix);
matrix=matrix.(fnms{1});
matrix=matrix';
handles.output=matrix;
assignin('base','matrix',handles.output)
uiresume(handles.figure1)

%matrix='Spikes_significant.mat';
%matrix=matrix.Spikes;
%handles.matrix=matrix;
%varargout{1}= handles
%handles=varargout{1}(1).matrix;
% assignin('base','varargout',varargout)
% --- Executes on button press in pushbutton6.


%%%     Calls the t-Distributed Stochastic Neighbor Embedding

function pushbutton6_Callback(hObject, eventdata, handles)
    matrix=evalin('base','matrix');
    [mappedX] = tsne(matrix);
    assignin('base','mappedX',mappedX);
    % hObject    handle to pushbutton6 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    

%%%     Calls the routine for the ISOMAP analysis

function pushbutton3_Callback(hObject, eventdata, handles)
    matrix=evalin('base','matrix');
    [mappedX, mapping] = isomap(matrix, 2, []);
    assignin('base','mappedX',mappedX);

%%%        Calls the routine for the linkage/cluster/dendrogram
function pushbutton4_Callback(hObject, eventdata, handles)
    mappedX=evalin('base','mappedX');
    cluster_linkage(mappedX)
    
    
%%%        Calls the routine for the K-Means analysis
function pushbutton5_Callback(hObject, eventdata, handles)
    mappedX=evalin('base','mappedX');
    Kmeans(mappedX)
    

    
%%%        Calls the routine for plotting the clusters in GUI

function pushbutton1_Callback(hObject, eventdata, handles)
    mappedX=evalin('base','mappedX');
    idx=evalin('base','idx');
    cluster_figure(mappedX,idx)
    
