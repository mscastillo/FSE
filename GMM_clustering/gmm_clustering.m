

%% Workspace initialization
%  The workspace is cleaned and some parameters are predefined
clear all ;       % this removes all variables stored in your current workspace
close all force ; % this closes all previous figures
clc ;             % this clears the command window log
      
% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% (1) <K> This parameter is the maximum number of modes you want to try to
%     test in the GMM. This parameter could be any integer or any of the
%     next strings (to use a multiple of the number of classes): 'one', 
%     'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine' and
%     'ten'. Notice than text strings are defined between single quotes.
%     For example, to try to fit the the GMM with up to the double of the
%     number of classes use:
%     K = 'two' ; 
%     Opposite, if you want to try exactly fifteen:
%     K = 15 ;
%     I'd recommend to try twice than the number of known classes:
      K = 'two' ;
%
% (2) <seed> This parameter is the seed of the random-number generator. By
%     fixing it, we have controlled the randomness of the results and we 
%     could reproduce it at any moment. The seed could have any integer
%     value, but I would recommend to reset it always by ussing zero.
%     By default:
%     seed = 0 ;
      seed = 0 ;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
% RANDOM INITIALIZATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
  rng(seed) ;
%
% Despite <seed> can control the randomness of some functions, the GMM fit
% needs an additional setting to be able to reproduce the results everytime
% the script is executed.
% By default:
% RandStream.setGlobalStream( RandStream('mt19937ar','Seed',seed) ) ;
%
  RandStream.setGlobalStream( RandStream('mt19937ar','Seed',seed) ) ;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp( ['====================================='] ) ;
disp( ['= Gaussian Mixture Model clustering ='] ) ;
disp( ['====================================='] ) ; disp( char(10) ) ;


%% Loading and examinating the data
%  Data are read from an Excel or CSV file (genes at columns and samples at rows)
%  which must have the next structure:
%  - First column: the name of the class (cell-type, treatment, stage, etc)
%  - Second column: the name of the sample
%  - First row: a header with the name of the genes at each column. Notice
%  that the first two cells of the header corresponds to the sample's
%  class and samples's name.
   disp( [' - Loading data...'] ) ; disp( char(10) ) ;
   [input_file,input_path] = uigetfile( {'*.csv','Comma Sparated Values (*.csv)';'*.xls','Excel 97-2003 (*.xls)';'*.xlsx','Excel 2010 (*.xlsx)'},'Pick a file...','MultiSelect','off' ) ;
   file = strjoin({input_path,input_file},'') ;
   [ file_path,file_name,file_extension ] = fileparts( file ) ;
   if ( strcmp(file_extension,'.xlsx') || strcmp(file_extension,'.xls') )
     ds = dataset( 'XLSFile',file ) ;
   elseif ( strcmp(file_extension,'.csv') )
     ds = dataset( 'File',file,'Delimiter',',' ) ;
   else
     disp('File format not recognised. Please use an Excel or a CSV file.') ; break ;
   end%if
%  "data" is the matrix containing the 2D data transformation, with genes
%  as columns and samples as rows. 
   data = double( ds(:,3:4) ) ;
   N = size(data,1) ;
%  "samples_names" is a column-vector with the name of each sample at each
%  row of "data". They must be unique.
   samples_names = dataset2cell(ds(:,1)) ; samples_names(1) = [] ;
%  "classes_names" is the name of the class of each sample at each row of
%  "data". 
   classes_names = dataset2cell(ds(:,2)) ; classes_names(1) = [] ;
   unique_classes = unique( sort(classes_names) ) ;
   C = numel(unique_classes) ;
for k = 1:C
  classes_keys(strcmp(unique_classes(k),classes_names)) = k ;
end%for
   if ( ischar(K) )
       switch K
           case 'one' ; K = C ;
           case 'two' ; K = 2*C ;
           case 'three' ; K = 3*C ;
           case 'four' ; K = 4*C ;
           case 'five' ; K = 5*C ;
           case 'six' ; K = 6*C ;
           case 'seven' ; K = 7*C ;
           case 'eight' ; K = 8*C ;
           case 'nine' ; K = 9*C ;
           case 'ten' ; K = 10*C ;
       end%switch
   end%if
   if ( ~isnumeric(K) )
       disp('Numer of modes K is not correctly defined.') ; break ;
   end%if
%  Reporting the loaded worspace
   whos( 'data','samples_names','unique_classes' ) ;  
%  Generating plotting parameters
   colors = hsv( C ) ;
   colors_soft = hsv2rgb( rgb2hsv(colors).*[ones(C,1) 0.5*ones(C,1) ones(C,1)] ) ;
   markers = {'+' 'o' '*' 's' 'x' 'd' '.' 'v' 'p' 'h'}' ;
   for k=1:ceil( C/size(markers,1)-1 )
     markers = [ markers(:) ; markers(:) ] ;
   end%for
   markers=strjoin( [markers(1:C)]','') ;
   
   d = 0*( max(data(:,1)) - min(data(:,1)) ) ; x_min = ceil(min(data(:,1))-d) ; x_max = floor(max(data(:,1))+d) ;
   d = 0*( max(data(:,2)) - min(data(:,2)) ) ; y_min = ceil(min(data(:,2))-d) ; y_max = floor(max(data(:,2))+d) ;
   xnb = abs(x_max)+abs(x_min) ;
   ynb = abs(y_max)+abs(y_min) ;   
   
%% Gaussian Mixture Model estimation
   values=nlfilter((hist3(data,'Nbins',[xnb ynb])),[max([1 round(xnb/20)]) max([1 round(ynb/20)])],@(x)mean(x(:))) ;   
   options = statset('MaxIter',C*100); k_optimum = [] ;
   for k = 1:K
%  GMM fit
   GMM{k} = gmdistribution.fit( data,k,'Options',options ) ;
%   if( k==C ) ;
%       GMM{k} = gmdistribution.fit( data,k,'Options',options,'Start',classes_keys(:) ) ;
%   end
   AIC(k)=GMM{k}.AIC ;
   if ( k > 1 )
       abserror(k-1)=abs(AIC(k)-AIC(k-1))/mean(AIC(k-1:k)) ;
   end
   mu{k}=GMM{k}.mu ;
   Sigma{k}=GMM{k}.Sigma ;
   
%  Plotting results
   figure(1) ; set(1,'WindowStyle','docked','Name',['GMM with ',num2str(k),' modes'],'NumberTitle','off') ; colormap(hot) ;
   hold on ; 
   subplot(3,2,[1 2]) ; cla
   hold on
     plot(1:k,AIC(1:k),'b.-') ;
     if ( k > 1 )
        [~,k_optimum] = min( abs( 0.5*diff(AIC)./(AIC(1:end-1)+AIC(2:end)) ) ) ; k_optimum = k_optimum+1 ;
         k_first=find( abserror < 1e-3,1,'first' ) ; k_last=find( abserror < 1e-3,1,'last' ) ;
         
         if( numel(find( abserror < 1e-3 )) == k_last-k_first ) ; k_optimum = [ k_optimum ; k ] ; end%if ;
         if(~isempty(k_optimum))
           plot([1 K],AIC(min(k_optimum(:)))*[1 1],'r--') ; plot( min(k_optimum(:)),min(get(gca,'YLim')),'r^' ) ;
           legend({'AIC';'trend';'optimum'},'Location','NE','EdgeColor',[1 1 1]) ;
         end%if
     else
         legend({'AIC'},'Location','NE','EdgeColor',[1 1 1]) ;
     end%if
     ckh=plot( k*[1 1],[min(get(gca,'YLim')) max(get(gca,'YLim'))],'g^:' ) ; set(ckh,'Visible','off') 
     grid on ;
     xlim([1 K]) ;
     title('AIC versus the number of modes in the GMM.') ;
   hold off ; drawnow ;
   subplot(3,2,[3 5]) ; cla ;
   hold on
%     legend( gscatter_handle ) ; legend( 'boxoff' ) ;
     imagesc(x_min:x_max,y_min:y_max,values') ;
%     gscatter_handle = gscatter( data(:,1),data(:,2),classes_names,colors,markers ) ; 
%     gscatter_handle = scatter( data(:,1),data(:,2),'w.' ) ;
     GMM2h = ezcontour( @(x1,x2)pdf(GMM{k},[x1 x2]),cell2mat(get(gca,{'XLim','YLim'})),500 ) ;
     Z2{k} = get(GMM2h,'Zdata') ;
     GMMmuh = plot(mu{k}(:,1),mu{k}(:,2),'ko','MarkerSize',6,'MarkerEdgeColor','k','MarkerFaceColor','w') ;
     xlim( [x_min x_max] ) ;
     ylim( [y_min y_max] ) ;
     title( ['Data density and GMM clustering'] ) ;
     xlabel( ds.Properties.VarNames(3) ) ;
     ylabel( ds.Properties.VarNames(4) ) ;
     grid on ; drawnow ;
   hold off ;
   subplot(3,2,[4 6]) ; cla ;
   hold on
%    gscatter_handle = gscatter( data(:,1),data(:,2),classes_names,colors,markers ) ;
     GMM3h = ezmeshc( @(x1,x2)pdf(GMM{k},[x1 x2]),cell2mat(get(gca,{'XLim','YLim'})),50 ) ; legend off ;
     xlim( [x_min x_max] ) ;
     ylim( [y_min y_max] ) ;
     zlim( [-1 +1]*max(cell2mat(get(gca,{'ZLim'}))) ) ;
     zticks=get(gca,'ZTick') ; zticks(find(get(gca,'ZTick')<0)) = [] ; set(gca,'ZTick',zticks) ;
     xlabel( ds.Properties.VarNames(3) ) ;
     ylabel( ds.Properties.VarNames(4) ) ;
     zlabel( 'score' ) ;
     title(['GMM clustering']) ; view(-45,60-K+k)
     grid on ;
   hold off ; drawnow ;
   
   end%for
   
   x_label = ds.Properties.VarNames(3) ;
   y_label = ds.Properties.VarNames(4) ;
   GMM_axis = cell2mat(get(gca,{'XLim','YLim'})) ;
   save( 'GMM_results.mat','data','file','classes_names','GMM','mu','GMM_axis','values','x_label','y_label' ) ;
   gui() ;