# 🩸 Blood Type Classification Using Image Processing
📑 Project Overview
This project automates the classification of blood types using image processing techniques, developed in MATLAB. It provides a faster and more reliable method for blood group determination, aiming to minimize human error and reduce time in critical medical processes like blood transfusions.

## 🔍 Features
Pre-processing: RGB to grayscale conversion and image resizing.
Thresholding: Utilizes Otsu's method to separate foreground and background.
Morphological Operations: Erosion and dilation to refine image quality.
Segmentation: Divides images into three parts for blood type tests.
Quantification: Detects agglutination patterns to identify blood type.

## 📂 Project Structure
Main GUI: User interface created in MATLAB for easy image selection and processing.
Functions: MATLAB functions for each step (e.g., grayscale conversion, thresholding).
Output: Displays segmented images, blood type result, and intermediate processing steps.

## 🚀 How to Run
Run MATLAB GUI:
Open the DetOfBloodType GUI file.
Load an image with the "Input Image" button.
Process the Image:
Step through buttons: To Grayscale, Threshold, Do Erosion, and Segmentation.
Get Blood Type:
Click GetResult to classify the blood type based on detected agglutination patterns.
View Output:
Results are displayed on the GUI, with segmented images for each test and final blood type classification.

## 🛠️ Technologies Used
MATLAB R2021a

## 📚 References
"Digital Image Processing" - Gonzalez & Woods, 4th Edition.
MATLAB Documentation on Image Processing Toolbox.

## 🎓 Authors
Mohamad Ousseily
Karim Sleiman

## 📫 Contact
For questions or suggestions, reach out to the authors or send an e-mail on "karim.s2000@icloud.com"
