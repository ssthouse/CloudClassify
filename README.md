#模式识别课设

##组员:
陈高杰, 李翰宇, 沈顺天

##最终结果综述:

* 训练样本: 24 * 6
* 测试样本: 8 * 6
* 识别率: 68.75% (33/48)

##工程文件结构:
main.m ===> GUI 主结构, 直接运行即可, 点击 EDTECT 按钮, 识别结果将输出在控制台.
./test ===> 测试图片文件夹
./train ===> 训练图片文件夹
./vl-feat-0.9.19 ===> vlfeat 库文件
all_pic.mat & all_test.mat ===> 存放所有图片数据, 方便调取
M_sum.mat & M_sum_test.mat ===> 存放所有图片纹理矩阵数据, 方便调取
color_matrix_test.mat & color_matrix_train.mat ===> 存放所有图片矩阵数据, 方便调取

