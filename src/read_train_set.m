function train_set = read_train_set(directory)
    train_set = [];
    content = dir(directory);

    for k = 1:length(content)
        subdir = content(k);
        if subdir.isdir && subdir.name(1) ~= '.'
            train_set = [train_set; struct('name', subdir.name)];
        end
    end

    for k = 1:length(train_set)
        name = train_set(k).name;
        subdir_path = [directory '/' name '/'];
        imgs = dir([subdir_path '*.png']);

        for m = 1:length(imgs)
            train_set(k).imgs{m} = [subdir_path imgs(m).name];
        end
    end
end
