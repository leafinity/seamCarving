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

for t = 1:times
	%compute seams
	for j = 1:h %height
		for i = 1:w %width
			if j == 1 %first row
				Seams(1, i) == E(1, i);
			else
				%choose smallest front pos
				min_pos = i;
				min_value = Seams(j - 1, i);

				if (i - 1 >= 1) && (Seams(j - 1, i - 1) < min_value)
					min_pos = i - 1;
					min_value = Seams(j - 1, i - 1);
				end

				if (i + 1 <= w) && (Seams(j - 1, i + 1) < min_value)
					min_pos = i + 1;
					min_value = Seams(j - 1, i + 1);
				end

				%save last pos and update current cost
				Pos(j, i) = min_pos;
				Seams(j, i) = Seams(j - 1, i) + min_value;
			end
		end
	end

	%find the smallest seam
	for i = 1:w 
		if i == 1
			sm = i;
			sm_value = Seams(h, i);
		else
			if Seams(h, i) < sm_value
				sm = i;
				sm_value = Seams(h, i);
			end
		end
	end

	%{
	%draw seam
	i = sm;
	for j = h:-1:1
		I2(j, i, :) = 0;
		i = Pos(j, i);
	end
	%}



	%delete smallest seams
	%shift 
	i = sm;
	for j = h:-1:1
		for k = i:(w - 1)
			I2(j, k, :) = I2(j, k + 1, :);
		end
		i = Pos(j, i);
	end

	%delete last culomn
	I2(:,w,:) = [];
	w = w - 1;

end

%dispaly images
subplot(1,2,1);
image(I);
subplot(1,2,2);
image(I2);

%result
imwrite(I2, 'result.jpg');
