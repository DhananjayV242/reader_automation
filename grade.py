# Grader script for EECS 31L - Intro to Digital Logic Lab. 
# Author: Dhananjay Vijayaraghavan
# Date Modified: May 7 2024


import os
import sys
import subprocess
import glob

# Global variables

designGradingFolder = 'designGrading'
gradingTb = 'tb_with_rubric.v'
designFileList = ["FlipFlop.v", "InstMem.v", "RegFile.v", "ImmGen.v", "Mux.v", "ALU.v", "DataMem.v", "Datapath.v"]

tbGradingFolder = 'tbGrading'
tbFileList = []

failFile = 'failList.csv'
gradeFile = 'gradeList.csv'

manualGradingFolder = 'manualGrading'
expectedFileList = designFileList + tbFileList

# Function to confirm expected files present
def checkVerilogFiles(folder, expectList):

    filePattern = folder + "/*.v"
    print("filePattern: %s" % filePattern)
    output = glob.glob(filePattern)
    print(output)
    output = [filename.split("/")[-1] for filename in output]
    missList = []
    for expFile in expectList:
        if expFile not in output:
            missList.append(expFile)
        
    if missList:
        input("Files %s not found in %s... Check and fix manually" % (missList, folder))

# Function to copy files
def copyFiles(src, dest, fileList):
    for file in fileList:
        cpCmd = 'cp ' + src + "/" + file + ' ' + dest + "/"
        retCode = os.system(cpCmd)
        if retCode:
            raise Exception("Failed copying %s to grading folder" % (file))

# Function to extract the zipfile and find source code
def setupDesignGradingFolder(zipFile):

    submissionFolder = zipFile.split(".")[0]
    extractCmd = 'unzip -d' + submissionFolder + " " + zipFile
    retCode = os.system(extractCmd)
    if retCode:
        raise Exception("Extracting %s failed... Please check logs" % (zipFile))

    # Get source code directory.
    # This code is in case student submission contains 
    # subdirectories which contain the source code. 

    originalSubmissionFolder = submissionFolder
    found = False
    for root, dirs, files in os.walk(submissionFolder):
        print("Checking folder %s" % root)
        print("Files: %s" % files)
        for file in files:
            if file.endswith(".v"):
                submissionFolder = root
                found = True
        if found:
            break
    
    if " " in submissionFolder:
        tempName = submissionFolder.replace(" ", "_")
        mvCmd = "mv " + submissionFolder.replace(" ", "\ ") + " " + tempName
        retCode = os.system(mvCmd)
        if retCode:
            raise Exception("Renaming %s failed... Please check logs" % (submissionFolder))
        submissionFolder = tempName
    
    return submissionFolder, originalSubmissionFolder

# Function to grade the design
def gradeDesign(submissionFolder):
    
    print("New submission folder: %s" % submissionFolder)

    checkVerilogFiles(submissionFolder, expectList=expectedFileList)

    # Setup grading folder
    copyFiles(src=submissionFolder, dest=designGradingFolder, fileList=designFileList)

    # Grading the design files
    manual = False
    compileArgs = [designGradingFolder+"/"+file for file in designFileList]
    compileArgs.append(designGradingFolder+"/"+gradingTb)

    compileCmd = "iverilog " + " ".join(compileArgs)
    retCode = os.system(compileCmd) 
    if retCode:
        #disabling manual grading for lab4
        manual = False
        input("Compilation failed ... Check terminal for more information")
    else:
        runSim = subprocess.Popen("./a.out" , stdout=subprocess.PIPE)
        output, error = runSim.communicate()

        output = output.decode()
        print(output)

    # TODO: make functions seperate
    partGrade = 0
    if manual:
        # Setup grading folder
        copyFiles(src=submissionFolder, dest=manualGradingFolder, fileList=designFileList)
        testPairList = [[desFile, 'tb_'+desFile] for desFile in designFileList]

        for testPair in testPairList:

            # Grading the design files
            compileArgs = [manualGradingFolder+"/"+file for file in testPair]
            compileCmd = "iverilog " + " ".join(compileArgs)
            print(compileCmd)
            retCode = os.system(compileCmd) 
            if retCode:
                print("Compilation failed ... Check terminal for more information")

            else:
                runSim = subprocess.Popen("./a.out" , stdout=subprocess.PIPE)
                output, error = runSim.communicate()

                output = output.decode()
                print(output)
                os.system("rm a.out")
            partGrade += int(input("Enter grade for %s: " % (testPair[0])))
    
    print("Partial Grade for student: %d" % partGrade)
    designGrade = int(input("Enter Design grade for student: "))
    
    return designGrade

# Function to grade the design
def gradeTestbench(submissionFolder):
    
    print("New submission folder: %s" % submissionFolder)

    checkVerilogFiles(submissionFolder, expectList=expectedFileList)

    # Setup grading folder
    copyFiles(src=submissionFolder, dest=tbGradingFolder, fileList=tbFileList)

    for tbFile in tbFileList:

        # Prompt to add waveform dump in tb file
        print("Add waveform dump in testbench %s" % tbFile)
        input("Press Enter to continue")

        # Finding the design file by removing _tb from the tb file
        desFile = "".join(tbFile.split("_tb"))
        compileArgs = [tbGradingFolder+"/"+file for file in [tbFile, desFile]]
        compileCmd = "iverilog " + " ".join(compileArgs)

        retCode = os.system(compileCmd)
        if retCode:
            print("Compiling %s failed ... Check terminal for more information" % (tbFile))

        print("-------------")
        print("Simulating %s" % tbFile)
        print("-------------")
        os.system("./a.out")
        waveCmd = "gtkwave " + "test.vcd"
        os.system(waveCmd)

        input("Press Enter to continue")
    
    os.system("rm test.vcd a.out")
    tbGrade = int(input("Enter Testbench grade for student: "))
    return tbGrade

# Extracting the code. 

allFiles = os.listdir()
zipFiles = [file for file in allFiles if file.endswith(".zip")]

failFp = open(failFile, 'a')
csvHeader = 'Submission ID, Failure message\n'
failFp.write(csvHeader)

gradeFp = open(gradeFile, 'a')
csvHeader = 'Submission ID, Design Grade, Testbench Grade, Report Grade, Total Grade, Comments\n'
gradeFp.write(csvHeader)

for zipFile in zipFiles:

    print("############################################################")
    print("               Starting %s                       " % zipFile)
    print("############################################################\n\n")

    designGrade = 0
    tbGrade = 0
    reportGrade = 0
    autoFail = False

    # Extract zipfile and find source code
    try:
        submissionFolder, originalSubmissionFolder = setupDesignGradingFolder(zipFile=zipFile)
    except Exception as ex:
        print("Encountered exception while extracting source code for %s" % originalSubmissionFolder)
        csvStr = ','.join([originalSubmissionFolder, str(ex)]) + "\n" 
        failFp.write(csvStr)
        autoFail = True

    # Grading the design
    try:
        
        designGrade = gradeDesign(submissionFolder)
    except Exception as ex:
        print("Encountered exception while grading design for %s" % originalSubmissionFolder)
        csvStr = ','.join([originalSubmissionFolder, str(ex)]) + "\n" 
        failFp.write(csvStr)
        autoFail = True

    # Grading the testbench
    # try:
        
    #     tbGrade = gradeTestbench(submissionFolder)
    # except Exception as ex:
    #     print("Encountered exception while grading testbench for %s" % originalSubmissionFolder)
    #     csvStr = ','.join([originalSubmissionFolder, str(ex)]) + "\n" 
    #     failFp.write(csvStr)
    #     autoFail = True
    
    reportGrade = int(input("Enter the Report Grade for student: "))
    comments = input("Enter comments if any: ")

    if not autoFail:
        # Only add successful grading to the list
        totalGrade = designGrade + tbGrade + reportGrade
        gradeCsv = ','.join([originalSubmissionFolder, str(designGrade), str(tbGrade), str(reportGrade), str(totalGrade), comments]) + "\n"
        gradeFp.write(gradeCsv)


    # Remove the source code to save space. 
    removeCmd = "rm -rf " + originalSubmissionFolder
    print(removeCmd)
    retCode = os.system(removeCmd)
    if retCode:
        raise Exception("Removing directory %s failed... Please check logs" % (originalSubmissionFolder))

