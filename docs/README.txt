

Change Log:
-----------

2006-09-29:
Added support for --expires and --cache-control. Eg:
--expires="Thu, 01 Dec 2007 16:00:00 GMT"
--cache-control="no-cache"

Thanks to Charles for pointing out the need for this, and supplying a patch
proving that it would be trivial to add =) Apologies for not including the short
form (-e) for the expires. I have a rule that options taking arguments should
use the long form.
----------

2006-10-04
Several minor debugs and edge cases.
Fixed a bug where retries didn't rewind the stream to start over.
----------

2006-10-12
Version 1.0.5
Finally figured out and fixed bug of trying to follow local symlink-to-directory.
Fixed a really nasty sorting discrepancy that caused problems when files started
with the same name as a directory.
Retry on connection-reset on the S3 side.
Skip files that we can't read instead of dying.
----------

2006-10-12
Version 1.0.6
Some GC voodoo to try and keep a handle on the memory footprint a little better.
There is still room for improvement here.
----------

2006-10-13
Version 1.0.7
Fixed symlink dirs being stored to S3 as real dirs (and failing with 400)
Added a retry catch for connection timeout error.
(Hopefully) caught a bug that expected every S3 listing to contain results
----------

2006-10-14
Version 1.0.8
Was testing for file? before symlink? in localnode.stream. This meant that for
symlink files it was trying to shove the real file contents into the symlink
body on s3.
----------

2006-10-14
Version 1.0.9
Woops, I was using "max-entries" for some reason but the proper header is
"max-keys".  Not a big deal.
Broke out the S3try stuff into a separate file so I could re-use it for s3cmd.rb
----------

2006-10-16
Added a couple debug lines; not even enough to call it a version revision.
----------

2006-10-25
Version 1.0.10
UTF-8 fixes.
Catching a couple more retry-able errors in s3try (instead of aborting the
program).
----------

2006-10-26
Version 1.0.11
Revamped some details of the generators and comparator so that directories are
handled in a more exact and uniform fashion across local and S3. 
----------

2006-11-28
Version 1.0.12
Added a couple more error catches to s3try.
----------

2007-01-08
Version 1.0.13
Numerous small changes to slash and path handling, in order to catch several 
cases where "root" directory nodes were not being created on S3.
This makes restores work a lot more intuitively in many cases.
----------

2007-01-25
Version 1.0.14
Peter Fales' marker fix.
Also, markers should be decoded into native charset (because that's what s3
expects to see).
----------

2007-02-19
Version 1.1.0
*WARNING* Lots of path-handling changes. *PLEASE* test safely before you just
swap this in for your working 1.0.x version.

- Adding --exclude (and there was much rejoicing).
- Found Yet Another Leading Slash Bug with respect to local nodes. It was always
"recursing" into the first folder even if there was no trailing slash and -r
wasn't specified. What it should have done in this case is simply create a node
for the directory itself, then stop (not check the dir's contents).
- Local node canonicalization was (potentially) stripping the trailing slash,
which we need in order to make some decisios in the local generator.
- Fixed problem where it would prepend a "/" to s3 key names even with blank
prefix.
- Fixed S3->local when there's no "/" in the source so it doesn't try to create
a folder with the bucket name. 
- Updated s3try and s3_s3sync_mod to allow SSL_CERT_FILE
----------

2007-02-22
Version 1.1.1
Fixed dumb regression bug caused by the S3->local bucket name fix in 1.1.0
----------

2007-02-25
Version 1.1.2
Added --progress
----------

2007-06-02
Version 1.1.3
IMPORTANT!
Pursuant to http://s3sync.net/forum/index.php?topic=49.0 , the tar.gz now
expands into its own sub-directory named "s3sync" instead of dumping all the
files into the current directory.

In the case of commands of the form:
	s3sync -r somedir somebucket:
The root directory node in s3 was being stored as "somedir/" instead of "somedir"
which caused restores to mess up when you say:
	s3sync -r somebucket: restoredir
The fix to this, by coincidence, actually makes s3fox work even *less* well with 
s3sync.  I really need to build my own xul+javascript s3 GUI some day.

Also fixed some of the NoMethodError stuff for when --progress is used
and caught Errno::ETIMEDOUT
----------

2007-07-12
Version 1.1.4
Added Alastair Brunton's yaml config code.
----------

2007-11-17
Version 1.2.1
Compatibility for S3 API revisions.
When retries are exhausted, emit an error.
Don't ever try to delete the 'root' local dir.    
----------

2007-11-20
Version 1.2.2
Handle EU bucket 307 redirects (in s3try.rb)
--make-dirs added
----------

2007-11-20
Version 1.2.3
Fix SSL verification settings that broke in new S3 API.
----------

2008-01-06
Version 1.2.4
Run from any dir (search "here" for includes).
Search out s3config.yml in some likely places.
Reset connection (properly) on retry-able non-50x errors.
Fix calling format bug preventing it from working from yml.
Added http proxy support.
----------

2008-05-11
Version 1.2.5
Added option --no-md5
----------

2008-06-16
Version 1.2.6
Catch connect errors and retry.
----------

FNORD
