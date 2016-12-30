train_label_vector = [double(1); double(2); double(1)];
instance_one_pos = [4, 0];
instance_one_label = 1;

instance_two_pos = [0, 4];
instance_two_label = 2;

instance_three_pos = [4.2, 0.2];
instance_three_label = 1;
train_instance_matrix = [instance_one_pos, instance_one_label;
    instance_two_pos, instance_one_label;
    instance_three_pos, instance_one_label];

% get train model
model = svmtrain(train_label_vector, train_instance_matrix);
% predict_label = svmpredict()