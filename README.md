Eigen-Faces
===========

This repository consists of the project done as part of the course  Statistical Methods in AI- Monsoon 2013. The course was instructed by [Dr. Anoop Nambodiri](http://faculty.iiit.ac.in/~anoop/)    

A detailed report is available <a href="https://drive.google.com/file/d/0B87x7EOOS4ztX0IzNnR6R3hTOXc/edit?usp=sharing", target="blank">here</a>    

##Requirements 
Matlab R2012a


##Problem
The goal of this project is to get familiarized with the state-of-the-art techniques for representation, identification and recognition of faces. We take the Information Theory approach, where the Principal Components of each of the face images are used to transform the faces into an Eigenface space. Once we get a new image, we project it on the Eigenface space, compare its position in this space with the position of known individuals, so as to perform face recognition, verification and reconstruction of faces as well as non faces. The experiment is done on Yale, CMU-PIE and our own class dataset.

The src folder consists of the following:

###Main Functions

readYaleImages.m   
Task:  This function is used to load the Yale Dataset.  
Input: It takes as input the resize value by which we want to resize the image in the Yale Dataset  
Output:It returns the image matrix, the labelmatrix and a vector containing the number of images 

readCMUImages.m  
Task:  This function is used to load the CMUPIE Dataset.  
Input: It doesn't takes any input  
Output:It returns the image matrix, the labelmatrix and a vector containing the number of images 

readAttendanceImages.m  
Task:  This function is used to load the S13SD.  
Input: It takes as input the resize value by which we want to resize the image in the S1DS3  
Output:It returns the image matrix, the labelmatrix and a vector containing the number of images 

faceIdentification.m  
Task:This is the main function which computes the average accuracy for the Yale or the CMU dataset using 4 fold cross validation using either KNN or SVM  
Input: It takes as input the number of top eigen vectors we want to check, the number of nearest neighbour, the number of classes the dataset has, the method which we want to use, the input data and the input label.  
Output:It returns the average accuracy

faceIdentificationAttendance.m  
Task:This is the main function which computes the average accuracy for the Yale or the CMU dataset hold one out validation using either KNN or SVM  
Input: It takes as input the number of top eigen vectors we want to check, the number of nearest neighbour, the number of classes the dataset has, the method which we want to use, the input data and the input label.  
Output:It returns the average accuracy

rocCurve.m  
Task: This function retuns the rocCurve and the optimal operating point threshold  
Input: It takes as input the Image Matrix, the Label Matrix and the number of Images in Each Class  
Output: It returns the theshold value along with displaying the ROC Curve.

faceVerification.m  
Task:This function reports average accuracy for image verification of the Yale and CMUPIE Dataset using four fold cross validation.  
Input: It takes as input the number of top eigen vectors we want to check, the number of nearest neighbour, the number of classes the dataset has, the method which we want to use, the input data and the input label.  
Output:It returns the average accuracy

faceVerificationAttendance.m  
Task:This function reports average accuracy for image verification for the students dataset using hold one outvalidation .  
Input: It takes as input the number of top eigen vectors we want to check, the number of nearest neighbour, the number of classes the dataset has, the method which we want to use, the input data and the input label.  
Output:It returns the average accuracy

reconstruction.m  
Task: It displays the original image and the image after applying PCA  
Input:This function takes as input the number of eigen vectors, the size by which we need to resize the test image and the Image Matrix for the training data.  
Output:It displays the images

###Helper Functions

findEigenVector.m  
Task: This function computes the eigen vectors of the images.  
Input: This function takes in input the image matrix   
Output:It returns the eigen vectors, the eigen values and the mean image.

topEigenVector.m  
Task: This function computes the top eigen vector.  
Input: It takes as input the eigenvectors, the eigen values and k  
Output: It returns the top k eigen vector.

findWeightVector.m  
Task: This function computes the eigen face for a single image.  
Input: This function takes as input a single image, the top k eigen vectors and the mean image  
Output: It returns the eigen face vector fo the given image.

trainImageWeights.m  
Task: This function computes the eigen faces. It uses the findWeightVector function.  
Input: It takes as input the top K Eigen Vector, the Image Matrix and the mean image.  
Output: It returns the Eigen Face matrix for the given image matrix.

fourFold.m  
Task: This function computes the training and the testing set by taking 75% off the input data as training data and 25% as testing data.  
Input: It takes the Image Matrix and the Label Matrix along with the choice for he fold we want and the number of classes in the image matrix.  
Output: It returns the matrices containing images for testing and training anfd label for training and testing.

holdoneout.m  
Task: This function is used to implement the strategy of hold one out.  
Input: It takes the Image Matrix and the Label Matrix along with the index of the image  we want to use as test and the number of classes in the image matrix.  
Output: It returns the matrix containing images for training, the test image and label matrix for training and testing label.

generatePairs.m  
Task: This function generates pairs of images. For each class it takes 5 images from the same class and 5 from the other class.   
Input: It takes as input the Image Matrix, the Label Matrix and the number of images in each class   
Output:It returns the pairs of images.

computeLabel.m  
Task:This function computes a label indicating yes or no for verification  
Input:This takes as input the entire image matrix, label matrix, a test image and claimed label  
Output:It returns the label as 1 if the distance of the image is less than threshold for any of image in the claimed class, else returns 0.

unknownFaceReconstruction.m    
Task: It displays the test image and reconsstructed image  
Input: This function takes as input the top eigen vectors, the size by which we need to resize the test image and the mean image of the training data.  
Output: It returns the eigen face of the test image and the image itself

pairwiseVerification.m    
Task: Find genuine and imposter pairs  
Input:It takes as input the pairs generated , the image matrix, the label matrix, the top eigen vectors and the mean image.  
Output:This function returns the threshold and the pairs of images along with image label of whether they are genuine or imposter.

findTopEigenVerification.m    
Task: This function finds the top k eigen vectors on the basis of their eigen values. We can also vary the number of eigen vectors which we want to exclude.  
Input: It takes as input, the Eigen Vectors, the Eigen Values and k   
Output: It returns the top Eigen Vectors.

knn.m  
Task: This function returns the label of the nearest match for the test image.  
Input: It takes as input the eigen faces for all the training data, the eigen face for the test data, the label for the training data, the number of top eigen vectors we are taking and the number of nearest neighbours we want to check.  
Output:It returns the predicted label for the test image.