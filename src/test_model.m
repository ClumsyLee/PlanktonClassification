function correct_rate = test_model(models, test_sets)
    kinds = length(models);
    correct_rate = zeros(kinds, 1);

    total_imgs = 0;
    for k = 1:length(test_sets)
        total_imgs = total_imgs + length(test_sets(k).imgs);
    end

    imgs_now = 0;
    for k_test_set = 1:kinds
        disp([num2str(imgs_now) '/' num2str(total_imgs)]);

        test_set = test_sets(k_test_set);
        imgs_now = imgs_now + length(test_set.imgs);
        correct = 0;

        if ~isempty(test_set.imgs)
            for k_img = 1:length(test_set.imgs)
                img = imread(test_set.imgs{k_img});
                if strcmp(classify_img(img, models), test_set.name)
                    correct = correct + 1;
                end
            end
            correct_rate(k_test_set) = correct / length(test_set.imgs);
        else
            correct_rate(k_test_set) = 0;  % No images.
        end
    end
end
