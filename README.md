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
	4. SBMLSplit
	5. SBMLAnnotate

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
There is test data for each tool, and you also want to map folders into your
	docker runs so you can get the output back from the tools.  This is 
	done by using `-v /host/folder:/container/folder` and we will also
	tell it to run in the container's folder so that when the run is over
	all your output files come back out for you to look at.  We will do
	that with `-w /container/folder` noting it's the same place we are
	mounting into.  See examples below for this in practice.  Another thing
	to be aware of is that files will be owned by root when they come back
	out of the container.
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

### SBMLSplit
-------------------------------------------------------------------------------
There is test data in the /opt/SBMLSplit/ folder to test the tool with. To
	execute SBMLSplit you want to use `SBMLSplit <flag> <inputfile>` where
	your flag is `C` or `R`and the file is the file you want to split.
	Assuming the image was named sbmldock and you have a folder to mount
	in the image at /home/wjconn/SBMLDock/mount then you would use a
	command line like this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLSplit C /opt/SBMLSplit/one.xml

This will print out some information to the screen and in your mount folder you
	will end up with S0.xml and S1.xml files that are the split files. To
	use your own file with the tool, make sure it is in the mount directory
	and use a similar command line to this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLSplit C one.xml

### SBMLAnnotate
-------------------------------------------------------------------------------
There is test data in the /opt/SBMLAnnotate/ folder to test the tool with. To
	execute SBMLAnnotate you want to use `SBMLAnnotate <inputfile> <outputfile>`.
	Assuming the image was names sbmldock and you have a folder to mount
	in the image at /home/wjconn/SBMLDock/mount then you would use a
	command line like this:

	docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLAnnotate /opt/SBMLAnnotate/one.xml out.xml

This will put the out.xml file in your mount directory after it's finished. To
	use your own file with the tool, make sure it is in the mount directory
        and use a similar command line to this:

        docker run -v /home/wjconn/SBMLDock/mount:/tmp -w /tmp sbmldock SBMLAnnotate one.xml

## Credits

