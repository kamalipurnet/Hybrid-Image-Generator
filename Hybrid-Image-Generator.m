
image1 = imread('Mona_Lisa.jpg');
image2 = imread('mrb.jpg');

min_size = min(size(image1, 1:2), size(image2, 1:2));
image1_resized = imresize(image1, [min_size(1), min_size(2)]);
image2_resized = imresize(image2, [min_size(1), min_size(2)]);

if size(image1_resized, 3) == 3
    image1_resized = rgb2gray(image1_resized);
end
if size(image2_resized, 3) == 3
    image2_resized = rgb2gray(image2_resized);
end

sigma1 = 4; 
filter_size = 2 * round(3 * sigma1) + 1; 
low_pass_filter = fspecial('gaussian', filter_size, sigma1);
low_frequencies = imfilter(image1_resized, low_pass_filter);

high_frequencies = image2_resized - imfilter(image2_resized, low_pass_filter);

hybrid_image = low_frequencies + high_frequencies;

scale_factor = 0.25;
hybrid_image_small = imresize(hybrid_image, scale_factor);

figure;
subplot(1, 3, 1);
imshow(image1);
title('Original Image 1');

subplot(1, 3, 2);
imshow(image2);
title('Original Image 2');

subplot(1, 3, 3);
imshow(hybrid_image);
title('Hybrid Image');

figure;
imshow(hybrid_image);
title('Hybrid Image (Large Scale)');

figure;
imshow(hybrid_image_small);
title('Hybrid Image (Small Scale)');

imwrite(hybrid_image, 'hybrid_image_large.jpg');
imwrite(hybrid_image_small, 'hybrid_image_small.jpg');
