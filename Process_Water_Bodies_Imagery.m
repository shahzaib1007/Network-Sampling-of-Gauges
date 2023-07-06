close all;  % Close all figures (except those of imtool.)
clearvars;  % Erase all existing variables. Or clearvars if you want.
format long g;
format compact;
fontSize = 13;

fn = 'Path to SAR S1 captured Imagery\BD_Quad_NE_BD2022-06-25.tif'; 
BW =imread(fn); str='operational system testing';
%% Processing
BW =logical(BW);
% BW=imbinarize(BW);
% se1 = strel('disk',5);
% BW1=imerode(BW,se1);
se2 = strel('disk',10);
binaryImage=imopen(BW,se2);
% binaryImage=imerode(binaryImage,se1);
% 

% im_1b = bwareaopen(BW,50); %remove less than 5 connected components
% im_1c = imerode(im_1b,strel('disk',10)); %erode with disk of radius 1
% im_1d = imclose(im_1c,strel('disk',10)); %dilate with disk of radius 1
% binaryImage=im_1d;
figure,subplot(1,2,1)
imshow(BW)
title(['Binary image'],'FontSize', fontSize, 'Interpreter', 'None')
% subplot(1,2,2)
% imshow(binaryImage)
% title('Erosion + Dilation','FontSize', fontSize, 'Interpreter', 'None')
%%
% CC = bwconncomp(BWco);
% L = labelmatrix(CC);
% imshow(label2rgb(L,'jet','w','shuffle'));
% %%
% stats = regionprops(CC,'Area','Circularity');
% statsL = regionprops(L,'Area','Circularity');
% circ = [stats.Circularity];
% keeperInd = find(circ < 2 & circ>0.5);
% 
% imshow(label2rgb(L==keeperInd,'jet','w','shuffle'));
% 
% %% 
% BW2 = bwpropfilt(BW,'Circularity',[0.1 1.3]);

%%
% Display the image.
figure
subplot(1, 2, 1);
imshow(binaryImage, []);
title('Erosion + Dilation', 'FontSize', fontSize, 'Interpreter', 'None');
% axis on;
% Fill holes

binaryImage = bwconncomp(binaryImage);
% Display the image.
L = labelmatrix(binaryImage);
% subplot(1, 2, 2);
% imshow(label2rgb(L,'jet','k','shuffle'));
% title(['Connected components'], 'FontSize', fontSize, 'Interpreter', 'None');
% axis on;
% Let's measure things to see what we're starting with.
props = regionprops(binaryImage, 'Solidity', 'Area','perimeter', 'Eccentricity','Circularity');
allAreas = [props.Area];
allSolidities = [props.Solidity];
allEccentricity=[props.Eccentricity];
allCircularities = 4 * pi * allAreas ./ [props.Perimeter] .^ 2;
% Display the histograms.
% subplot(2, 2, 3);
% histogram(allAreas);
% grid on;
% title('Histogram of Areas', 'FontSize', fontSize, 'Interpreter', 'None');
% subplot(2, 2, 4);
% histogram(allCircularities);
% grid on;
% title('Histogram of circularities', 'FontSize', fontSize, 'Interpreter', 'None');

%% Get rid of blobs with low circularity.
highCircularityIndexes = find( allAreas>=2e5 & allAreas<2e7 & allEccentricity < 0.925 ... %
                             | allAreas>=2e7 ... %  for merged biggest body
                             | allAreas>2000 & allAreas<2e5 & allCircularities>0.11 & allEccentricity < 0.95 );  %1 pixel area=100sq.m, here >0.2 sq km
% highCircularityIndexes = find( allAreas>=200000 ... & allEccentricity < 0.925 ... % Planet: No use of ecc for Planet
%                              | allAreas>2000 & allAreas<200000 & allCircularities>0.08 );
% highCircularityIndexes = find(allCircularities > 0.00   & allAreas>2000 & allEccentricity < 1);  %1 pixel area=100sq.m, here >0.2 sq km

% labeledImage = bwlabel(binaryImage);
binaryImage3 = ismember(L, highCircularityIndexes);
binaryImage3 = imfill(binaryImage3, 'holes');

CC = bwconncomp(binaryImage3);
LC = labelmatrix(CC);
stats = regionprops(CC,'Area','Circularity');
CC.NumObjects
% save('NE_stats_area.csv',stats.Area)
% S = sum(stats.Area)
% S
% writematrix(stats.Area,'NE_stats_area.csv')
T =table(stats.Area)
writetable(T,'Path to SAR S1 captured Imagery\Water_Area_Table_Matlab_Processed.csv')
% subplot(1,3,3),
figure,imshow(label2rgb(LC,'jet','k','shuffle')); %'jet',[181, 181, 181]./255));
title(['Water Bodies'] ,'FontSize', fontSize, 'Interpreter', 'None');

% write to tiff
% %%imwrite( binaryImage3, ['bd_processed_haors/haors_' fn])
% geotiffwrite(['outg' fn '.tif'],binaryImage3,geotiffinfo(fn).SpatialRef)

% areas
% x=[stats.Area].*1e-4;  % in sq km.
% xt=x';
