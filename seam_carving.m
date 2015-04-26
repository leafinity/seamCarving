clear all;

I = imread('test.jpg');
I2 = I;
n = size(I, 2); % width
m = size(I, 1); % height

%minus wigth
new_width = n - 10;
times = n - new_width;
Seams = zeros(m, n);

for t = 1:times
	%compute energe
    map = gbvs(I2);
    %show_imgnmap( I2 , map );
    E = map.master_map_resized;
	%compute seams
	for j = 1:m %height
		for i = 1:n %width
			if j == 1
				Seams(j, i) = E(j, i);
			else 
				%get the currnet end point of seams
				if j == 2
					cur = i;
				else
					cur = Seams(j - 1, i);
				end
				%find minimum cost
				%try center
				next = cur;
				cost = E(j, next);
				%try left
				if cur - 1 > 1
					if E(j, cur - 1) < cost
						next = cur - 1;
						cost = E(j, next);
					end
				end
				%try right
				if i + 1  <= n 
					if E(j, cur + 1) < cost
						next = cur + 1;
						cost = E(j, next);
					end
				end

				%update seams
				Seams(1, i) = Seams(1, i) + cost;
				Seams(j, i) = next;
			end
		end
	end

	%find the smallest seam
	for i = 1:n 
		if i == 1
			sm = i;
			sm_value = Seams(1, i);
		else
			if Seams(1, i) < sm_value
				sm = i;
				sm_value = Seams(1, i);
			end
		end
	end

	%delete smallest seams
	for j = 1:m %height
		%shift cells
		for i = 1:n %width
			if (i > Seams(j, sm)) && (i <= n - 1)
				I2(j, i, :) = I2(j, i + 1, :);
			end
		end
	end
	%delete last culomn
	I2(:,n,:) = [];
	n = n - 1;
end

%dispaly images
subplot(1,2,1);
image(I);
subplot(1,2,2);
image(I2);

%result
imwrite(I2, result.jpg);

