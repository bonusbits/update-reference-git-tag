require_relative 'update_git_release_tag/version'
require_relative 'update_git_release_tag/cli'

require 'fileutils'
require 'git'
require 'logger'
require 'optparse'
require 'pp'

module UpdateGitReleaseTag
  DESCRIPTION = 'Description'.freeze
  GET_ATT     = 'Fn::GetAtt'.freeze
  FIND_IN_MAP = 'Fn::FindInMap'.freeze
  BASE64      = 'Fn::Base64'.freeze
  JOIN        = 'Fn::Join'.freeze
  KEY         = 'Key'.freeze
  MAPPINGS    = 'Mappings'.freeze
  PROPERTIES  = 'Properties'.freeze
  REF         = 'Ref'.freeze
  RESOURCES   = 'Resources'.freeze
  PARAMETERS  = 'Parameters'.freeze
  METADATA    = 'Metadata'.freeze
  OUTPUTS     = 'Outputs'.freeze
  TAGS        = 'Tags'.freeze
  TYPE        = 'Type'.freeze
  VALUE       = 'Value'.freeze
  PROPAGATE_AT_LAUNCH = 'PropagateAtLaunch'.freeze
  VERSION = 'AWSTemplateFormatVersion'.freeze
  DELETION_POLICY = 'DeletionPolicy'.freeze
  UPDATE_POLICY = 'UpdatePolicy'.freeze
end
