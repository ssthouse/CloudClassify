import random

# test random
trainning_vector_instance_label1 = [];
trainning_vector_instance_label2 = [];

for i in range(0, 20):
    trainning_vector_instance_label1.append((1 + random.uniform(-1, 1), 4 + random.uniform(-1, 1)))
    trainning_vector_instance_label2.append((4 + random.uniform(-1, 1), 1 + random.uniform(-1, 1)))


# for i in trainning_vector_instance_label1:
#     print(i)
#
# for i in trainning_vector_instance_label2:
#     print(i)


def get_matlab_label_vector():
    result_str = '['
    for i in range(0, 20):
        result_str += 'double(1); '
    for i in range(0, 20):
        result_str += 'double(2); '
    return result_str + ']'


print(get_matlab_label_vector())


def get_matlab_instance_matrix():
    result_str = '['
    for i in trainning_vector_instance_label1:
        result_str += ('' + str(i[0]) + ', ' + str(i[1]) + '; ')
    for i in trainning_vector_instance_label2:
        result_str += ('' + str(i[0]) + ', ' + str(i[1]) + '; ')
    result_str += ']'
    return result_str


print(get_matlab_instance_matrix())
