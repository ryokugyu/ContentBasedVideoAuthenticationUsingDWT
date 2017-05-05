+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
What is Content Based Video Authentication and why this?
With the rise of internet users, authentication of video owner and it's
integrity should be maintained. To provide these important features,
watermarking techniques are used.  Content Based Video Authentication
is a type of watermarking mechanism, in which the watermark to be embedded in the
video is taken from the video itself. No external watermark image or data is taken.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

System Requirements:

1. MATLAB 2013a
2. 1024 Mb of RAM( 2048 is recommended)
3. Disk space - 1 Gb for MATLAB only and 3-4 Gb for a typical installation
4. Windows 7 and above
5. Processor: Any Intel or AMD having X86 processor supporting SSE2 intruction set
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

How to execute/run?
 Step 1: Open MATLAB.
 Step 2: Go to the directory where source code is available in the computer.
 Step 3: First execute the SecretImageWriter file.
 Step 4: After executing the SecretImageWriter file, execute the mainFuntion.m file
         in the workspace.
 After the execution of mainFunction.m file, three windows will appear on the screen.
 As, Original Video - on which the embedding is performed.
     Embedded Video - video after embedding procedure.
     Watermark VIdeo - which contains the extracted watermark.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Directory Information:

Following files are present in the project 4.2.2017 directory:
** RGB_to_YUV.m -  converts the RGB frames into YUV frame .
** embeddingProcedure.m -  this contains the embedding algorithm code.
** extractionProcedure.m -  this contains the extraction alogrithm code.
** YUV_to_RGB.m -  converts the YUV frames back into the RGB frames.
** mainFunction.m - calls all the functions in a systematic and sequential manner.
** SecretImageWriter.m -  this will store the watermark image for viewing purpose only.

/Data directory contains the Original video
/Saved Videos directory will store the output videos.

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Author:
*******
Himanshu Nailwal <himanshunailwal.rhce@gmail.com>
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
