%This function returns the average accuracy for the SMAI Attendance
%Dataset. The accuracy is calculated using hold one out scheme for each
%class. The function takes as input the number of eigen vector to use, the
%number of nearest neighbour to take if doing KNN, the number of classes
%present, the method used 'knn' or 'svm', the Image Matrix, the Label
%Matrix and the number of Images in each class

function [averageAccuracy] = faceIdentificationAttendance(kEigen,kKNN, method,ImageMatrix,LabelMatrix)
 
 numberOfImages=size(ImageMatrix,2);
 accuracy=zeros(numberOfImages,1);                                        %initialisation
 correct=zeros(numberOfImages,1);
 
 for i=1:numberOfImages
    [ TrainImage, TestImage , TrainLabel, TestLabel ] = holdOneOut( ImageMatrix, LabelMatrix,i); %hold one out
    correct(i)=0;
    numberOfTestImages=size(TestImage,2);
    
    [eigenVectors,eigenValues,meanImage] = findEigenVector ( TrainImage );                  %find Eigen Vectors
        [topEigenVectors] = findTopEigen( eigenVectors,eigenValues,kEigen);                     %find top Eigen Vectors
        [ weightVectorTrain ] = trainImageWeights( TrainImage,topEigenVectors,meanImage );      %find Eigen Face for the Training data
    
    if (strcmp(method,'knn'))                               
        
               
        for index=1:numberOfTestImages
            weightVectorTest =findWeightVector( TestImage(:,index),topEigenVectors,meanImage ); %Eigen Face for Test data
            [predictedLabel] = knn( weightVectorTrain, weightVectorTest,TrainLabel,kEigen,kKNN);%predict label
            testLabel=TestLabel(index);
            if(testLabel==predictedLabel)                                                       %check label
                correct(i)=correct(i)+1;                
            end
        end
        accuracySubset = (correct(i)/numberOfTestImages)*100;                                         %calculate accuracy
    else
       [ weightVectorTest ] = trainImageWeights( TestImage,topEigenVectors,meanImage );         
       model = svmtrain(TrainLabel,weightVectorTrain','-t 0 -q');                                           %model using svm                          
       [~, accuracySVM, ~] = svmpredict( TestLabel, weightVectorTest', model,'-q');                 %predict
       accuracySubset=accuracySVM(1);
    end
    accuracy(i)= accuracySubset;
    disp(accuracy(i))
 end
 averageAccuracy=mean(accuracy);
end