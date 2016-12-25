import random


def get_test_label_vector():
    test_label_vector_str = '['
    for i in range(0, 3):
        for num in range(0, 20):
            test_label_vector_str += ('double(' + str(i + 1) + '); ')
    return test_label_vector_str + ']'


print(get_test_label_vector())


def get_test_instance_matrix():
    test_instance_matrix_str = '['
    for i in range(0, 3):
        if i == 0:
            for num in range(0, 20):
                test_instance_matrix_str += (
                    '' + str(4 + random.uniform(-1, 1)) + ', ' + str(4 + random.uniform(-1, 1)) + ', ' + str(
                        4 + random.uniform(-1, 1)) + '; ')
        elif i == 1:
            for num in range(0, 20):
                test_instance_matrix_str += (
                    '' + str(-4 + random.uniform(-1, 1)) + ', ' + str(4 + random.uniform(-1, 1)) + ', ' + str(
                        4 + random.uniform(-1, 1)) + ';')
        else:
            for num in range(0, 20):
                test_instance_matrix_str += (
                    '' + str(4 + random.uniform(-1, 1)) + ', ' + str(-4 + random.uniform(-1, 1)) + ', ' + str(
                        4 + random.uniform(-1, 1)) + ';')
    return test_instance_matrix_str + ']'


print(get_test_instance_matrix())
