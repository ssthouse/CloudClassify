
% train the model
test_vector_label = [double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(1); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(2); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); double(3); ];
test_instance_matrix = [3.52699645637, 4.5336908561, 4.10758990298; 3.88211520317, 4.18479345477, 3.75455676675; 4.20635176005, 4.38759356435, 3.32408888182; 3.02473125238, 3.0924575097, 3.71333958057; 3.5383227046, 4.69476905078, 4.36405769568; 4.03851681415, 3.01066083472, 4.22401221849; 3.27932827286, 4.60341414405, 3.42761547674; 3.09800432792, 4.43959619978, 3.15267919596; 3.72253981631, 3.28389474151, 4.20651866231; 3.39509844414, 4.62806252659, 4.66010253322; 4.37392447235, 3.19432341677, 3.66810102786; 4.69560283237, 3.568309292, 3.08478186648; 4.98037680679, 3.45527638801, 3.08855727179; 3.45274414307, 4.8096404208, 4.5081312587; 3.35045206856, 3.92097751336, 3.12296964962; 4.98500604899, 4.40706082798, 3.35844812475; 3.91600261079, 3.20317292571, 3.00587681908; 3.80020420366, 4.31775874575, 3.00707025062; 3.69012149373, 3.20224777898, 3.4270551858; 3.48338806414, 4.53016215389, 4.95643822329; -4.51441253501, 4.01367566519, 3.34727674182;-4.97210461933, 4.07106271219, 4.17879635739;-4.59820634388, 4.40086024437, 4.37041642301;-4.56735458277, 3.16015051382, 4.922838598;-4.29343445998, 4.55797180455, 3.63904336552;-3.74981827915, 4.82480242069, 3.07628129147;-3.16863490382, 4.25141149413, 4.23059928972;-4.36378199702, 3.41203001774, 3.48364858188;-4.7894928275, 3.19916537677, 3.94924583727;-4.8396522886, 4.90704980922, 3.22112332577;-3.13790966811, 3.95765989922, 3.15327720607;-3.89227249172, 3.50179036031, 4.25731663033;-3.50343715784, 3.92956919862, 3.93496594191;-4.52217758507, 4.66308223043, 3.70674623867;-3.9508600613, 3.45946969632, 3.25756054075;-3.71688789381, 4.2950226004, 3.23265015601;-4.4914408806, 4.76535401898, 3.75910756352;-4.99733680176, 3.58374950442, 4.40659974728;-4.53382087448, 4.46900867884, 4.15022115569;-4.94852740923, 3.9860103059, 4.58626656665;4.90540824776, -4.99275407052, 4.55672272253;3.04433672703, -4.77214288702, 4.47708117832;3.01194714842, -3.6303319896, 3.06460317833;3.20979179066, -3.01474444572, 4.65770117458;3.0215579098, -4.05727561013, 3.25381827607;4.86098887135, -3.45880551491, 4.89630731519;4.6407227235, -3.04014226593, 4.28265100328;4.75068268263, -4.83293060137, 3.91938909655;4.47243962498, -4.96547904352, 3.19539349286;4.60470255721, -4.40536300148, 3.56007551207;4.22530518503, -4.77418608923, 3.24622554344;3.07821555236, -4.09746901727, 3.30861229108;3.27310572941, -3.71274732465, 3.10344002301;4.98260586132, -4.30138207319, 3.51646418262;4.92185581092, -4.11143188397, 3.26298440592;4.53386221858, -4.3165005923, 3.20531559112;3.78855598315, -3.5483992095, 3.72557563114;3.06763582122, -4.52688020503, 3.71161761824;3.21485893936, -3.32791680508, 4.42245045389;4.67646927371, -3.91294126907, 3.74322466335;];
model = svmtrain(test_vector_label, test_instance_matrix)
%test the result
predict_label_vector = [double(1); double(2); double(3)];
predict_instance_matrix = [5, 5, 5; -5, 5, 5; 5, -5, 5];
result_label_vector = svmpredict(predict_label_vector, predict_instance_matrix, model);
