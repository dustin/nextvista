require 'rexml/document'

namespace :svn do
  ### FIXME: refactor this into a function called by create_branch/create_tag
  desc "Branch this workspace's SVN URL and revision to the name given in BRANCH_NAME or BRANCH_URL. Pass additional options via SVN_OPTS."
  task :create_branch do
    raise "You must set either BRANCH_NAME or BRANCH_URL environment variable" unless ENV['BRANCH_NAME'] || ENV['BRANCH_URL']
    svn_info = REXML::Document.new(`svn info --xml`)
    src_url  = svn_info.elements['//url'].text
    src_base = src_url.sub(/(trunk|(branches|tags)(\/.*)?)$/,'')
    src_rev  = svn_info.elements['//entry'].attributes['revision']
    dest_url = ENV['BRANCH_URL'] || "#{src_base}/branches/#{ENV['BRANCH_NAME']}"
    `svn cp -r #{src_rev} #{src_url} #{dest_url} #{ENV['SVN_OPTS']}`
  end
  task :branch => :create_branch
  
  ### FIXME: refactor this into a function called by create_branch/create_tag
  desc "Tag this workspace's SVN URL and revision to the name given in TAG_NAME or TAG_URL. Pass additional options via SVN_OPTS."
  task :create_tag do
    raise "You must set either TAG_NAME or TAG_URL environment variable" unless ENV['TAG_NAME'] || ENV['TAG_URL']
    svn_info = REXML::Document.new(`svn info --xml`)
    src_url  = svn_info.elements['//url'].text
    src_base = src_url.sub(/(trunk|(branches|tags)(\/.*)?)$/,'')
    src_rev  = svn_info.elements['//entry'].attributes['revision']
    dest_url = ENV['TAG_URL'] || "#{src_base}/tags/#{ENV['TAG_NAME']}"
    `svn cp -r #{src_rev} #{src_url} #{dest_url} #{ENV['SVN_OPTS']}`
  end
  task :tag => :create_tag
end