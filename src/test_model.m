function correct_rate = test_model(models, test_sets)
    kinds = length(models);
    correct_rate = zeros(kinds, 1);

    for k_test_set = 1:kinds
        disp([num2str(k_test_set) '/' num2str(length(test_sets))]);

        test_set = test_sets(k_test_set);
        correct = 0;

        if length(test_set.imgs)
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
