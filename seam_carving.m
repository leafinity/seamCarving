clear all;

I = imread('test.jpg');
I2 = I;
w = size(I, 2); % width
h = size(I, 1); % height

%minus wigth
%new_width = w - 10;
%times = w - m;
times = 1;
Seams = zeros(m, n);
pos = zeros(m, n);


%compute energe
map = gbvs(I2);
%show_imgnmap( I2 , map );
E = map.master_map_resized;

for t = 1:times
	%compute seams
	for j = 1:h %height
		for i = 1:w %width
			if j == 1 %first row
			end
		end
	end

	%find the smallest seam
	for i = 1:w 
		if i == 1
			sm = i;
			sm_value = Seams(h, i);
		else
			if Seams(1, i) < sm_value
				sm = i;
				sm_value = Seams(1, i);
			end
		end
	end
	%{

	%delete smallest seams
	for j = 1:h %height
		%shift cells
		for i = 1:w %width
			if (i > Seams(j, sm)) && (i <= w - 1)
				I2(j, i, :) = I2(j, i + 1, :);
			end
		end
	end
	%delete last culomn
	I2(:,n,:) = [];
	w = w - 1;

	%}
end

%dispaly images
subplot(1,2,1);
image(I);
subplot(1,2,2);
image(I2);

%result
imwrite(I2, 'result.jpg');

