#Author; William Carey
#Student Id: C16315253
#Assignment 1

#import libraries
import pandas as pd
import csv

#create the keys that describe the features we are using to index
ContIndexes = ["age","fnlwgt","education-num","capital-gain","capital-loss","hours-per-week"]
CatIndexes = ["workclass","education","martial-status","occupation","relationship","race","sex","native-country","target"]

#create the writers to the files that we are working with
print("Creating the files to write to")
ConCSVFile = open("AssignmentDocs//C16315253Cont.csv","w",newline = "")
ConCSVWriter = csv.writer(ConCSVFile,delimiter = ',')
CatCSVFile = open("AssignmentDocs//C16315253Cat.csv","w",newline = "")
CatCSVWriter = csv.writer(CatCSVFile,delimiter = ',')

#Create the two headers to store our data
StandardColumnNames = ["FeatureName","Count","% Miss", "Card"]
ContinCSVFileHeaders = StandardColumnNames + ["Min","1st Qrt","Mean","Median","3rd Qrt","Max", "Std Dev"]
CatCSVFileHeaders = StandardColumnNames + ["Mode","Mode Freq","Mode %","2nd Mode","2nd Mode Freq","2nd Mode %"]

#reading and parsing the columns headers from the text file
print("Parsing the files")
columnsName = open(".//Data//feature_names.txt")
text_reader = columnsName.read()
dataFrame = pd.read_csv(".//Data//dataset.txt", header = None, na_values = ["?", " ?", "? "])
dataFrame.columns = text_reader.split("\n")

#dataFrame.head()
print("Writing the data to the files - please wait until complete")
#writing the headers to the files before we proceed to gather the data
ConCSVWriter.writerow(ContinCSVFileHeaders)
CatCSVWriter.writerow(CatCSVFileHeaders)

#filter out the features of the application for both categorical and continous
for key in dataFrame.columns:
    #variables for calculation purpose
    calulationCount = dataFrame[key].count()
    MissingCount = dataFrame[key].isnull().sum()
    Cardinal = len(dataFrame[key].unique())
    
    #variables for writing to csv file
    FeatureName = str(key)
    FeatureCount = str(calulationCount)
    FeatureMissingCount = str("%.2f" % ((MissingCount / calulationCount) * 100))
    CardinalFeature = str(Cardinal)
    
    if(key in CatIndexes):
        #getting the dict together
        FeatureDict = dict(dataFrame[key].value_counts())
        ModeNoCount = 0
        #variable to work with the first mode
        FirstModeElement = ""
        FirstModeCount = 0
        FirstModeFrequency = 0
        
        #second mode variables
        SecondModeElement = ""
        SecondModeCount = 0
        SecondModeFrequency = 0
        
        ModeDict = {}
        #iterate over dictionary to get the first two modes
        for DictKey in FeatureDict:
            ModeCount = FeatureDict[DictKey]
            if(ModeNoCount == 0):
                FirstModeElement = DictKey
                FirstModeCount = FeatureDict[DictKey]
                FirstModeFrequency = (int(ModeCount) / calulationCount) * 100 
            
            if(ModeNoCount == 1):
                SecondModeElement = DictKey
                SecondModeCount = FeatureDict[DictKey]
                SecondModeFrequency = (int(ModeCount) / calulationCount) * 100 
            
            ModeNoCount = ModeNoCount + 1
            if(ModeNoCount == 2):
                break
        #end inner for loop
    
        CatDataCollection = [FeatureName,FeatureCount,FeatureMissingCount,CardinalFeature,
                         str(FirstModeElement),str(FirstModeCount),
                         str("%.2f" % FirstModeFrequency), str(SecondModeElement),
                         str(SecondModeCount),str("%.2f" % SecondModeFrequency)]
        
        #writing the data to the file
        CatCSVWriter.writerow(CatDataCollection)
    #end collecting the category data
    
    #Now collecting the contin data features
    if(key in ContIndexes):
        Min = dataFrame[key].min()
        Max = dataFrame[key].max()
        Median = dataFrame[key].median()
        Mean = dataFrame[key].mean()
        FirstQrt = dataFrame[key].quantile(.25)
        ThirdQrt = dataFrame[key].quantile(.75)
        Std = dataFrame[key].std()
        
        ContDataCollection = [FeatureName,FeatureCount,FeatureMissingCount,CardinalFeature,
            str(Min),str(FirstQrt),str("%.2f" % Mean), str(Median),str(ThirdQrt),str(Max),
                              str("%.2f" % Std)]
        #writng the data to the contin
        ConCSVWriter.writerow(ContDataCollection)
    #end collecting the contin data
        
#end outer for loop

#close the files after writing 
ConCSVFile.close()
CatCSVFile.close()
print("Process has been completed")