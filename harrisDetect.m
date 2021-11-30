
function  [im, im_orig, features_E_NonM] = harrisDetect( filter_size, file_name, pathname )

%% parameters, read image and preproces
k = 0.04;
window_size = 11;
nbpoints = 81;
fileLocation = strcat(pathname,file_name);
im = imread(fileLocation);
im_orig = im;

if size(im,3)>1
    im=rgb2gray(im);
end

%% Horizontal slope
dx = [-1 0 1;
      -1 0 1;
      -1 0 1];
Ix = conv2(double(im), dx, 'same');

%% Vertical slope
dy = dx';
Iy = conv2(double(im), dy, 'same');
%% image derivatives
sigma = 2;

%% Gaussian kernel with variable scales
g = fspecial('gaussian',filter_size, sigma); % Filter Scale Size

%% apply kernel
Ix2 = conv2(Ix.^2, g, 'same');
Iy2 = conv2(Iy.^2, g, 'same');
Ixy = conv2(Ix.*Iy, g, 'same');

%% --------------------GET FEATURES ------------------------------------------------------------------
mask = 1/9*[1 1 1 ;1 1 1 ;1 1 1];
Ix2_c = conv2(Ix2, mask, 'same');
Iy2_c = conv2(Iy2, mask, 'same');
Ixy_c = conv2(Ixy, mask, 'same');
[i_height, i_width] = size(im);
E = zeros( i_height, i_width);
%% Compute M
for i = 1:i_height
    for j = 1:i_width
        M = [Ix2_c(i,j) Ixy_c(i,j); Ixy_c(i,j) Iy2_c(i,j)];
        eig_v = min(eig(M));
        E(i,j) = eig_v;
    end
end
%% Compute Mc
Mc = (Ix2_c.* Iy2_c+ Ixy_c.*Ixy_c) - k*(Ix2_c +Iy2_c).^2;


%% ---------------APPLY Non Max suppression & get detected points coordinates----------------
features_E_Max = struct('p_x', zeros(nbpoints,1), 'p_y', zeros(nbpoints, 1));
[~, index_E] = sort( E(:), 'descend');
[row_E,col_E] = ind2sub(size(E), index_E);

for i = 1: nbpoints
    features_E_Max(i).p_y = row_E(i);
    features_E_Max(i).p_x = col_E(i);
end

%% Non-maximum supression
features_E_NonM = struct('p_x', zeros(nbpoints, 1), 'p_y', zeros(nbpoints, 1));
wsize_2 = floor(window_size/2);
E_pad = padarray(E,[wsize_2,wsize_2]);
count = 1;

while(count<nbpoints)
    for i= 1:size(row_E)
        if( E_pad(row_E(i),col_E(i)) ~= 0 )
            E_pad(row_E(i)-wsize_2 : row_E(i)+wsize_2, col_E(i)-wsize_2:col_E(i)+wsize_2) = 0;
            features_E_NonM(count).p_y = row_E(i);
            features_E_NonM(count).p_x = col_E(i);
            count = count + 1;
        end
        if count == 82
            break;
        end
    end
end
end
