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
	E_ori = map.master_map;
    E = mat2gray(imresize( map , [ m, n ] ));
	%compute seams
	for j = 1:m %height
		for i = 1:n %width
			if j == 1
				Seams(i, 1) = E(i, j);
			else 
				%get the currnet end point of seams
				if j == 2
					cur = i;
				else
					cur = Seams(i, j - 1);
				end
				%find minimum cost
				%try center
				next = cur;
				cost = E(next, j);
				%try left
				if cur - 1 > 1
					if E(cur - 1, j) < cost
						next = cur - 1;
						cost = E(next, j);
					end
				end
				%try right
				if i + 1  <= n 
					if E(cur + 1, j) < cost
						next = cur + 1;
						cost = E(next, j);
					end
				end

				%update seams
				Seams(i, 1) = Seams(i, 1) + cost;
				Seams(i, j) = cost;
			end
		end
	end

	%find the smallest seam
	for i = 1:n 
		if i == 1
			sm = i;
			sm_value = Seams(i, 1);
		else
			if Seams(i, 1) < sm_value
				sm = i;
				sm_value = Seams(i, 1);
			end
		end
	end

	%delete smallest seams
	for j = 1:m %height
		%shift cells
		for i = 1:n %width
			if (i > Seams(sm, j)) && (i <= n - 1)
				I2(i, j) = I2(i + 1, j);
			end
		end
	end
	%delete last culomn
	I2(:,n) = [];
	n = n - 1;
end

%dispaly images
subplot(1,2,1);
image(I);
subplot(1,2,2);
image(I2);

%result
imwrite(I2, result.jpg);

