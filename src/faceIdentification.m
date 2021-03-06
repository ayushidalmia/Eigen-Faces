%This function returns the average accuracy for the Yale and CMU PIE
%Dataset. The accuracy is calculated using four fold vaidation scheme where 
% 75% of the data is taken as trianing and 25% as testing. The function 
%takes as input the number of eigen vector to use, the number of nearest
%neighbour to take if doing KNN, the number of classes present, the method
%used 'knn' or 'svm', the Image Matrix, and the Label Matrix.

function [averageAccuracy] = faceIdentification(kEigen,kKNN, numberOfSubjects, method,ImageMatrix,LabelMatrix)
 
 accuracy=zeros(4,1);                                                       %initialisation
 correct=zeros(4,1);
 
 for i=1:4
    [TrainImage, TestImage , TrainLabel, TestLabel] = fourFold(i,numberOfSubjects,ImageMatrix,LabelMatrix); %four fold validation
    correct(i)=0;
    numberOfTestImages=size(TestImage,2);
    [eigenVectors,eigenValues,meanImage] = findEigenVector ( TrainImage );                  %find eigen vectors
    [topEigenVectors] = findTopEigen( eigenVectors,eigenValues,kEigen);                     %find top eigen vectors
    [ weightVectorTrain ] = trainImageWeights( TrainImage,topEigenVectors,meanImage );      %find eigen face for training images
    if (strcmp(method,'knn'))
        
        for index=1:numberOfTestImages
            %imshow(reshape(TestImage(:,index),100,100),[0 255])
            weightVectorTest =findWeightVector( TestImage(:,index),topEigenVectors,meanImage ); %find eigen face foe test image
            [predictedLabel] = knn( weightVectorTrain, weightVectorTest,TrainLabel,kEigen,kKNN);   %predict label using knn
            testLabel=TestLabel(index);     
            if(testLabel==predictedLabel)                                                        %check label
                correct(i)=correct(i)+1;
            end
        end
        accuracySubset = (correct(i)/numberOfTestImages)*100;                                         %find accuracy         
    else
       [ weightVectorTest ] = trainImageWeights( TestImage,topEigenVectors,meanImage ); 
       model = svmtrain(TrainLabel,weightVectorTrain','-t 0 -q');                                           %model using svm
       [~, accuracySVM, ~] = svmpredict(TestLabel, weightVectorTest', model,'-q');                 %predict using svm
       accuracySubset=accuracySVM(1);                                                           %find accuracy
    end
    accuracy(i)= accuracySubset;
    disp(accuracy);
 end
 averageAccuracy=mean(accuracy);
end