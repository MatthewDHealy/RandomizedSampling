# RandomizedSampling

Simple script that makes randomized samples from text files.  Comments in the code
explain how to do sampling with or without replacement.  Sample can be whatever
proportion of the text file you desire.

I use this script in several ways:

1. When doing exploratory analysis of a large data file, I make several random
samples and try ideas on these much smaller files instead of on the original
data.  Eventually, when I have settled on my final approach, I can run that
algorithm on the full data file once.  Or, sometimes, instead of running the
analysis on the full data file, I just repeat my analysis on multiple random
samples: if the results agree closely enough for my purposes then I am done.

2. To check for overfitting, I can fit a model on one sample, then test it on
independent samples of the original data.

3. Sometimes in Next-Gen-Sequence analysis (Illumina data), one wants to know,
"how much coverage do we need?"  I use a Perl one-liner to unwrap a fastq file
into a tab-delimited file with all four lines from each read on a single line.
Then I use the Linux paste command to combine the R1 and R2 read files into a
single file.  Use my script to randomly downsample the data.  The use cut to
pull out the R1 and R2 reads, and another Perl one-liner to make them back into
fastq files.  Then analyze the sample and see what the results look like with
fewer reads.

Distinctive aspects of this tool are:

1. Since it uses the SHA hashing algorithm, it can sample very large data
files efficiently, and its samples will be highly random.

2. It is *repeatable* and therefore *reproducible*: when run on the same data
file with the same seed string, it will generate the same output.

3. The line count and the line contents are used as input to the hash function,
so in the case of identical lines each instance will be independently chosen
or not chosen for the output.
