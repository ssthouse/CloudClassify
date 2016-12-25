# the three class are in (-4, 0)  (0, 4)  (4, 0)
import random


# get train labels vector str
def get_train_labels_str():
    train_labels_str = '['
    for i in range(0, 60):
        if i < 20:
            train_labels_str += ('double(' + '1); ')
        elif i < 40:
            train_labels_str += ('double(' + '2); ')
        else:
            train_labels_str += ('double(' + '3); ')
    return train_labels_str + ']'


print(get_train_labels_str())


def get_one_vector_str(vector):
    vector_str = ''
    for bean in vector:
        vector_str += ('' + str(bean[0]) + ', ' + str(bean[1]) + '; ')
    return vector_str


def get_train_instance_matrix():
    train_instance_matrix = '['

    train_vector_class_one = []
    train_vector_class_two = []
    train_vector_class_three = []
    for i in range(0, 20):
        train_vector_class_one.append((-4 + random.uniform(-1, 1), 0 + random.uniform(-1, 1)))
        train_vector_class_two.append((0 + random.uniform(-1, 1), 4 + random.uniform(-1, 1)))
        train_vector_class_three.append((4 + random.uniform(-1, 1), 0 + random.uniform(-1, 1)))
    train_vector_list = [train_vector_class_one, train_vector_class_two, train_vector_class_three]
    for vector in train_vector_list:
        train_instance_matrix += get_one_vector_str(vector)
    return train_instance_matrix + ']'


print(get_train_instance_matrix())
