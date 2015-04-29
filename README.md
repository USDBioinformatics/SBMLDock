# SBMLDock
This is a dockerfile that builds a docker image that will allow you to run
	several SBML tools developed at The University of South Dakota.

## Info
The are several tools you can run from command line using the final docker
	image.  Check the Tools section for information on each tool in the 
	list and commands to run them.  We are also providing some test data
	to run them on,	but you can use your own data as well.
#### Tools List
-------------------------------------------------------------------------------
	1. ParaABioS
	2. SBMLChecker
	3. SBMLCompare
	4. SBMLMerge
	5. SBMLSplit
	6. SBMLModeler
	7. SBMLAnnotate

## Build the image
You need the Docker daemon installed on your system to use this.  Please see
	https://www.docker.com/ for information on installing the docker
	daemon on your system.

When you have the docker daemon installed, you can build the image with this
	command.  Make sure to navigate to the directory where you cloned this
	this repo first.  Depending on your system, you may need to use 'sudo'
	to issue docker commands.

	docker build -t sbmldock .

## Tools
There is test data for each tool and you also want to map folders into your
	running docker images so you can get the output back from the tools.
	This is done by using `-v /host/folder:/container/folder` and we will
	also tell it to run in the container's folder so that when the run is
	over all your output files come back out for you to look at.  We will
	do that with `-w /container/folder` noting it's the same place we are
	mounting into.  See examples below for this in practice.  Another thing
	to be aware of is that files will be owned by root when they come back
	out of the container.  So you may need root privileges to work with
	the output files.

### ParaABioS
-------------------------------------------------------------------------------
There is test data in the /opt/ParaABioS/ folder to test the tool on.  To
	execute ParaABioS you want to do `ParaABioS <inputfile1> <inputfile2> <distance> <ratio>`.
	Assuming the image was named sbmldock and you have a folder to mount
	in the image at /home/wjconn/SBMLDock/mount then you would use a
	command line like this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock ParaABioS /opt/ParaABioS/file1.txt /opt/ParaABioS/file2.txt 6 0.7

If you have your own files you wish to run the tool on, make sure to place
	the files in the folder you mount inside the container.  For me this
	would be inside the `/home/wjconn/SBMLDock/mount` folder.  It's the
	same place your output files show up when the container is done
	running.  That command line would look like this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock ParaABioS file1.txt file2.txt 6 0.7

### SBMLChecker
-------------------------------------------------------------------------------
There is test data in the /opt/SBMLChecker/ folder to test the tool with. To
	execute SBMLChecker you want to use `SBMLChecker <inputfile>`.
	Assuming the image was named sbmldock and you have a folder to mount
        in the image at /home/wjconn/SBMLDock/mount then you would use a
        command line like this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLChecker /opt/SBMLChecker/one.xml

There will be information printed to the screen and there will be the error
	report output files that show up in your mounted directory.  To
	use your own file, again, make sure it is in the mount directory
	and use a similar command line to this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLChecker one.xml

### SBMLCompare
-------------------------------------------------------------------------------
There is test data in the /opt/SBMLCompare/ folder to test the tool with. To
	execute SBMLCompare you want to use `SBMLCompare <inputfile1> <inputfile2>`.
	Assuming the image was named sbmldock and you have a folder to mount
	in the image at /home/wjconn/SBMLDock/mount then you would use a
	command line like this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLCompare /opt/SBMLCompare/one.xml /opt/SBMLCompare/two.xml

This will print a bunch of text to screen and there will be an excel file
	called `sbml_compare_report.xls` and a xml file called `sbml_compare_report.xml`
	created in the mount folder as output from the tool.  To use your own
	two files with the tool, make sure they are in the mount directory and
	use a similar command line to this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLCompare one.xml two.xml

### SBMLMerge
-------------------------------------------------------------------------------
There is test data in the /opt/SBMLMerge/ folder to test the tool with. To
	execute SBMLMerge you want to use `SBMLMerge <edit distance int[0-10]> <similarity ratio float[0-1]> <inputfile1> <inputfile2> <optional input files up to 6>`
	Assuming the image was named sbmldock and you have a folder to mount in
	the image at /home/wjconn/SBMLDock/mount then you owuld use a command
	line like this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLMerge 6 0.7 /opt/SBMLMerge/one.xml /opt/SBMLMerge/two.xml

This will print a lot of info to the screen and you will get a mergedmodel.xml
	file in your mounted directory.  To use your own data files, first put
	them in the directory your going to mount in the container and then use
	a command line similar to this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLMerge 6 0.7 one.xml two.xml


### SBMLSplit
-------------------------------------------------------------------------------
There is test data in the /opt/SBMLSplit/ folder to test the tool with. To
	execute SBMLSplit you want to use `SBMLSplit <flag> <inputfile>` where
	your flag is `C` or `R` to split on Compound or Reaciton and the file
	is the file you want to split. Assuming the image was named sbmldock
	and you have a folder to mount in the image at /home/wjconn/SBMLDock/mount
	then you would use a command line like this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLSplit C /opt/SBMLSplit/one.xml

This will print out some information to the screen and in your mount folder you
	will end up with S0.xml and S1.xml files that are the split files. To
	use your own file with the tool, make sure it is in the mount directory
	and use a similar command line to this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLSplit C one.xml

### SBMLModeler
-------------------------------------------------------------------------------
SBMLModeler pulls data it needs from multiple sources on the internet but you
	need to supply the pathway to the program on the command line. For a
	list of pathways to use, please check the Pathwayslist.txt file	by
	using `cat /opt/SBMLModeler/Pathwayslist.txt`.  Assuming your image is
	named sbmldock and you have a folder to mount in the image at
	/home/wjconn/SBMLDock/mount then you would use a command line like
	this to see the pathways:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock cat /opt/SBMLModeler/Pathwayslist.txt

Once you have your pathway picked out you can run SBMLModeler by using `SBMLModeler <Path to store file> <Pathway name>`.
	It's best to simple store the files in the directory we are in so they
	come back out of the container into the mount directory. So we will
	run it with a command line like this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLModeler . "folate biosynthesis"


### SBMLAnnotate
-------------------------------------------------------------------------------
There is test data in the /opt/SBMLAnnotate/ folder to test the tool with. To
	execute SBMLAnnotate you want to use `SBMLAnnotate <inputfile> <outputfile>`.
	Assuming the image was named sbmldock and you have a folder to mount
	in the image at /home/wjconn/SBMLDock/mount then you would use a
	command line like this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLAnnotate /opt/SBMLAnnotate/one.xml out.xml

This will put the out.xml file in your mount directory after it's finished. To
	use your own file with the tool, make sure it is in the mount directory
        and use a similar command line to this:

        docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLAnnotate one.xml

## Credits
-------------------------------------------------------------------------------
The University of South Dakota

