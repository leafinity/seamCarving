clear all;

I = imread('test.jpg');
I2 = I;
w = size(I, 2); % width
h = size(I, 1); % height

%minus wigth
%new_width = w - 10;
%times = w - m;
times = 1;
Seams = zeros(w, h);
Pos = zeros(w, h);


%compute energe
map = gbvs(I2);
%show_imgnmap( I2 , map );
E = map.master_map_resized;

%open file
fid = fopen('energy_matrix.txt', 'a');

%print the width and height of energy matrix
fprintf(fid, '%d ', w);
fprintf(fid, '%d ', h);

%print the energy matrix
fprintf(fid, '%f ', E );

%close file
fclose(fid);