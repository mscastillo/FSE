function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 06-Oct-2014 12:11:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

load 'GMM_results'
k = size(GMM,2) ;
axes(handles.axes1)
hold on
handles.density = imagesc(GMM_axis(1):GMM_axis(2),GMM_axis(3):GMM_axis(4),values') ;
handles.mu = plot(mu{k}(:,1),mu{k}(:,2),'ko','MarkerSize',6,'MarkerEdgeColor','k','MarkerFaceColor','w') ;
handles.current_data = ezcontour( @(x1,x2)pdf(GMM{k},[x1 x2]),GMM_axis,500 ) ; colormap(hot) ;
title( ['Data density and GMM with ',num2str(k),'-modes.'] ) ;
xlabel(x_label) ; ylabel(y_label) ;
hold off
K = k ;
set( handles.slider_gmm,'Max',K,'Min',1,'Value',K,'SliderStep',[1/(K-1) 1/(K-1)] ) ;
set( handles.text_slider,'String',strjoin({'k =',num2str(k),'modes'}) ) ;


axes(handles.axes2)
gscatter(data(:,1),data(:,2),classes_names) ; grid on
title( 'Original data' )
legend(handles.axes2,'Location','east') ; legend('boxoff')
x_lim = get(handles.axes2,'XLim') ;
y_lim = get(handles.axes2,'YLim') ;
set( handles.axes2,'XLim',[x_lim(1) x_lim(2)+( x_lim(2)-x_lim(1) )/2 ] )


axes(handles.axes3)
gscatter(data(:,1),data(:,2),cluster(GMM{k},data)) ; grid on
title( strjoin({'Clustering using k=',num2str(k)}) )
legend off
set( handles.axes3,'XLim',[x_lim(1) x_lim(2)+( x_lim(2)-x_lim(1) )/2 ] )


% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_gmm_Callback(hObject, eventdata, handles)
% hObject    handle to slider_gmm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
axes(handles.axes1)
k = floor(get(hObject,'Value')) ;
load 'GMM_results'
hold on
handles.density = imagesc(GMM_axis(1):GMM_axis(2),GMM_axis(3):GMM_axis(4),values') ;
handles.mu = plot(mu{k}(:,1),mu{k}(:,2),'ko','MarkerSize',6,'MarkerEdgeColor','k','MarkerFaceColor','w') ;
handles.current_data = ezcontour( @(x1,x2)pdf(GMM{k},[x1 x2]),GMM_axis,500 ) ; colormap(hot) ;
title( ['Data density and GMM with ',num2str(k),'-modes.'] ) ;
xlabel(x_label) ; ylabel(y_label) ;
hold off
set( handles.text_slider,'String',strjoin({'k =',num2str(k),'modes'}) ) ;


axes(handles.axes3)
gscatter(data(:,1),data(:,2),cluster(GMM{k},data)) ; grid on
title( strjoin({'Clustering using k=',num2str(k)}) )
legend off
x = get(handles.axes2,'XLim') ;
set( handles.axes3,'XLim',[x(1) x(2) ] )


% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider_gmm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_gmm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton_classify.
function pushbutton_classify_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_classify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load 'GMM_results'
axes(handles.axes1)
k = floor(get(handles.slider_gmm,'Value')) ;
[ file_path,file_name,file_extension ] = fileparts( file ) ;
T = table(classes_names,data(:,1),data(:,2),cluster(GMM{k},data),'VariableNames',{'Actual_class';'x';'y';'GMM_classification_result'}) ;
writetable( T,fullfile(file_path,strjoin({file_name,'__GMM_clustering_with_',num2str(k),'_modes.csv'},'')),'Delimiter',',' ) ;
fid = fopen(fullfile(file_path,strjoin({file_name,'__GMM_clustering_with_',num2str(k),'_modes.csv'},'')),'a') ;
fprintf(fid,'# Next is listed the parameters of each of the Gaussians considered in the model.\n') ;
for i = 1:k
formatSpec = '# %i : mean(x) = %8.4f, mean(y) = %8.4f, cov(x,x) = %8.3f, cov(y,y) = %8.3f and cov(x,y) = cov(y,x) = %8.3f\n';
fprintf(fid,formatSpec,i,GMM{k}.mu(i,1),GMM{k}.mu(i,2),GMM{k}.Sigma(1,1,i),GMM{k}.Sigma(2,2,i),GMM{k}.Sigma(1,2,i)) ;
end%for
fclose(fid)





% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
