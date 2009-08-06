$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module S3sync
  VERSION = '1.3.0'

  require 's3sync/s3try'
  require 's3sync/s3config'

  # after other mods, so we don't overwrite yaml vals with defaults
  include S3Config


  def S3sync.s3cmdList(bucket, path, max=nil, delim=nil, marker=nil, headers={})
    debug(max)
    options = Hash.new
    options['prefix'] = path # start at the right depth
    options['max-keys'] = max ? max.to_s : 100
    options['delimiter'] = delim if delim
    options['marker'] = marker if marker
    S3try(:list_bucket, bucket, options, headers)
  end

  # turn an array into a hash of pairs
  def S3sync.hashPairs(ar)
    ret = Hash.new
    ar.each do |item|
      name = (/^(.*?):/.match(item))[1]
      item = (/^.*?:(.*)$/.match(item))[1]
      ret[name] = item
    end if ar
    ret
  end
end


def debug(str)
  $stderr.puts str if $S3syncOptions['--debug']
end
