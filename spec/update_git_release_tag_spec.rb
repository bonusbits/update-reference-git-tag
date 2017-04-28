require 'spec_helper'

describe UpdateGitReleaseTag do
  it 'has a version number' do
    expect(UpdateGitReleaseTag::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
