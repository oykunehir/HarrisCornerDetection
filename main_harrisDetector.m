
%% -----------main to call harrisDetect function and Plot results according to scale--------------
%% inout the image
[file_name, pathname] = uigetfile('*.*','Select path of image file');
%% get features points
[im, im_orig, features_E_NonM1] = harrisDetect( 3, file_name, pathname);
[im, im_orig, features_E_NonM2] = harrisDetect( 5, file_name, pathname);
[im, im_orig, features_E_NonM3] = harrisDetect( 7, file_name, pathname);

%% plot
fig = figure(1)
lineWidth = 2;
set(fig ,'Name', 'Corner Detection' );
subplot(2,2,1); imshow(im, []); title('input image');
hold on
%% plot1
subplot(2,2,2); imshow(im_orig,[]); title('Corner detection applying Scale 1');
hold on;
for i = 1: size(features_E_NonM1, 2)
   plot(features_E_NonM1(i).p_x, features_E_NonM1(i).p_y,  'r+', LineWidth = lineWidth);
   hold on
end
hold on
%% plot2
subplot(2,2,3); imshow(im_orig,[]); title('Corner detection applying Scale 2');
hold on;
for i = 1: size(features_E_NonM2, 2)
   plot(features_E_NonM2(i).p_x, features_E_NonM2(i).p_y, 'r+', LineWidth = lineWidth);
   hold on
end
hold on
%% plot3
subplot(2,2,4); imshow(im_orig,[]); title('Corner detection applying Scale 3');
hold on;
for i = 1: size(features_E_NonM3, 2)
   plot(features_E_NonM3(i).p_x, features_E_NonM3(i).p_y,  'r+', LineWidth = lineWidth);
   hold on
end
hold on
