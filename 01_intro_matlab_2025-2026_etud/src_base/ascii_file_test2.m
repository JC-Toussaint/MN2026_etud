clc
clear all

fid = fopen('data', 'w');

x = 0:.1:2*pi;
fprintf(fid, '   x         y\n');
fprintf(fid, '%5.2f %10.4f\n', [x ; sin(x)]);
fclose(fid);


fid = fopen('data', 'r');

tline = fgets(fid)
[T, count] = fscanf(fid, '%f %f', [2 Inf]);

x=T(1, :);
y=T(2, :);
plot(x, y)
fclose(fid);

